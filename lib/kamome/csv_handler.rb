# frozen_string_literal: true

require 'kamome/transformations/general_csv'
require 'kamome/transformations/jigyosho_csv'
require 'csv'

module Kamome
  class CsvHandler
    def initialize(operation)
      @operation = operation
    end

    def call(csv_path)
      prev = nil
      ::CSV.foreach(csv_path) do |row|
        obj = transform(row)
        next if skip?(prev, obj)

        yield(obj, $INPUT_LINE_NUMBER)
        prev = obj
      end
    end

    private

    def transform(row)
      transformer.public_send(transformed_method, row)
    end

    def transformed_method
      @operation.type_detail? ? :generate_detail_model : :generate_model
    end

    def transformer
      @transformer ||= @operation.genre_jigyosho? ? jigyosho_transformer : general_transformer
    end

    def jigyosho_transformer
      ::Kamome::Transformations::JigyoshoCsv.new
    end

    def general_transformer
      ::Kamome::Transformations::GeneralCsv.new
    end

    def skip?(previous, current)
      return false unless previous.respond_to?(:ambiguous_town)
      return false unless previous.ambiguous_town

      previous.zipcode == current.zipcode
    end
  end
end
