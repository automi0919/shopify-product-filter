class ActiveShippingCalculator
  include Spree::ActiveShipping    
  include ActiveMerchant::Shipping
  
  def initialize(carrier)
    @carrier = carrier.new
  end
  
  def calculate_shipping(order)
    origin      = Location.new(:country => Spree::ActiveShipping::Config[:origin_country], 
                               :state => Spree::ActiveShipping::Config[:origin_city],
                               :city => Spree::ActiveShipping::Config[:origin_state],
                               :zip => Spree::ActiveShipping::Config[:zip])

    destination = Location.new(:country => order.address.country.iso,
                               :state => order.address.state.abbr,
                               :city => order.address.city,
                               :zip => order.address.zipcode)

    ups = UPS.new(:login => Spree::ActiveShipping::Config[:ups_login], 
                  :password => Spree::ActiveShipping::Config[:ups_password], 
                  :key => Spree::ActiveShipping::Config[:ups_key])  
                                  
    response = @carrier.find_rates(origin, destination, packages(order))
  end

  private
  # Generates an array of Package objects based on the quantities and weights of the variants in the line items
  def packages(order)
    multiplier = Spree::ActiveShipping::Config[:unit_multiplier]
    weight = order.line_items.inject(0) { |weight, line_item| weight + (line_item.quantity * line_item.variant.weight * multiplier) }
    package = Package.new(weight, [], :units => Spree::ActiveShipping::Config[:units].to_sym)
    [package]
  end
end