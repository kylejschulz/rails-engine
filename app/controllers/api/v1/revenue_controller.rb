class Api::V1::RevenueController < ApplicationController
  before_action :set_merchant, only: [:total_revenue]

  def merchants_with_most_revenue
    if quantity_params[:quantity].blank? || quantity_params[:quantity].to_i < 1
      render json: {error: {}}, status: 400
    else
      @merchants = Merchant.with_most_revenue(quantity_params[:quantity])
      render json: MerchantNameRevenueSerializer.new(@merchants), status: 200
    end
  end

  def unshipped
    revenue = Invoice.revenue_of_unshipped_successful_transactions
    require "pry"; binding.pry
    render json: MerchantRevenueSerializer.new(revenue), status: 200
  end

  def total_revenue
    merchant = @merchant.total_revenue
    render json: MerchantRevenueSerializer.new(merchant), status: 200
  end

  private

  def set_merchant
    @merchant = Merchant.find(params[:id])
  end

  def quantity_params
    params.permit(:quantity)
  end
end
