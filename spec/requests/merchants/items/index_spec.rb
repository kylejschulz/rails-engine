require "rails_helper"

RSpec.describe "when i visit the item show endpoint" do
  before :each do
    Item.destroy_all
    Merchant.destroy_all
    @merchant = create(:merchant, id: 1)
    @items = create_list(:item, 30, merchant_id: @merchant.id)
  end

  describe "I see all the data for a single item" do
    it "returns id, type, name, description, unit_price, merchant_id. It doesnt return created at or updated at" do
      get "/api/v1/merchants/#{@merchant.id}/items"
      expect(response).to be_successful

      response = parse(@response)

      response[:data].each_with_index do |item, index|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_a(String)
        expect(item[:id].to_i).to eq(@items[index].id)

        expect(item).to have_key(:type)
        expect(item[:type]).to be_a(String)
        expect(item[:type].capitalize).to eq(@items[index].class.to_s)

        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to be_a(Hash)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)
        expect(item[:attributes][:description]).to eq(@items[index].description)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)
        expect(item[:attributes][:unit_price]).to eq(@items[index].unit_price)

        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:merchant_id]).to be_a(Integer)
        expect(item[:attributes][:merchant_id]).to eq(@items[index].merchant_id)

        expect(item[:attributes]).to_not have_key(:created_at)
        expect(item[:attributes]).to_not have_key(:updated_at)
      end
    end

    it "returns 404 with invalid merchant id" do
      get "/api/v1/merchants/100/items"

      expect(response).not_to be_successful
      expect(response.status).to eq(404)
    end
  end

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
