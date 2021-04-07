class Api::V1::SearchController < ApplicationController

  def merchant_find_one
    if merchant_find_one_params[:name] && !merchant_find_one_params[:name].empty?
      merchant = Merchant.find_one(merchant_find_one_params[:name])
      if merchant
        render json: MerchantSerializer.new(merchant), status: 200
      else
        render json: {data: {}}, status: 200
      end
    else
      render json: {data: {}}, status: 400
    end
  end

  def item_find_all
    if item_find_all_params[:name].blank? && item_find_all_params[:min_price].blank? && item_find_all_params[:max_price].blank?
      render json: {data: {}}, status: 400
    else
      items = Item.find_all(item_find_all_params)
      render json: ItemSerializer.new(items), status: 200
    end
  end

  private

  def merchant_find_one_params
    params.permit(:name)
  end

  def item_find_all_params
    params.permit(:name, :min_price, :max_price )
  end
end
