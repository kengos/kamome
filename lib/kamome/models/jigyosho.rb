# frozen_string_literal: true

module Kamome
  module Models
    # CSV Model: 大口事業所個別番号データ
    # @see https://www.post.japanpost.jp/zipcode/dl/jigyosyo/index-zip.html
    # @see https://www.post.japanpost.jp/zipcode/dl/jigyosyo/readme.html
    class Jigyosho
      # @!attribute [rw] code
      #   大口事業所の所在地のJISコード
      #  @return [String]
      attr_accessor :code

      # @!attribute [rw] name_kana
      #   大口事業所名（カナ）
      #   @return [String]
      attr_accessor :company_name_kana

      # @!attribute [rw] name
      #   大口事業所名（漢字）
      #   @return [String]
      attr_accessor :company_name

      # @!attribute [rw] prefecture
      #   都道府県名（漢字）
      #   @return [String]
      attr_accessor :prefecture

      # @!attribute [rw] city
      #   市区町村名（漢字）
      #   @return [String]
      attr_accessor :city

      # @!attribute [rw] town
      #   町域名（漢字）
      #   @return [String]
      attr_accessor :town

      # @!attribute [rw] street
      #   小字名、丁目、番地等（漢字）
      #   @return [String]
      attr_accessor :street

      # @!attribute [rw] post_office_box
      #   私書箱名
      #   @return [String]
      attr_accessor :post_office_box

      # @!attribute [rw] town
      #   大口事業所個別番号
      #   @return [String]
      attr_accessor :zipcode

      # @!attribute [rw] japanpost_office_name
      #   取扱局
      #   @return [String]
      attr_accessor :japanpost_office_name

      # @!attribute [rw] post_office_box
      #   私書箱: true, 大口事業所: false
      #   @return [Boolean]
      attr_accessor :has_post_office_box

      # @!attribute [rw] required_chome
      #   複数番号の有無
      #   * 「0」複数番号無し
      #   * 「1」複数番号を設定している場合の個別番号の1
      #   * 「2」複数番号を設定している場合の個別番号の2
      #   * 「3」複数番号を設定している場合の個別番号の3
      #   @return [Integer]
      attr_accessor :multiple

      # @!attribute [rw] state
      #   修正コード
      #   * 「0」修正なし
      #   * 「1」新規追加
      #   * 「5」廃止
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
          company_name_kana: company_name_kana,
          company_name: company_name,
          prefecture: prefecture,
          city: city,
          town: town,
          street: street,
          post_office_box: post_office_box,
          zipcode: zipcode,
          japanpost_office_name: japanpost_office_name,
          has_post_office_box: has_post_office_box,
          multiple: multiple,
          state: state
        }
      end
    end
  end
end
