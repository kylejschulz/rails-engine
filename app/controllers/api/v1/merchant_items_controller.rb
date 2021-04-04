class Api::V1::MerchantItemsController < ApplicationController
  before_action :set_merchant, only: [:index]
  before_action :set_per_page, :set_page, only: [:index]

  def index
    @items = @merchant.items.limit(@limit).offset(@page * @limit)
    render json: ItemSerializer.new(@items), status: 200
  end

  private

  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
