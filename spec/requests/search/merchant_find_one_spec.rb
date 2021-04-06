require "rails_helper"

RSpec.describe "when i visit the merchant find_one endpoint, i can find a merchant" do
  before :each do
    Merchant.destroy_all
    @merchant_21 = create(:merchant, name: 'turing')
    @merchants = create_list(:merchant, 20)
  end

  describe "When i put in query params, i get one merchant that matches that crteria" do
    it "searches for a valid merchant" do
      get "/api/v1/merchants/find_one?name=ring"

      expect(response).to be_successful
      response = parse(@response)
      expect(response[:data]).to have_key(:id)
      expect(response[:data][:id]).to be_a(String)
      expect(response[:data][:id].to_i).to eq(@merchants[0].id)

      expect(response[:data]).to have_key(:type)
      expect(response[:data][:type]).to be_a(String)
      expect(response[:data][:type].capitalize).to eq(@merchants[0].class.to_s)

      expect(response[:data]).to have_key(:attributes)
      expect(response[:data][:attributes]).to be_a(Hash)

      expect(response[:data][:attributes]).to have_key(:name)
      expect(response[:data][:attributes][:name]).to be_a(String)
      expect(response[:data][:attributes][:name]).to eq(@merchants[0].name)

      expect(response[:data][:attributes]).to_not have_key(:created_at)
      expect(response[:data][:attributes]).to_not have_key(:updated_at)
    end
    it "can return no matches" do
      get "/api/v1/merchants/find_one?name=a"

      expect(response).to be_successful
      response = parse(@response)
      expect(response[:data]).to be_nil

    end

    it "returns the first one alphabetically" do
      @merchant_22 = create(:merchant, name: 'AAA')
      @merchant_23 = create(:merchant, name: 'AAa')
      @merchant_24 = create(:merchant, name: 'Aaa')
      @merchant_25 = create(:merchant, name: 'aaa')

      get "/api/v1/merchants/find_one?name=AAA"

      expect(response).to be_successful
      response = parse(@response)

      expect(response[:data]).to have_key(:attributes)
      expect(response[:data][:attributes]).to have_key(:id)
      expect(response[:data][:attributes][:id].to_i).to eq(@merchant_22.id)
      expect(response[:data][:attributes]).to have_key(:name)
      expect(response[:data][:attributes][:name]).to eq(@merchant_22.name)
    end
  end

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end

# find one MERCHANT based on search criteria AND find all ITEMS based on search criteria
