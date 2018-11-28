# frozen_string_literal: true

require 'spec_helper'
require 'kamome/models/jigyosho'

RSpec.describe Kamome::Models::Jigyosho do
  describe '#initialize' do
    subject(:address) do
      described_class.new(params)
    end

    let(:params) { { japanpost_office_name: 'dummy', code: '12345' } }

    it { is_expected.to have_attributes(japanpost_office_name: 'dummy', code: '12345') }
  end

  describe '#attributes' do
    subject(:attributes) do
      described_class.new(params).attributes
    end

    let(:params) do
      {
        code: '00000',
        company_name_kana: 'アアアア',
        company_name: '嗚呼嗚呼',
        prefecture: '北海道',
        city: '札幌市東区',
        town: '伊伊伊伊',
        street: '０丁目０番０号',
        zipcode: '0650000',
        post_office_box: '私書箱',
        japanpost_office_name: '札幌東',
        has_post_office_box: false,
        multiple: 0,
        state: 1
      }
    end

    it { is_expected.to eq params }
  end
end
