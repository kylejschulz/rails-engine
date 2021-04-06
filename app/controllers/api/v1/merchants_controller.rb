class Api::V1::MerchantsController < ApplicationController
  before_action :set_per_page, :set_page, only: [:index]
  before_action :set_merchant, only: [:show]


  def index
    @merchants = Merchant.limit(@limit).offset(@page * @limit)
    render json: MerchantSerializer.new(@merchants), status: 200
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id])), status: 200
  end

  private

  def merchant_params
    params.permit(:page, :per_page)
  end

  def set_merchant
    @merchant = Merchant.find(params[:id])
  end
end
