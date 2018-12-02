# frozen_string_literal: true

require 'spec_helper'
require 'kamome/csv_handler'

RSpec.describe Kamome::CsvHandler do
  let(:csv_handler) { described_class.new(operation) }

  describe '#call' do
    subject(:results) do
      [].tap do |arr|
        csv_handler.call(csv_path) do |model, _|
          arr << model
        end
      end
    end

    context 'when operation type: :default, genre: :general' do
      let(:operation) { Kamome::Operation.general_all(type: :default) }
      let(:csv_path) { file_fixture('general_sample.csv') }

      it { expect(results.size).to eq csv_path.read.split("\n").size }
      it { expect(results[0]).to be_is_a ::Kamome::Models::Address }
    end

    context 'when operation type: :detail, genre: :general' do
      let(:operation) { Kamome::Operation.general_all(type: :detail) }
      let(:csv_path) { file_fixture('general_sample.csv') }

      it { expect(results.size).to eq csv_path.read.split("\n").size }
      it { expect(results[0]).to be_is_a ::Kamome::Models::General }
    end

    context 'when operation type: :default, genre: :jigyosho' do
      let(:operation) { Kamome::Operation.jigyosho_all(type: :default) }
      let(:csv_path) { file_fixture('jigyosho_sample.csv') }

      it { expect(results.size).to eq csv_path.read.split("\n").size }
      it { expect(results[0]).to be_is_a ::Kamome::Models::Address }
    end

    context 'when operation type: :detail, genre: :jigyosho' do
      let(:operation) { Kamome::Operation.jigyosho_all(type: :detail) }
      let(:csv_path) { file_fixture('jigyosho_sample.csv') }

      it { expect(results.size).to eq csv_path.read.split("\n").size }
      it { expect(results[0]).to be_is_a ::Kamome::Models::Jigyosho }
    end
  end

  describe '#skip?' do
    subject(:results) do
      [].tap do |arr|
        csv_handler.call(csv_path) do |model, _|
          arr << model
        end
      end
    end

    let(:csv_path) { file_fixture('general_skip_sample.csv') }
    let(:attributes) do
      {
        code: '02405', zipcode: '0330071', prefecture: '青森県',
        city: '上北郡六戸町', town: '犬落瀬',
        state: 0, ambiguous_town: true
      }
    end

    context 'when operation type: :default' do
      let(:operation) { Kamome::Operation.general_all(type: :default) }
      let(:csv_path) { file_fixture('general_skip_sample.csv') }

      it { expect(results.size).to eq 1 }

      it 'The data of `ambiguous_town: true` is not included in the result' do
        expect(results.first).to have_attributes(attributes)
      end
    end

    context 'when operation type: :detail' do
      let(:operation) { Kamome::Operation.general_all(type: :default) }
      let(:csv_path) { file_fixture('general_skip_sample.csv') }

      it { expect(results.size).to eq 1 }

      it 'The data of `ambiguous_town: true` is not included in the result' do
        expect(results.first).to have_attributes(attributes)
      end
    end
  end

  describe '#transform' do
    subject(:transform) { csv_handler.send(:transform, []) }

    context 'when operation type: Kamome::Operation::TYPE_DEFAULT' do
      let(:operation) { Kamome::Operation.general_all(type: Kamome::Operation::TYPE_DEFAULT) }

      it 'call generate_model method' do
        expect(csv_handler.send(:transformer)).to receive(:generate_model)
        transform
      end
    end

    context 'when operation type: Kamome::Operation::TYPE_DETAIL' do
      let(:operation) { Kamome::Operation.general_all(type: Kamome::Operation::TYPE_DETAIL) }

      it 'call generate_detail_model method' do
        expect(csv_handler.send(:transformer)).to receive(:generate_detail_model)
        transform
      end
    end
  end
end
