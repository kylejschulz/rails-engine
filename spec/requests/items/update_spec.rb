require "rails_helper"

RSpec.describe "when i try to update item" do
  before :each do
    @merchant = create(:merchant)
    @item = create(:item)
  end
  describe "I can go to the endpoint and update an item" do

    it "returns id, type, name, description, unit_price, merchant_id. It doesnt return created at or updated at" do
      good_attributes= {
        name: 'updated item',
        description: 'updated description',
        unit_price: 99.99,
        merchant_id: @merchant.id
      }
      put "/api/v1/items/#{@item.id}", params: good_attributes
      expect(response).to be_successful

      response = parse(@response)
      expect(response[:data]).to have_key(:id)
      expect(response[:data][:id]).to be_a(String)

      expect(response[:data]).to have_key(:type)
      expect(response[:data][:type]).to be_a(String)
      expect(response[:data][:type].capitalize).to eq(@item.class.to_s)

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

    it "returns 422 when trying to update a item with invalid merchant_id" do
      bad_attributes = {
                        name: 'updated item',
                        description: 'updated description',
                        unit_price: 99.99,
                        merchant_id: 9999999999
                      }
      put "/api/v1/items/#{@item.id}", params: bad_attributes
      expect(response).not_to be_successful
      expect(response.status).to eq(404)
    end

    it "returns 404 when trying to update a item with invalid name" do
      bad_attributes = { name: '' }
      put "/api/v1/items/#{@item.id}", params: bad_attributes

      expect(response).to be_successful
      expect(response.status).to eq(200)
    end

    it "returns 200 when trying to update a item with invalid description" do
      bad_attributes = { description: '' }
      put "/api/v1/items/#{@item.id}", params: bad_attributes

      expect(response).to be_successful
      expect(response.status).to eq(200)
    end

    it "returns 200 when trying to update a item with invalid unit_price" do
      bad_attributes = { unit_price: "" }
      put "/api/v1/items/#{@item.id}", params: bad_attributes

      expect(response).to be_successful
      expect(response.status).to eq(200)
    end
  end

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
