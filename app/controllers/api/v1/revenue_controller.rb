class Api::V1::RevenueController < ApplicationController
  before_action :set_merchant, only: [:total_revenue]

  def merchants_with_most_revenue
    if !most_revenue_quantity_params[:quantity].present? || most_revenue_quantity_params[:quantity].to_i < 1
      render json: {error: {}}, status: 400
    else
      @merchants = Merchant.with_most_revenue(most_revenue_quantity_params[:quantity])
      render json: MerchantNameRevenueSerializer.new(@merchants), status: 200
    end
  end

  def unshipped
    if !unshipped_quantity_params[:quantity].present? || unshipped_quantity_params[:quantity].to_i < 1
      render json: {error: {}}, status: 400
    else
      potential_revenue = Invoice.potential_revenue(unshipped_quantity_params[:quantity])
      render json: UnshippedOrderSerializer.new(potential_revenue), status: 200
    end
  end

  def total_revenue
    render json: MerchantRevenueSerializer.new(@merchant), status: 200
  end

  private

  def set_merchant
    @merchant = Merchant.find(params[:id])
  end

  def unshipped_quantity_params
    params[:quantity] = 10 if params[:quantity].nil?
    params.permit(:quantity)
  end

  def most_revenue_quantity_params
    params[:quantity] = 5 if params[:quantity].nil?
    params.permit(:quantity)
  end
end
