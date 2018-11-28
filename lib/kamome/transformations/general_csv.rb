# frozen_string_literal: true

require 'kamome/transformations/cleaner'
require 'kamome/models/general'
require 'kamome/models/address'

module Kamome
  module Transformations
    # Transform a GENERAL csv row to a Hash or others
    class GeneralCsv
      include Kamome::Transformations::Cleaner

      # Generate hash from a general csv row
      # @return [Hash]
      def generate_hash(row)
        validate_row!(row)
        transform(row)
      end

      def generate_detail_model(row)
        attributes = generate_hash(row)
        ::Kamome::Models::General.new(attributes)
      end

      def generate_model(row)
        attributes = extract(generate_hash(row))
        ::Kamome::Models::Address.new(attributes)
      end

      private

      VALID_ROW_SIZE = 15

      def validate_row!(row)
        return if row&.size == VALID_ROW_SIZE

        raise ArgumentError, "Wrong row size (expected #{VALID_ROW_SIZE}, got #{row&.size})"
      end

      def transform(row) # rubocop:disable Metrics/AbcSize
        {
          code: row[0].to_s,
          zipcode: row[2].to_s,
          prefecture_kana: row[3].to_s,
          city_kana: row[4].to_s,
          town_kana: clean_town_kana(row[5].to_s),
          prefecture: row[6].to_s,
          city: row[7].to_s,
          town: clean_town(row[8].to_s),
          ambiguous_town: row[9].to_i == 1,
          ambiguous_street: row[10].to_i == 1,
          required_chome: row[11].to_i == 1,
          ambiguous_zipcode: row[12].to_i == 1,
          state: row[13].to_i,
          reason: row[14].to_i
        }
      end

      def extract(attributes)
        {
          code: attributes[:code],
          zipcode: attributes[:zipcode],
          prefecture: attributes[:prefecture],
          city: attributes[:city],
          town: attributes[:town],
          street: '',
          company_name: '',
          post_office_box: '',
          state: attributes[:state]
        }
      end
    end
  end
end
