class Api::V1::ItemMerchantsController < ApplicationController
  before_action :set_item, only: [:show]
  before_action :set_per_page, :set_page, only: [:index]

  def show
    @merchant = @item.merchant
    render json: MerchantSerializer.new(@merchant), status: 200
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end
end
