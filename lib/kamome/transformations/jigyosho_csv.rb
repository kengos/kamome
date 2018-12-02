# frozen_string_literal: true

require 'kamome/transformations/extractor'
require 'kamome/models/jigyosho'
require 'kamome/models/address'

module Kamome
  module Transformations
    # Transform a JIGYOSHO csv row to a Hash or others
    class JigyoshoCsv
      include ::Kamome::Transformations::Extractor

      # Generate a Hash from a JIGYOSHO csv row
      # @return [Hash]
      def generate_hash(row)
        validate_row!(row)
        transform(row)
      end

      # Generate an instance of Kamome::Models::Jigyosho from a JIGYOSHO csv row
      # @return [Kamome::Models::Jigyosho]
      def generate_detail_model(row)
        attributes = generate_hash(row)
        ::Kamome::Models::Jigyosho.new(attributes)
      end

      # Generate an instance of Kamome::Models::Address from a JIGYOSHO csv row
      # @return [Kamome::Models::Address]
      def generate_model(row)
        attributes = extract(generate_hash(row))
        ::Kamome::Models::Address.new(attributes)
      end

      private

      VALID_ROW_SIZE = 13

      def validate_row!(row)
        return if row&.size == VALID_ROW_SIZE

        raise ArgumentError, "Wrong row size (expected #{VALID_ROW_SIZE}, got #{row&.size})"
      end

      def transform(row) # rubocop:disable Metrics/AbcSize
        {
          code: row[0].to_s,
          company_name_kana: row[1].to_s,
          company_name: row[2].to_s,
          prefecture: row[3].to_s,
          city: row[4].to_s,
          town: row[5].to_s,
          street: extract_street(row[6].to_s),
          post_office_box: extract_post_office_box(row[6].to_s),
          zipcode: row[7].to_s,
          japanpost_office_name: row[9].to_s,
          has_post_office_box: row[10].to_i == 1,
          multiple: row[11].to_i,
          state: row[12].to_i
        }
      end

      def extract(attributes)
        {
          code: attributes[:code],
          zipcode: attributes[:zipcode],
          prefecture: attributes[:prefecture],
          city: attributes[:city],
          town: attributes[:town],
          street: attributes[:street],
          company_name: attributes[:company_name],
          post_office_box: attributes[:post_office_box],
          state: convert_state(attributes[:state]),
          ambiguous_town: false
        }
      end

      def convert_state(state)
        state == 5 ? 2 : state
      end
    end
  end
end
