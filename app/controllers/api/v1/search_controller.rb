class Api::V1::SearchController < ApplicationController
  def merchant_find_one

  end

  def merchant_find_one
    merchant = Merchant.find_one(merchant_find_one_params[:name])
    render json: MerchantSerializer.new(merchant), status: 200

  end

  private

  def merchant_find_one_params
    params.permit(:name, )
  end
end
