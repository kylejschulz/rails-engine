require 'rails_helper'

RSpec.describe "When I visit /api/v1/merchants/most_revenue" do
  describe " and give it a quantity param i see a variable number of merchants ranked by total revenue" do
    it "can visit the page and return the merchants" do
      @merchant_1 = create(:merchant)
      @customer_1= create(:customer)
      @item_1 = create(:item, merchant_id: @merchant_1.id, unit_price: 10)
      @invoice_1 = create(:invoice, customer_id: @customer_1.id, merchant_id: @merchant_1.id, status: 'shipped' )
      @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id)
      @transaction_1 = create(:transaction, invoice_id: @invoice_1.id, result: "success")

      @merchant_2 = create(:merchant)
      @item_2 = create(:item, merchant_id: @merchant_2.id, unit_price: 20)
      @customer_2 = create(:customer)
      @invoice_2 = create(:invoice, customer_id: @customer_2.id, merchant_id: @merchant_2.id, status: 'shipped' )
      @invoice_item_2 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_2.id)
      @transaction_2 = create(:transaction, invoice_id: @invoice_2.id, result: "success")

      @merchant_3 = create(:merchant)
      @item_3 = create(:item, merchant_id: @merchant_3.id, unit_price: 30)
      @customer_3 = create(:customer)
      @invoice_3 = create(:invoice, customer_id: @customer_3.id, merchant_id: @merchant_3.id, status: 'shipped' )
      @invoice_item_3 = create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_3.id)
      @transaction_3 = create(:transaction, invoice_id: @invoice_3.id, result: "success")

      @merchant_4 = create(:merchant)
      @item_4 = create(:item, merchant_id: @merchant_4.id, unit_price: 40)
      @customer_4 = create(:customer)
      @invoice_4 = create(:invoice, customer_id: @customer_4.id, merchant_id: @merchant_4.id, status: 'shipped' )
      @invoice_item_4 = create(:invoice_item, item_id: @item_4.id, invoice_id: @invoice_4.id)
      @transaction_4 = create(:transaction, invoice_id: @invoice_4.id, result: "success")

      get "/api/v1/revenue/merchants/most_revenue?quantity=5"

      response = parse(@response)

      expect(response[:data]).to have_key(:id)
      expect(response[:data][:id]).to be_a(String)
      expect(response[:data][:id].to_i).to eq(@merchant.id)

      expect(response[:data]).to have_key(:type)
      expect(response[:data][:type]).to be_a(String)
      expect(response[:data][:type].capitalize).to eq("merchant_revenue")

      expect(response[:data]).to have_key(:attributes)
      expect(response[:data][:attributes]).to be_a(Hash)

      expect(response[:data][:attributes]).to have_key(:revenue)
      expect(response[:data][:attributes][:revenue]).to be_a(Float)
    end

    # it "returns an error if given an invalid merchant id" do
    #   @merchant = create(:merchant)
    #   # @items = create_list(:item, , merchant_id: @merchant.id)
    #   # item has shipped and transaction is successful
    #
    #   get "/api/v1/revenue/merchants/999999999"
    #
    #   response = parse(@response)
    #   expect(response).to be_successful?
    #   expect(response[:data]).to
    # end
  end
  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end


# total revenue for a given merchant


# This endpoint should return a variable number of merchants ranked by total revenue.
#
# GET /api/v1/merchants/most_revenue?quantity=x
