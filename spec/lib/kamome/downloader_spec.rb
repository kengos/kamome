# frozen_string_literal: true

require 'spec_helper'
require 'kamome/downloader'

RSpec.describe Kamome::Downloader do
  let(:downloader) { described_class.new(config) }
  let(:config) do
    Kamome::Configuration.new.tap do |o|
      o.tmp_path = tmp_path
    end
  end

  describe '#run' do
    subject(:run) do
      ::VCR.use_cassette(cassette_name) do
        downloader.run(url: url)
      end
    end

    context 'when ken_all.zip url' do
      let(:url) { 'https://www.post.japanpost.jp/zipcode/dl/kogaki/zip/ken_all.zip' }
      let(:cassette_name) { ::File.join('downloader', 'ken_all.zip') }

      it 'download zipfile and get CSV converted to UTF-8' do
        csv_path = run
        line = ::File.open(csv_path, &:gets)
        expect(line).to be_include 'ホッカイドウ'
      end
    end

    context 'when ken_all.zip url' do
      let(:url) { 'https://www.post.japanpost.jp/zipcode/dl/jigyosyo/zip/jigyosyo.zip' }
      let(:cassette_name) { ::File.join('downloader', 'jigyosyo.zip') }

      it 'download zipfile and get CSV converted to UTF-8' do
        csv_path = run
        line = ::File.open(csv_path, &:gets)
        expect(line).to be_include '北海道'
      end
    end

    context 'when 404 content url' do
      let(:url) { 'https://www.post.japanpost.jp/zipcode/dl/kogaki/zip/sssss' }
      let(:cassette_name) { ::File.join('downloader', 'content_404') }

      it 'raise Kamome::DownloadError' do
        expect { run }.to raise_error Kamome::DownloadError, 'OpenURI::HTTPError: 404 Not Found'
      end
    end

    context 'when net readtimeout error' do
      let(:url) { 'https://www.post.japanpost.jp/zipcode/dl/kogaki/zip/ken_all.zip' }
      let(:cassette_name) { ::File.join('downloader', 'timeout_error') }

      it 'raise Kamome::DownloadError' do
        config.open_uri_options = { read_timeout: 0 }
        expect { run }.to raise_error Kamome::DownloadError, 'Net::ReadTimeout: Net::ReadTimeout'
      end
    end
  end
end
