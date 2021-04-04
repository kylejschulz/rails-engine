require "rails_helper"

RSpec.describe "when i visit the item show endpoint" do
  before :each do
    Item.destroy_all
    @item_1 = create(:item)
  end

  describe "I see all the data for a single item" do
    it "returns id, type, name, description, unit_price, merchant_id. It doesnt return created at or updated at" do
      get "/api/v1/items/#{@item_1.id}"
      expect(response).to be_successful

      response = parse(@response)
      expect(response[:data]).to have_key(:id)
      expect(response[:data][:id]).to be_a(String)
      expect(response[:data][:id].to_i).to eq(@item_1.id)

      expect(response[:data]).to have_key(:type)
      expect(response[:data][:type]).to be_a(String)
      expect(response[:data][:type].capitalize).to eq(@item_1.class.to_s)

      expect(response[:data]).to have_key(:attributes)
      expect(response[:data][:attributes]).to be_a(Hash)

      expect(response[:data][:attributes]).to have_key(:description)
      expect(response[:data][:attributes][:description]).to be_a(String)
      expect(response[:data][:attributes][:description]).to eq(@item_1.description)

      expect(response[:data][:attributes]).to have_key(:unit_price)
      expect(response[:data][:attributes][:unit_price]).to be_a(Float)
      expect(response[:data][:attributes][:unit_price]).to eq(@item_1.unit_price)

      expect(response[:data][:attributes]).to have_key(:merchant_id)
      expect(response[:data][:attributes][:merchant_id]).to be_a(Integer)
      expect(response[:data][:attributes][:merchant_id]).to eq(@item_1.merchant_id)

      expect(response[:data][:attributes]).to_not have_key(:created_at)
      expect(response[:data][:attributes]).to_not have_key(:updated_at)
    end

    it "returns 404 with invalid item id" do
      get "/api/v1/items/1000000"

      expect(response).not_to be_successful
      expect(response.status).to eq(404)
    end
  end 

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
