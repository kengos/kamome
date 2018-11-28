# frozen_string_literal: true

module Kamome
  module Transformations
    module Cleaner
      module_function

      TOWN_KAN_SUB_RULE = /(\((?!.カイ\)).+|イカニケイサイガナイバアイ|.+ノツギニバンチガクルバアイ|.+イチエン)$/.freeze
      def clean_town_kana(value)
        value.sub(TOWN_KAN_SUB_RULE, '')
      end

      TOWN_SUB_RULE = /(（(?!.+階）).+）|以下に掲載がない場合|.+の次に番地がくる場合|.+一円)$/.freeze
      def clean_town(value)
        value.sub(TOWN_SUB_RULE, '')
      end
    end
  end
end
