require "rails_helper"

RSpec.describe "when i visit the item find_all endpoint, i can find a item" do
  before :each do
    Item.destroy_all
    @item_21 = create(:item, name: 'turing')
    @items = create_list(:item, 20)
  end

  describe "When i put in query params, i get one item that matches that crteria" do
    it "searches for a valid item" do
      get "/api/v1/items/find_all?name=ring"

      expect(response).to be_successful
      response = parse(@response)
      expect(response[:data]).to have_key(:id)
      expect(response[:data][:id]).to be_a(String)
      expect(response[:data][:id].to_i).to eq(@items[0].id)

      expect(response[:data]).to have_key(:type)
      expect(response[:data][:type]).to be_a(String)
      expect(response[:data][:type].capitalize).to eq(@items[0].class.to_s)

      expect(response[:data]).to have_key(:attributes)
      expect(response[:data][:attributes]).to be_a(Hash)

      expect(response[:data][:attributes]).to have_key(:name)
      expect(response[:data][:attributes][:name]).to be_a(String)
      expect(response[:data][:attributes][:name]).to eq(@items[0].name)

      expect(response[:data][:attributes]).to_not have_key(:created_at)
      expect(response[:data][:attributes]).to_not have_key(:updated_at)
    end

    it "can return an array if there are no matches" do
      get "/api/v1/items/find_one?name=a"

      expect(response).to be_successful
      response = parse(@response)
      expect(response[:data]).to eq([])
    end

    it "can return all the matches for min_price" do
      get "/api/v1/items/find_one?min_price=100"

      expect(response).to be_successful
      response = parse(@response)
      expect(response[:data]).to eq([])
    end

    it "can return all the matches for max_price" do
      get "/api/v1/items/find_one?max_price=1000"

      expect(response).to be_successful
      response = parse(@response)
      expect(response[:data]).to eq([])
    end

    it "can return all the matches for min_price and max_price" do
      get "/api/v1/items/find_all?min_price=100&max_price=1000"

      expect(response).to be_successful
      response = parse(@response)
      expect(response[:data]).to eq([])
    end

    it "returns the first one alphabetically" do
      @item_22 = create(:item, name: 'AAA')
      @item_23 = create(:item, name: 'AAa')
      @item_24 = create(:item, name: 'Aaa')
      @item_25 = create(:item, name: 'aaa')

      get "/api/v1/items/find_one?name=AAA"

      expect(response).to be_successful
      response = parse(@response)

      expect(response[:data]).to have_key(:attributes)
      expect(response[:data][:attributes]).to have_key(:id)
      expect(response[:data][:attributes][:id].to_i).to eq(@item_22.id)
      expect(response[:data][:attributes]).to have_key(:name)
      expect(response[:data][:attributes][:name]).to eq(@item_22.name)
    end
  end

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end

# find one MERCHANT based on search criteria AND find all ITEMS based on search criteria
