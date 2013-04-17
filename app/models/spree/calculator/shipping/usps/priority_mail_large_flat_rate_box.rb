module Spree
  module Calculator::Shipping
    module Usps
      class PriorityMailLargeFlatRateBox < Spree::Calculator::Shipping::Usps::Base
        def self.description
          I18n.t("usps.priority_mail_large_flat_rate_box")
        end
      end
    end
  end
end
