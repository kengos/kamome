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
      ::CSV.foreach(csv_path) do |row|
        obj = transform(row)
        yield(obj, $INPUT_LINE_NUMBER)
      end
    end

    private

    def transform(row)
      transformer.public_send(transformed_method, row)
    end

    def transformed_method
      return :generate_hash if @operation.type_hash?
      return :generate_detail_model if @operation.type_detail?

      :generate_model
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
  end
end
