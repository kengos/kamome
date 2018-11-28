# frozen_string_literal: true

module Kamome
  class Operation
    TYPE_HASH = :hash
    TYPE_DETAIL = :detail
    TYPE_DEFAULT = :default

    GENRE_GENERAL = :general
    GENRE_JIGYOSHO = :jigyosho

    URL_GENERAL_ALL = 'https://www.post.japanpost.jp/zipcode/dl/kogaki/zip/ken_all.zip'
    URL_GENERAL_ADD = 'https://www.post.japanpost.jp/zipcode/dl/kogaki/zip/add_%s.zip'
    URL_GENERAL_DEL = 'https://www.post.japanpost.jp/zipcode/dl/kogaki/zip/del_%s.zip'
    URL_JIGYOSHO_ALL = 'https://www.post.japanpost.jp/zipcode/dl/jigyosyo/zip/jigyosyo.zip'
    URL_JIGYOSHO_ADD = 'https://www.post.japanpost.jp/zipcode/dl/jigyosyo/zip/jadd%s.zip'
    URL_JIGYOSHO_DEL = 'https://www.post.japanpost.jp/zipcode/dl/jigyosyo/zip/jdel%s.zip'

    class << self
      def general_all(type: TYPE_DEFAULT)
        new(type: type, genre: GENRE_GENERAL, urls: [URL_GENERAL_ALL])
      end

      def jigyosho_all(type: TYPE_DEFAULT)
        new(type: type, genre: GENRE_JIGYOSHO, urls: [URL_JIGYOSHO_ALL])
      end

      def general_diff(date:, type: TYPE_DEFAULT)
        yymm = format_yymm(date)
        new(type: type, genre: GENRE_GENERAL, urls: [URL_GENERAL_ADD % yymm, URL_GENERAL_DEL % yymm])
      end

      def jigyosho_diff(date:, type: TYPE_DEFAULT)
        yymm = format_yymm(date)
        new(type: type, genre: GENRE_JIGYOSHO, urls: [URL_JIGYOSHO_ADD % yymm, URL_JIGYOSHO_DEL % yymm])
      end

      private

      YYMM_FORMAT = /\d{2}(0[1-9]|1[0-2])/.freeze
      def format_yymm(date)
        yymm = date.respond_to?(:strftime) ? date.strftime('%y%m') : date.to_s
        return yymm if yymm =~ YYMM_FORMAT

        raise ::Kamome::ArgumentError, 'Wrong argument "date" (required "yymm" format)'
      end
    end

    attr_reader :type
    attr_reader :genre
    attr_reader :urls

    def initialize(type:, genre:, urls:)
      @type = type
      @genre = genre
      @urls = urls
    end

    def type_hash?
      type == TYPE_HASH
    end

    def type_detail?
      type == TYPE_DETAIL
    end

    def type_default?
      type == TYPE_DEFAULT
    end

    def genre_general?
      genre == GENRE_GENERAL
    end

    def genre_jigyosho?
      genre == GENRE_JIGYOSHO
    end
  end
end
