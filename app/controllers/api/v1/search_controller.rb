class Api::V1::SearchController < ApplicationController
  def merchant_find_one

  end

  def merchant_find_one
    merchant = Merchant.find_one(merchant_find_one_params)
    render json: MerchantSerializer.new(merchant), status: 200
  end

  def item_find_all
    items = Item.find_all(item_find_all_params)
    redner json: ItemSerializer.new(items), status: 200
  end

  private

  def merchant_find_one_params
    params.permit(:name)
  end

  def item_find_all_params
    params.permint(:name, :min_price, :max_price )
  end
end
