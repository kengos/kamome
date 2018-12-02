# frozen_string_literal: true

require 'spec_helper'
require 'kamome/transformations/general_csv'

RSpec.describe Kamome::Transformations::GeneralCsv do
  let(:row) do
    [
      '22101', '422  ', '4220000', 'シズオカケン', 'シズオカシ', 'イカニケイサイガナイバアイ',
      '静岡県', '静岡市葵区', '以下に掲載がない場合',
      '0', '0', '0', '1', '0', '0'
    ]
  end

  let(:expected_hash) do
    {
      code: '22101',
      zipcode: '4220000',
      prefecture_kana: 'シズオカケン',
      city_kana: 'シズオカシ',
      town_kana: '',
      prefecture: '静岡県',
      city: '静岡市葵区',
      town: '',
      ambiguous_town: false,
      ambiguous_street: false,
      required_chome: false,
      ambiguous_zipcode: true,
      state: 0,
      reason: 0
    }
  end

  let(:builder) { described_class.new }

  describe '#generate_hash' do
    subject(:address) { builder.generate_hash(row) }

    it { is_expected.to eq expected_hash }
  end

  describe '#generate_detail_model' do
    subject(:address) { builder.generate_detail_model(row) }

    it { expect(address.attributes).to eq expected_hash }
  end

  describe '#generate_model' do
    subject(:address) { builder.generate_model(row) }

    let(:expected_hash) do
      {
        code: '22101',
        zipcode: '4220000',
        prefecture: '静岡県',
        city: '静岡市葵区',
        town: '',
        street: '',
        company_name: '',
        post_office_box: '',
        state: 0,
        ambiguous_town: false
      }
    end

    it { expect(address.attributes).to eq expected_hash }
  end
end
