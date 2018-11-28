# frozen_string_literal: true

module Kamome
  module Models
    # CSV Model: 読み仮名データの促音・拗音を小書きで表記するもの
    # @see https://www.post.japanpost.jp/zipcode/dl/readme.html
    class General
      # @!attribute [rw] code
      #   全国地方公共団体コード(JIS X0401, X0402), 半角数値
      #   @return [String]
      attr_accessor :code

      # @!attribute [rw] zipcode
      #   郵便番号, 半角数値7桁
      #   @return [String]
      attr_accessor :zipcode

      # @!attribute [rw] prefecture_kana
      #   都道府県名 カナ
      #   @return [String]
      attr_accessor :prefecture_kana

      # @!attribute [rw] city_kana
      #   市区町村名 カナ
      #   @return [String]
      attr_accessor :city_kana

      # @!attribute [rw] town_kana
      #   町域名 カナ
      #   @return [String]
      attr_accessor :town_kana

      # @!attribute [rw] prefecture
      #   都道府県名 漢字
      #   @return [String]
      attr_accessor :prefecture

      # @!attribute [rw] city
      #   市区町村名 漢字
      #   @return [String]
      attr_accessor :city

      # @!attribute [rw] town
      #   町域名 漢字
      #   @return [String]
      attr_accessor :town

      # @!attribute [rw] ambiguous_town
      #   一町域が二以上の郵便番号で表される場合 true
      #   @return [Boolean]
      attr_accessor :ambiguous_town

      # @!attribute [rw] ambiguous_street
      #   小字毎に番地が起番されている町域の場合 true
      #   @return [Boolean]
      attr_accessor :ambiguous_street

      # @!attribute [rw] required_chome
      #   丁目を有する町域の場合 true
      #   @return [Boolean]
      attr_accessor :required_chome

      # @!attribute [rw] ambiguous_zipcode
      #   一つの郵便番号で二以上の町域を表す場合 true
      #   @return [Boolean]
      attr_accessor :ambiguous_zipcode

      # @!attribute [rw] state
      #   更新の表示
      #   0: 変更なし, 1: 変更あり, 2: 廃止
      #   @return [Integer]
      attr_accessor :state

      # @!attribute [rw] reason
      #   変更理由
      #   0: 変更なし, 1: 市政・区政・町政・分区・政令指定都市施行, 2: 住居表示の実施,
      #   3: 区画整理, 4: 郵便区調整等, 5: 訂正, 6: 廃止
      #   @return [Integer]
      attr_accessor :reason

      def initialize(params = {})
        params.each do |key, value|
          public_send("#{key}=", value)
        end
      end

      def attributes
        {
          code: code,
          zipcode: zipcode,
          prefecture_kana: prefecture_kana,
          city_kana: city_kana,
          town_kana: town_kana,
          prefecture: prefecture,
          city: city,
          town: town,
          ambiguous_town: ambiguous_town,
          ambiguous_street: ambiguous_street,
          required_chome: required_chome,
          ambiguous_zipcode: ambiguous_zipcode,
          state: state,
          reason: reason
        }
      end
    end
  end
end
