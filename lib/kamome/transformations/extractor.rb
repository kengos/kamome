# frozen_string_literal: true

module Kamome
  module Transformations
    module Extractor
      module_function

      POST_OFFICE_REG = /（(.+私書箱第.+号)）$/.freeze
      def extract_street(value)
        value.sub(POST_OFFICE_REG, '')
      end

      def extract_post_office_box(value)
        value[POST_OFFICE_REG, 1] || ''
      end
    end
  end
end
