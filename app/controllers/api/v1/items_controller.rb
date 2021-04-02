class Api::V1::ItemsController < ApplicationController
  def index
    render :json ItemSerializer.new(Item.all.first(20))
  end

  def show
    render :json ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    render :json ItemSerializer.new(Item.new(item_params))
  end

  def update
    render :json ItemSerializer.new(Item.update(item_params))
  end

  def destroy
    Item.destroy(params[:id])
    render :json "Successfully destroyed"
  end

  private

  def item_params
    params.permit(?)
  end
end
