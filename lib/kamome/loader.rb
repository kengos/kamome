# frozen_string_literal: true

require 'kamome/downloader'
require 'kamome/csv_handler'

module Kamome
  class Loader
    def initialize(config:)
      @config = config
    end

    def call(operation:, &block)
      csv_handler = build_csv_handler(operation)

      operation.urls.each do |url|
        csv_path = download(url)
        csv_handler.call(csv_path, &block)
        csv_path.delete
      end
    end

    private

    def download(url)
      downloader.run(url: url)
    end

    def downloader
      @downloader ||= ::Kamome::Downloader.new(@config)
    end

    def build_csv_handler(operation)
      ::Kamome::CsvHandler.new(operation)
    end
  end
end
