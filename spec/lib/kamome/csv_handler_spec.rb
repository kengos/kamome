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

    context 'when operation type: :hash, genre: :general' do
      let(:operation) { Kamome::Operation.general_all(type: :hash) }
      let(:csv_path) { file_fixture('general_sample.csv') }

      it { expect(results.size).to eq csv_path.read.split("\n").size }
      it { expect(results[0]).to be_is_a Hash }
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

    context 'when operation type: :hash, genre: :jigyosho' do
      let(:operation) { Kamome::Operation.jigyosho_all(type: :hash) }
      let(:csv_path) { file_fixture('jigyosho_sample.csv') }

      it { expect(results.size).to eq csv_path.read.split("\n").size }
      it { expect(results[0]).to be_is_a Hash }
    end

    context 'when operation type: :detail, genre: :jigyosho' do
      let(:operation) { Kamome::Operation.jigyosho_all(type: :detail) }
      let(:csv_path) { file_fixture('jigyosho_sample.csv') }

      it { expect(results.size).to eq csv_path.read.split("\n").size }
      it { expect(results[0]).to be_is_a ::Kamome::Models::Jigyosho }
    end
  end
end
