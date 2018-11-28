# frozen_string_literal: true

module Kamome
  class Configuration
    require 'securerandom'
    require 'tmpdir'

    attr_accessor :tmp_path
    attr_accessor :open_uri_options

    def initialize
      @tmp_path = ::File.join(Dir.tmpdir, 'kamome', SecureRandom.hex(8))
      @open_uri_options = {}
    end

    def working_directory
      @working_directory ||= ::Pathname.new(@tmp_path.to_s)
    end
  end
end
