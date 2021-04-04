require "rails_helper"

RSpec.describe "when i try to delete an item" do
  before :each do
    @merchant = create(:merchant)
    @item = create(:item, merchant_id: @merchant.id)
  end

  describe "when i put in all the correct data i can delete an item" do
    it "returns id, type, name, description, unit_price, merchant_id. It doesnt return created at or updated at" do
      delete api_v1_item_path(@item)
      expect(response).to be_successful
    end

    it "returns 404 when trying to delete a item with invalid merchant_id" do
      delete api_v1_item_path(99999999)
      
      expect(response).not_to be_successful
      expect(response.status).to eq(404)
    end
  end

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
