# frozen_string_literal: true

module Kamome
  module Models
    class Address
      # @!attribute [rw] code
      #   全国地方公共団体コード
      #   @return [String]
      attr_accessor :code

      # @!attribute [rw] zipcode
      #   郵便番号(7桁)
      #   @return [String]
      attr_accessor :zipcode

      # @!attribute [rw] prefecture
      #   都道府県名
      #   @return [String]
      attr_accessor :prefecture

      # @!attribute [rw] city
      #   市区町村
      #   @return [String]
      attr_accessor :city

      # @!attribute [rw] town
      #   町域
      #   @return [String]
      attr_accessor :town

      # @!attribute [rw] street
      #   番地, 建物等
      #   @return [String]
      attr_accessor :street

      # @!attribute [rw] company_name
      #   企業名/団体名 等
      #   @return [String]
      attr_accessor :company_name

      # @!attribute [rw] post_office_box
      #   私書箱名
      #   @return [String]
      attr_accessor :post_office_box

      # @!attribute [rw] state
      #   状態
      #     0: 変更なし
      #     1: 変更あり
      #     2: 削除
      #   @return [Integer]
      attr_accessor :state

      # @!attribute [rw] ambiguous_town
      #   一町域が二以上の郵便番号で表される場合 true
      #   genre: :general のみ
      #   @return [Boolean]
      attr_accessor :ambiguous_town

      STATE_NOT_CHANGE = 0
      STATE_UPDATE = 1
      STATE_DELETE = 2

      # @params [Hash] model attributes
      def initialize(params = {})
        params.each do |key, value|
          public_send("#{key}=", value)
        end
      end

      # @return [Hash] model attributes
      def attributes
        {
          code: code,
          zipcode: zipcode,
          prefecture: prefecture,
          city: city,
          town: town,
          street: street,
          company_name: company_name,
          post_office_box: post_office_box,
          state: state,
          ambiguous_town: ambiguous_town
        }
      end

      # Returns true when state is 1 or 2
      # @return [Boolean]
      def change?
        updated? || deleted?
      end

      # Returns true when state is 1
      # @return [Boolean]
      def update?
        state == STATE_UPDATE
      end

      # Returns true when state is 2
      # @return [Boolean]
      def delete?
        state == STATE_DELETE
      end
    end
  end
end
