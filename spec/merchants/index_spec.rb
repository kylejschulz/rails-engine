require 'rails_helper'

Rspec.describe "When i visit the merchant index api" do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
    @merchant_4 = create(:merchant)
    @merchant_5 = create(:merchant)
    @merchant_6 = create(:merchant)
    @merchant_7 = create(:merchant)
    @merchant_8 = create(:merchant)
    @merchant_9 = create(:merchant)
    @merchant_10 = create(:merchant)
    @merchant_11 = create(:merchant)
    @merchant_12 = create(:merchant)
    @merchant_13 = create(:merchant)
    @merchant_14 = create(:merchant)
    @merchant_15 = create(:merchant)
    @merchant_16 = create(:merchant)
    @merchant_17 = create(:merchant)
    @merchant_18 = create(:merchant)
    @merchant_19 = create(:merchant)
    @merchant_20 = create(:merchant)
    @merchant_21 = create(:merchant)
    request merchant_index_path
  end
  describe "it returns no more than 20 merchants" do
    request merchant_index_path
    expect(request.status).to eq(200)
    expect(request[:merchants].count).to eq(20)
    expect(request).to_not have_content(@merchant_21.name)

  end
  describe "all of the attributes are present for each merchant" do
    expect(request.status).to eq(200)
    expect(request[:merchants][0]).to have_key("name")
    expect(request[:merchants][0]).to have_key("")
    expect(request[:merchants][0]).to have_key("name")
    expect(request[:merchants][0]).to have_key("name")

  end

  describe "It will still return them if there's less than 20" do
    @merchant_21.destroy
    @merchant_20.destroy
    @merchant_19.destroy
    @merchant_18.destroy

    expect(request.status).to eq(200)
    expect(request[:merchants].count).to eq(17) 
  end
end
