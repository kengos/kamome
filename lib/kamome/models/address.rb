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

      def initialize(params = {})
        params.each do |key, value|
          public_send("#{key}=", value)
        end
      end

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
          state: state
        }
      end

      def changed?
        state == 1
      end

      def delete?
        state == 2
      end
    end
  end
end
