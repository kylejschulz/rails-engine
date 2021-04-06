class Api::V1::ItemsController < ApplicationController
  before_action :set_per_page, :set_page, only: [:index]
  before_action :set_item, only: [:show, :destroy, :update]

  def index
    items = Item.limit(@limit).offset(@page * @limit)
    render json: ItemSerializer.new(items), status: 200
  end

  def show
    render json: ItemSerializer.new(@item), status: 200
  end

  def create
    item = Item.create!(item_params)
    render json: ItemSerializer.new(item), status: 201
  end

  def update
    @item.update!(item_params)
    render json: ItemSerializer.new(@item), status: 200
  end

  def destroy
    Item.destroy(@item.id)
    render json: "destroyed", status: 200
  end

  private

  def item_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
