# frozen_string_literal: true

require 'spec_helper'
require 'kamome/cli'

RSpec.describe Kamome::Cli, slow: true do
  subject(:start) do
    ::VCR.use_cassette(File.join('cli', cassette_name)) do
      described_class.start(params)
    end
  end

  let(:cassette_name) { generated_file.basename }

  describe '#generate_csv' do
    let(:params) do
      ['generate_csv', generated_file.to_s, '--no-header']
    end
    let(:generated_file) { tmp_path.join('test_all.csv') }

    it 'generate csv to tmp/test.csv' do
      expect { start }.to output("Generated csv: #{generated_file}\n").to_stdout
      expect(generated_file).to be_exist
      expect(generated_file.open(&:gets)).not_to be_include 'code,zipcode'
    end
  end

  describe '#generate_diff_csv' do
    let(:params) do
      ['generate_diff_csv', generated_file.to_s, '--date=1811']
    end
    let(:generated_file) { tmp_path.join('test_diff.csv') }

    it 'generate tmp/test_diff.csv' do
      expect { start }.to output("Generated diff csv: #{generated_file}\n").to_stdout
      expect(generated_file).to be_exist
      expect(generated_file.open(&:gets)).to be_include 'code,zipcode'
    end
  end

  describe '#generate_json' do
    let(:params) do
      ['generate_json', generated_file.to_s]
    end
    let(:generated_file) { tmp_path.join('test_all.json') }

    it 'generate tmp/test_all.json' do
      expect { start }.to output("Generated json: #{generated_file}\n").to_stdout
      expect(generated_file).to be_exist
    end
  end

  describe '#generate_diff_json' do
    let(:params) do
      ['generate_diff_json', generated_file.to_s, '--date=1811']
    end
    let(:generated_file) { tmp_path.join('test_diff.json') }

    it 'generate tmp/test_diff.json' do
      expect { start }.to output("Generated diff json: #{generated_file}\n").to_stdout
      expect(generated_file).to be_exist
    end
  end
end
