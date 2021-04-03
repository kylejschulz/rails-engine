class Api::V1::ItemsController < ApplicationController
  before_action :set_per_page, :set_page, only: [:index]
  before_action :set_item, only: [:show, :destroy, :update]

  def index
    @items = Item.limit(@limit).offset(@page * @limit)
    render json: ItemSerializer.new(@items)
  end

  def show
    render json: ItemSerializer.new(@item)
  end

  def create
    render json: ItemSerializer.new(Item.create!(item_params))
  end

  def update
    render json: ItemSerializer.new(@item.update!(item_params))
  end

  def destroy
    Item.destroy(@mercant)
    render json: "Successfully destroyed"
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :mercant_id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
