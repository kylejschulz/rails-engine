require "rails_helper"

RSpec.describe "when i try and create a new item" do
  before :each do
    @merchant = create(:merchant)
  end
  describe "when i put in all the correct data i can create an item" do

    it "returns id, type, name, description, unit_price, merchant_id. It doesnt return created at or updated at" do
      good_attributes = {
        name: 'new item',
        description: 'new description',
        unit_price: 99.99,
        merchant_id: @merchant.id
      }
      post api_v1_items_path, params: good_attributes
      expect(response).to be_successful

      response = parse(@response)
      expect(response[:data]).to have_key(:id)
      expect(response[:data][:id]).to be_a(String)

      expect(response[:data]).to have_key(:type)
      expect(response[:data][:type]).to be_a(String)
      expect(response[:data][:type]).to eq('item')

      expect(response[:data]).to have_key(:attributes)
      expect(response[:data][:attributes]).to be_a(Hash)

      expect(response[:data][:attributes]).to have_key(:name)
      expect(response[:data][:attributes][:name]).to be_a(String)
      expect(response[:data][:attributes][:name]).to eq(good_attributes[:name])

      expect(response[:data][:attributes]).to have_key(:description)
      expect(response[:data][:attributes][:description]).to be_a(String)
      expect(response[:data][:attributes][:description]).to eq(good_attributes[:description])

      expect(response[:data][:attributes]).to have_key(:unit_price)
      expect(response[:data][:attributes][:unit_price]).to be_a(Float)
      expect(response[:data][:attributes][:unit_price]).to eq(good_attributes[:unit_price])

      expect(response[:data][:attributes]).to have_key(:merchant_id)
      expect(response[:data][:attributes][:merchant_id]).to be_a(Integer)
      expect(response[:data][:attributes][:merchant_id]).to eq(good_attributes[:merchant_id])

      expect(response[:data][:attributes]).to_not have_key(:created_at)
      expect(response[:data][:attributes]).to_not have_key(:updated_at)
    end

    it "returns 404 when trying to update a item with invalid merchant_id" do
      bad_attributes = {
                        name: 'new item',
                        description: 'new description',
                        unit_price: 99.99,
                        merchant_id: 9999999999
                      }

      post "/api/v1/items", params: bad_attributes

      expect(response).not_to be_successful
      expect(response.status).to eq(404)
    end
  end

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
