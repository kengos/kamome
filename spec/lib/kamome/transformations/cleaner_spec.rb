# frozen_string_literal: true

require 'spec_helper'
require 'kamome/transformations/cleaner'

RSpec.describe Kamome::Transformations::Cleaner do
  describe '#clean_town' do
    subject { described_class.clean_town(value) }

    context 'when default case' do
      let(:value) { 'あいうえお' }

      it { is_expected.to eq 'あいうえお' }
    end

    context 'when include (.+)' do
      let(:value) { 'あいうえお（１３６〜１４４番地）' }

      it { is_expected.to eq 'あいうえお' }
    end

    context 'when include .+（次のビルを除く）' do
      let(:value) { 'あいうえお（次のビルを除く）' }

      it { is_expected.to eq 'あいうえお' }
    end

    context 'when include .+（地階・階層不明）' do
      let(:value) { 'あいうえお（地階・階層不明）' }

      it { is_expected.to eq 'あいうえお' }
    end

    context 'when include (.+階)' do
      let(:value) { 'あいうえお（１階）' }

      it { is_expected.to eq value }
    end

    context 'when 以下に掲載がない場合' do
      let(:value) { '以下に掲載がない場合' }

      it { is_expected.to eq '' }
    end

    context 'when .+の次に番地がくる場合' do
      let(:value) { 'あいうえおの次に番地がくる場合' }

      it { is_expected.to eq '' }
    end

    context 'when .+一円' do
      let(:value) { 'あいうえお一円' }

      it { is_expected.to eq '' }
    end
  end

  describe '#clean_town_kan' do
    subject { described_class.clean_town_kana(value) }

    context 'when default case' do
      let(:value) { 'アイウエオ' }

      it { is_expected.to eq 'アイウエオ' }
    end

    context 'when include (.+)' do
      let(:value) { 'アイウエオ(136-144バンチ)' }

      it { is_expected.to eq 'アイウエオ' }
    end

    context 'when include .+(ツギノビルヲノゾク)' do
      let(:value) { 'アイウエオ(ツギノビルヲノゾク)' }

      it { is_expected.to eq 'アイウエオ' }
    end

    context 'when include .+(チカイ・カイソウフメイ)' do
      let(:value) { 'アイウエオ(チカイ・カイソウフメイ)' }

      it { is_expected.to eq 'アイウエオ' }
    end

    context 'when include (.+カイ)' do
      let(:value) { 'アイウエオ(1カイ)' }

      it { is_expected.to eq value }
    end

    context 'when イカニケイサイガナイバアイ' do
      let(:value) { 'イカニケイサイガナイバアイ' }

      it { is_expected.to eq '' }
    end

    context 'when .+ノツギニバンチガクルバアイ' do
      let(:value) { 'アイウエオノツギニバンチガクルバアイ' }

      it { is_expected.to eq '' }
    end

    context 'when .+イチエン' do
      let(:value) { 'アイウエオイチエン' }

      it { is_expected.to eq '' }
    end
  end
end
