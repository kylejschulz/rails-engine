require 'rails_helper'

RSpec.describe "When i visit the merchant index api" do
  before :each do
    Merchant.destroy_all
  end

  describe "it returns 20 items, it paginates" do
    it "it only returns 20 per page" do
      create_list(:merchant, 60)

      get '/api/v1/merchants'

      expect(response).to be_successful

      response = parse(@response)

      expect(response[:data].count).to eq(20)
    end

    it "all of the attributes are present for each merchant" do
      create_list(:merchant, 60)

      get '/api/v1/merchants'

      expect(response).to be_successful
      response = parse(@response)

      response[:data].each do |merchant|

        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_a(String)

        expect(merchant).to have_key(:type)
        expect(merchant[:type]).to be_a(String)

        expect(merchant).to have_key(:attributes)
        expect(merchant[:attributes]).to be_a(Hash)
        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)
      end
    end

    it "It will still return them if there's less than 20" do
      create_list(:merchant, 17)

      get '/api/v1/merchants'

      expect(response).to be_successful
      response = parse(@response)
      expect(response[:data].count).to eq(17)
    end

    it "It can return page 2" do
      create_list(:merchant, 27)

      get '/api/v1/merchants', params: { page: 2}

      expect(response).to be_successful

      response = parse(@response)

      expect(response[:data].count).to eq(7)
    end

    it "It can return page less than 20 per page" do
      create_list(:merchant, 27)

      get '/api/v1/merchants', params: { per_page: 5}

      expect(response).to be_successful

      response = parse(@response)

      expect(response[:data].count).to eq(5)
    end

    it "It can return page more than 20 per page" do
      create_list(:merchant, 40)

      get '/api/v1/merchants', params: { per_page: 30}

      expect(response).to be_successful

      response = parse(@response)

      expect(response[:data].count).to eq(30)
    end

    it "It can return page 2 with 30 per page" do
      create_list(:merchant, 41)

      get '/api/v1/merchants', params: { per_page: 30, page: 2}

      expect(response).to be_successful

      response = parse(@response)

      expect(response[:data].count).to eq(11)

      response[:data].each do |merchant|

        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_a(String)

        expect(merchant).to have_key(:type)
        expect(merchant[:type]).to be_a(String)

        expect(merchant).to have_key(:attributes)
        expect(merchant[:attributes]).to be_a(Hash)
        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)
      end
    end

    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end

    # expect(response).to have_http_status(:success)
    # expect(response).to have_http_status(:created)
    # expect(hash_body.keys).to match_array([:id, :ingredients, :instructions])
end
