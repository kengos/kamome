# frozen_string_literal: true

require 'thor'
require 'kamome'
require 'pathname'

module Kamome
  class Cli < ::Thor
    option :header, type: :boolean, default: true, desc: 'Include headers'
    desc 'generate_csv', 'Genrate CSV from KEN_ALL.CSV and JIGYOSHO.CSV'
    def generate_csv(filepath)
      path = ::Pathname.new(filepath)
      do_generate_csv(operation_all, path, options[:header])
      $stdout.puts "Generated csv: #{path}"
    rescue StandardError => e
      path.delete if path&.exist?
      raise e
    end

    option :header, type: :boolean, default: true, desc: 'Include headers'
    option :date, type: :string, default: nil, desc: 'Target date'
    desc 'generate_diff_csv', 'Genrate diff CSV from ADD_YYMM.CSV/DEL_YYMM.CSV/JADDYYMM.CSV/JDELYYMM.CSV'
    def generate_diff_csv(filepath)
      path = ::Pathname.new(filepath)
      do_generate_csv(operation_diff(options[:date]), path, options[:header])
      $stdout.puts "Generated diff csv: #{path}"
    rescue StandardError => e
      path.delete if path&.exist?
      raise e
    end

    desc 'generate_json', 'Genrate JSON from KEN_ALL.CSV and JIGYOSHO.CSV'
    def generate_json(filepath)
      path = ::Pathname.new(filepath)
      do_generate_json(operation_all, path)
      $stdout.puts "Generated json: #{path}"
    end

    option :date, type: :string, default: nil, desc: 'Target date'
    desc 'generate_diff_json', 'Genrate diff JSON from ADD_YYMM.CSV/DEL_YYMM.CSV/JADDYYMM.CSV/JDELYYMM.CSV'
    def generate_diff_json(filepath)
      path = ::Pathname.new(filepath)
      do_generate_json(operation_diff(options[:date]), path)
      $stdout.puts "Generated diff json: #{path}"
    rescue StandardError => e
      path.delete if path&.exist?
      raise e
    end

    private

    def operation_all
      [
        ::Kamome::Operation.general_all,
        ::Kamome::Operation.jigyosho_all
      ]
    end

    def operation_diff(date)
      require 'date'
      date ||= Date.today << 1
      [
        ::Kamome::Operation.general_diff(date: date),
        ::Kamome::Operation.jigyosho_diff(date: date)
      ]
    end

    def do_generate_csv(operations, path, header)
      require 'csv'
      ::CSV.open(path, 'w') do |csv|
        csv << csv_headers if header
        operations.each do |operation|
          Kamome.loader.call(operation: operation) do |model|
            csv << build_pretty_attributes(model).values
          end
        end
      end
    end

    def do_generate_json(operations, path)
      require 'json'
      json = {}
      operations.each do |operation|
        Kamome.loader.call(operation: operation) do |model|
          json[model.zipcode] ||= []
          json[model.zipcode] << build_pretty_attributes(model)
        end
      end
      ::File.write(path, ::JSON.pretty_generate(json))
    end

    REJECT_KEYS = [:ambiguous_town].freeze
    def csv_headers
      Kamome::Models::Address.new.attributes.keys.reject { |o| REJECT_KEYS.include?(o) }
    end

    def build_pretty_attributes(model)
      model.attributes.reject { |key, _| REJECT_KEYS.include?(key) }
    end
  end
end
