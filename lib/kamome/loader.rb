# frozen_string_literal: true

require 'kamome/downloader'
require 'kamome/csv_handler'
require 'digest'

module Kamome
  class Loader
    def initialize(config:)
      @config = config
    end

    # @params [Operation] Kamome::Operation
    # @yield [model, lineno] Any logic you want to execute
    #    Don't pass `-> { break }`, use `-> { throw :break }
    # @return [Array] csv digest
    def call(operation:, &block)
      operation.urls.map do |url|
        csv_path = download(url)
        call_csv_handler(operation, csv_path, &block)
      end
    end

    private

    def download(url)
      downloader.run(url: url)
    end

    def downloader
      @downloader ||= ::Kamome::Downloader.new(@config)
    end

    def call_csv_handler(operation, csv_path, &block)
      catch(:break) do
        ::Kamome::CsvHandler.new(operation).call(csv_path, &block)
      end
      ::Digest::SHA256.file(csv_path).to_s
    ensure
      csv_path.delete if @config.cleanup
    end
  end
end
