# frozen_string_literal: true

require 'kamome/version'
require 'kamome/configuration'
require 'kamome/loader'
require 'kamome/operation'

module Kamome
  class Error < StandardError; end
  class ArgumentError < StandardError; end
  class DownloadError < Error; end

  class << self
    def configure
      yield(configuration)
    end

    # Import ken_all.zip
    # @param [Symbol] type :default, :hash, :detail
    # @example
    #   Kamome.import_general_all do |model, lineno|
    #     # do something
    #   end
    def import_general_all(type: Operation::TYPE_DEFAULT, &block)
      operation = ::Kamome::Operation.general_all(type: type)
      loader.call(operation: operation, &block)
    end

    # Import add_yymm.zip and del_yymm.zip
    # @param [Time] date
    # @param [Symbol] type :default, :hash, :detail
    # @example
    #   Kamome.import_general_diff do |model, lineno|
    #     # do something
    #   end
    def import_general_diff(date:, type: Operation::TYPE_DEFAULT, &block)
      operation = ::Kamome::Operation.general_diff(date: date, type: type)
      loader.call(operation: operation, &block)
    end

    # Import jigyosyo.zip
    # @param [Symbol] type :default, :hash, :detail
    # @example
    #   Kamome.import_jigyosho_all do |model, lineno|
    #     # do something
    #   end
    def import_jigyosho_all(type: Operation::TYPE_DEFAULT, &block)
      operation = ::Kamome::Operation.jigyosho_all(type: type)
      loader.call(operation: operation, &block)
    end

    # Import jadd#{yymm}.zip and jdel#{yymm}.zip
    # @param [Time] date
    # @param [Symbol] type :default, :hash, :detail
    # @example
    #   Kamome.import_jigyosho_all do |model, lineno|
    #     # do something
    #   end
    def import_jigyosho_diff(date:, type: Operation::TYPE_DEFAULT, &block)
      operation = ::Kamome::Operation.jigyosho_diff(date: date, type: type)
      loader.call(operation: operation, &block)
    end

    def loader
      Kamome::Loader.new(config: configuration)
    end

    private

    def configuration
      @configuration ||= Kamome::Configuration.new
    end
  end
end
