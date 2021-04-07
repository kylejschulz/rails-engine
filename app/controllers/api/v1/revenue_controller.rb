class Api::V1::RevenueController < ApplicationController
  def merchants_with_most_revenue
    require "pry"; binding.pry
    @merchants = Merchant.with_most_revenue(merchant_most_revenue_params)
    render json: MerchantNameRevenueSerializer.new(@merchants), status: 200
  end

  private

  def merchant_most_revenue_params
    params.permit(:quantity)
  end
end
