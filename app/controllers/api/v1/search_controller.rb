class Api::V1::SearchController < ApplicationController

  def merchant_find_one
    merchant = Merchant.find_one(merchant_find_one_params[:name])
    if merchant.nil?
      render json: {data: {}}, status: 200
    else
    render json: MerchantSerializer.new(merchant), status: 200
  end
  end

  def item_find_all
    items = Item.find_all(item_find_all_params)
    render json: ItemSerializer.new(items), status: 200
  end

  private

  def merchant_find_one_params
    params.permit(:name)
  end

  def item_find_all_params
    params.permit(:name, :min_price, :max_price )
  end

  def item_param_check
    if items
  end
end
