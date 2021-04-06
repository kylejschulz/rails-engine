require 'rails_helper'

RSpec.describe "When i visit the item index api" do
  before :each do
    Item.destroy_all
  end

  describe "it returns 20 items, it paginates" do
    it "it only returns 20 per page" do
      create_list(:item, 60)

      get '/api/v1/items'

      expect(response).to be_successful

      response = parse(@response)

      expect(response[:data].count).to eq(20)
    end

    it "all of the attributes are present for each item" do
      create_list(:item, 60)

      get '/api/v1/items'

      expect(response).to be_successful

      response = parse(@response)

      expect(response[:data].count).to eq(20)
      response[:data].each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_a(String)

        expect(item).to have_key(:type)
        expect(item[:type]).to be_a(String)

        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to be_a(Hash)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)
        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)

        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:merchant_id]).to be_an(Integer)
      end
    end

    it "It will still return them if there's less than 20" do
      create_list(:item, 17)

      get '/api/v1/items'

      expect(response).to be_successful

      response = parse(@response)

      expect(response[:data].count).to eq(17)
    end

    it "It can return page 2" do
      create_list(:item, 27)

      get '/api/v1/items', params: { page: 2, per_page: 20}

      expect(response).to be_successful

      response = parse(@response)
      expect(response[:data].count).to eq(7)
    end

    it "It can return page less than 20 per page" do
      create_list(:item, 27)

      get '/api/v1/items', params: { per_page: 5}

      expect(response).to be_successful

      response = parse(@response)

      expect(response[:data].count).to eq(5)
    end

    it "It can return page more than 20 per page" do
      create_list(:item, 40)

      get '/api/v1/items', params: { per_page: 30}

      expect(response).to be_successful

      response = parse(@response)

      expect(response[:data].count).to eq(30)
    end

    it "It can return page 2 with 30 per page" do
      create_list(:item, 41)

      get '/api/v1/items', params: { per_page: 30, page: 2}

      expect(response).to be_successful

      response = parse(@response)

      expect(response[:data].count).to eq(11)

      response[:data].each do |item|

        expect(item).to have_key(:id)
        expect(item[:id]).to be_a(String)

        expect(item).to have_key(:type)
        expect(item[:type]).to be_a(String)

        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to be_a(Hash)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)

        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:merchant_id]).to be_a(Integer)
      end
    end

    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
