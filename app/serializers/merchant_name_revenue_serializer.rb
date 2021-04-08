class MerchantNameRevenueSerializer
include FastJsonapi::ObjectSerializer
  attributes :name

  attributes :revenue do |merchant|
    merchant.total_revenue
  end
end
