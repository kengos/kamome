# frozen_string_literal: true

require 'spec_helper'
require 'kamome/transformations/jigyosho_csv'

RSpec.describe Kamome::Transformations::JigyoshoCsv do
  let(:transformer) { described_class.new }
  let(:row) do
    [
      '00000', 'アアアア', '嗚呼嗚呼', '北海道', '札幌市東区', '伊伊伊伊',
      '０丁目０番地（ああああ郵便局私書箱第０００号）', '0650000', '065  ', '札幌東', '1', '0', '5'
    ]
  end
  let(:expected_hash) do
    {
      code: '00000',
      company_name_kana: 'アアアア',
      company_name: '嗚呼嗚呼',
      prefecture: '北海道',
      city: '札幌市東区',
      town: '伊伊伊伊',
      street: '０丁目０番地',
      post_office_box: 'ああああ郵便局私書箱第０００号',
      zipcode: '0650000',
      japanpost_office_name: '札幌東',
      has_post_office_box: true,
      multiple: 0,
      state: 5
    }
  end

  describe '#generate_hash' do
    subject(:hash) { transformer.generate_hash(row) }

    it { is_expected.to eq expected_hash }
  end

  describe '#generate_detail_model' do
    subject(:model) { transformer.generate_detail_model(row) }

    it { expect(model.attributes).to eq expected_hash }
  end

  describe '#generate_model' do
    subject(:model) { transformer.generate_model(row) }

    let(:expected_hash) do
      {
        code: '00000',
        company_name: '嗚呼嗚呼',
        prefecture: '北海道',
        city: '札幌市東区',
        town: '伊伊伊伊',
        street: '０丁目０番地',
        post_office_box: 'ああああ郵便局私書箱第０００号',
        zipcode: '0650000',
        state: 2,
        ambiguous_town: false
      }
    end

    it { expect(model.attributes).to eq expected_hash }
  end
end
