# frozen_string_literal: true

require 'spec_helper'
require 'kamome/transformations/extractor'

RSpec.describe Kamome::Transformations::Extractor do
  describe '.extract_street' do
    subject { described_class.extract_street(value) }

    context 'when .+' do
      let(:value) { '０番０号あああああタワーＢ' }

      it { is_expected.to eq value }
    end

    context 'when .+（.+私書箱第.+号）' do
      let(:value) { '０丁目０番地（ああああ郵便局私書箱第０００号）' }

      it { is_expected.to eq '０丁目０番地' }
    end
  end

  describe '.extract_post_office_box' do
    subject { described_class.extract_post_office_box(value) }

    context 'when .+' do
      let(:value) { '０番０号あああああタワーＢ' }

      it { is_expected.to eq '' }
    end

    context 'when .+（.+私書箱第.+号）' do
      let(:value) { '０丁目０番地（ああああ郵便局私書箱第０００号）' }

      it { is_expected.to eq 'ああああ郵便局私書箱第０００号' }
    end
  end
end
