require "rails_helper"

RSpec.describe "when i visit the merchant show endpoint" do
  before :each do
    Merchant.destroy_all
    @merchant_1 = create(:merchant)
  end

  describe "I see all the data for a single merchant" do
    it "returns id, type, and name attributes. It doesnt return created at or updated at" do
      get "/api/v1/merchants/#{@merchant_1.id}"
      expect(response).to be_successful

      response = parse(@response)

      expect(response[:data]).to have_key(:id)
      expect(response[:data][:id]).to be_a(String)
      expect(response[:data][:id].to_i).to eq(@merchant_1.id)

      expect(response[:data]).to have_key(:type)
      expect(response[:data][:type]).to be_a(String)
      expect(response[:data][:type].capitalize).to eq(@merchant_1.class.to_s)

      expect(response[:data]).to have_key(:attributes)
      expect(response[:data][:attributes]).to be_a(Hash)

      expect(response[:data][:attributes]).to have_key(:name)
      expect(response[:data][:attributes][:name]).to be_a(String)
      expect(response[:data][:attributes][:name]).to eq(@merchant_1.name)

      expect(response[:data][:attributes]).to_not have_key(:created_at)
      expect(response[:data][:attributes]).to_not have_key(:updated_at)
    end
  end

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
