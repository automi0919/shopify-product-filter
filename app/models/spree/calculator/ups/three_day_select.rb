module Spree
  class Calculator
    module Ups
      class ThreeDaySelect < Calculator::Ups::Base
        def self.description
          I18n.t("ups.three_day_select")
        end
      end
    end
  end
end
