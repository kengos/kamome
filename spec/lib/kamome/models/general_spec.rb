# frozen_string_literal: true

require 'spec_helper'
require 'kamome/models/general'

RSpec.describe Kamome::Models::General do
  describe '#initialize' do
    subject(:address) do
      described_class.new(params)
    end

    let(:params) { { reason: 1, code: '12345' } }

    it { is_expected.to have_attributes(reason: 1, code: '12345') }
  end

  describe '#attributes' do
    subject(:attributes) do
      described_class.new(params).attributes
    end

    let(:params) do
      {
        code: '13228',
        zipcode: '1900172',
        prefecture_kana: 'トウキョウト',
        city_kana: 'アキルノシ',
        town_kana: 'フカサワ',
        prefecture: '東京都',
        city: 'あきる野市',
        town: '深沢',
        ambiguous_town: false,
        ambiguous_street: false,
        required_chome: false,
        ambiguous_zipcode: false,
        state: false,
        reason: false
      }
    end

    it { is_expected.to eq params }
  end
end
