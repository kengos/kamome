# frozen_string_literal: true

module Kamome
  class Configuration
    require 'tmpdir'

    # @!attribute [rw] tmp_path
    #   @return [String]
    attr_accessor :tmp_path

    # @!attribute [rw] open_uri_options
    #   OpenURI options
    #   @see https://docs.ruby-lang.org/ja/latest/class/OpenURI.html
    #   @return [Hash]
    attr_accessor :open_uri_options

    # @!attribute [rw] cleanup
    #   If you do not want to delete the downloaded csv, please specify `false`
    #   @return [Bolean]
    attr_accessor :cleanup

    def initialize
      @tmp_path = ::File.join(Dir.tmpdir, 'kamome')
      @open_uri_options = {}
      @cleanup = true
    end

    # @return [Pathname]
    def working_directory
      @working_directory ||= ::Pathname.new(@tmp_path.to_s)
    end
  end
end
