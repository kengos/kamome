# frozen_string_literal: true

module Kamome
  class Downloader
    require 'open-uri'
    require 'securerandom'
    require 'fileutils'
    require 'zip'
    require 'nkf'

    def initialize(config)
      @config = config
    end

    # @return [Pathname] CSV file path
    def run(url:)
      zip_path = download(url)
      csv_path = unpack(zip_path)
      zip_path.delete
      csv_path
    rescue StandardError => e
      raise Kamome::DownloadError, "#{e.class}: #{e.message}"
    end

    private

    # @return [Pathname] downloaded file
    def download(url)
      dest = @config.working_directory.join(SecureRandom.hex(8) + '.zip')
      ::FileUtils.mkdir_p(dest.dirname)

      ::OpenURI.open_uri(url, @config.open_uri_options) do |response|
        ::File.binwrite(dest, response.read)
      end
      dest
    end

    def unpack(src)
      # convert encoding Shift_JIS to UTF-8 (and half width Katakana to full width Katakana)
      content = ::NKF.nkf('-w -Lu', take_csv_entry(src).get_input_stream.read)

      dest = src.sub('.zip', '.csv')
      ::File.binwrite(dest, content)
      dest
    end

    def take_csv_entry(src)
      entry = ::Zip::File.open(src) do |zipfile|
        zipfile.select { |o| o.name =~ /.*\.csv/i }.first
      end
      raise ::Kamome::DownloadError, 'Not found csvfile in zipfile' if entry.nil?

      entry
    end
  end
end
