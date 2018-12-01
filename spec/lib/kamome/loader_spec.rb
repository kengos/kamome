# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Kamome::Loader do
  let(:loader) { described_class.new(config: config) }
  let(:config) do
    Kamome::Configuration.new.tap do |o|
      o.tmp_path = tmp_path
    end
  end

  describe '#call' do
    subject(:do_call) do
      ::VCR.use_cassette(cassette_name) do
        loader.call(operation: operation)
      end
    end

    context 'when all operation' do
      let(:operation) { Kamome::Operation.jigyosho_all(type: :detail) }
      let(:cassette_name) { ::File.join('loader', 'jigyosho_all.zip') }

      it { is_expected.to be_is_a Array }
      it { expect(do_call.size).to eq 1 }
    end

    context 'when diff operation' do
      let(:date) { Time.local(2018, 11) }
      let(:operation) { Kamome::Operation.general_diff(date: date, type: :hash) }
      let(:cassette_name) { ::File.join('loader', 'general_diff.zip') }

      it { is_expected.to be_is_a Array }
      it { expect(do_call.size).to eq 2 }
    end
  end

  describe '#call_csv_handler' do
    subject(:call_csv_handler) { loader.send(:call_csv_handler, operation, csv_path) }

    before do
      FileUtils.cp sample_file_path, csv_path
    end

    after do
      csv_path.delete if csv_path.exist?
    end

    let(:sample_file_path) { file_fixture('general_sample.csv') }
    let(:csv_path) { tmp_path.join('general_sample.csv') }
    let(:operation) { Kamome::Operation.general_all }

    context 'when cleanup option is true' do
      before do
        config.cleanup = true
        call_csv_handler
      end

      it 'delete csv file' do
        expect(csv_path).not_to be_exist
      end
    end

    context 'when cleanup option is false' do
      before do
        config.cleanup = false
        call_csv_handler
      end

      it 'delete csv file' do
        expect(csv_path).to be_exist
      end
    end

    it 'return digest of csv file' do
      digest = Digest::SHA256.file(csv_path).to_s
      expect(call_csv_handler).to eq digest
    end
  end
end
