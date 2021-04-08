require "rails_helper"

RSpec.describe "when i visit the item find_all endpoint, i can find a item" do
  before :each do
    Item.destroy_all
    @item_21 = create(:item, name: 'turing')
    @items = create_list(:item, 20)
  end

  describe "When i put in query params, i get all items that matches that crteria" do
    it "searches for a valid items" do
      get "/api/v1/items/find_all?name=ring"

      expect(@response).to be_successful
      response = parse(@response)
      response[:data].each do |response|
        expect(response).to have_key(:id)
        expect(response[:id]).to be_a(String)

        expect(response).to have_key(:type)
        expect(response[:type]).to be_a(String)

        expect(response).to have_key(:attributes)
        expect(response[:attributes]).to be_a(Hash)

        expect(response[:attributes]).to have_key(:name)
        expect(response[:attributes][:name]).to be_a(String)

        expect(response[:attributes]).to_not have_key(:created_at)
        expect(response[:attributes]).to_not have_key(:updated_at)
      end
    end

    it "can return an array if there are no matches" do
      get "/api/v1/items/find_all?name=a"

      expect(@response).to be_successful
      response = parse(@response)
      expect(response[:data]).to eq([])
    end

    it "can return all the matches for min_price" do
      get "/api/v1/items/find_all?min_price=100"

      expect(@response).to be_successful
      response = parse(@response)
      expect(response[:data]).to eq([])
    end

    it "can return all the matches for max_price" do
      get "/api/v1/items/find_all?max_price=1000"

      expect(@response).to be_successful
      response = parse(@response)
      expect(response[:data].count).to eq(21)
      expect(response[:data].first).to have_key(:id)
      expect(response[:data].first[:id]).to be_a(String)

      expect(response[:data].first).to have_key(:type)
      expect(response[:data].first[:type]).to be_a(String)

      expect(response[:data].first).to have_key(:attributes)
      expect(response[:data].first[:attributes]).to be_a(Hash)

      expect(response[:data].first[:attributes]).to have_key(:name)
      expect(response[:data].first[:attributes][:name]).to be_a(String)

      expect(response[:data].first[:attributes]).to_not have_key(:created_at)
      expect(response[:data].first[:attributes]).to_not have_key(:updated_at)
    end

    it "can return all the matches for min_price and max_price" do
      get "/api/v1/items/find_all?min_price=100&max_price=1000"

      expect(@response).to be_successful
      response = parse(@response)
      expect(response[:data]).to eq([])
    end
  end

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end

# find one MERCHANT based on search criteria AND find all ITEMS based on search criteria
