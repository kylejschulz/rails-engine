require "rails_helper"

RSpec.describe "when i visit the merchant items index endpoint" do
  before :each do
    @merchant = create(:merchant)
    @item_1 = create(:item)
    @item_2 = create(:item)
    @merchant.items << [@item_1, @item_2]
    request merchant_item_index_path(@merchant)
  end
  describe "I see all the items for a that given merchant" do
    expect(request["status"]).to eq(200)
    expect(request["status"].size).to eq(2)
    expect(request["name"]).to eq(@item_1.name)
    expect(request["name"]).to eq(@item_2.name)
    expect(request["name"]).to eq(@item_1.cost)
    expect(request["name"]).to eq(@item_2.cost)
  end
  before {get '/api/v1/questions'}
  it 'returns all questions' do
    expect(JSON.parse(response.body).size).to eq(20)
  end
  it 'returns status code 200' do
    json_response = JSON.parse(response.body)
    expect(response).to have_http_status(:success)safari
    expect(response).to have_http_status(:created)
    expect(hash_body.keys).to match_array([:id, :ingredients, :instructions])
  end
end
