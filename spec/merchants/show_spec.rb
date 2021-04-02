require "rails_helper"

RSpec.describe "when i visit the merchant show endpoint" do
  before :each do
    @merchant = create(:merchant)
    request merchant_show_path(@merchant)
  end
  describe "I see all the data for a single merchant" do
    expect(request["status"]).to eq(200)
    expect(request["name"]).to eq(@merchant.name)
    expect(request["name"]).to eq(@merchant.name)
    expect(request["name"]).to eq(@merchant.name)
    expect(request["name"]).to eq(@merchant.name)
  end
end
