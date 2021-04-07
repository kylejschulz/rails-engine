class Api::V1::Revenue::MerchantsController < ApplicationController
  before_action :set_merchant, only: [:show]

  def show
    merchant = @merchant.total_revenue
    render json: MerchantRevenueSerializer.new(merchant), status: 200
  end
end

private

def set_merchant
  @merchant = Merchant.find(params[:id])
end
