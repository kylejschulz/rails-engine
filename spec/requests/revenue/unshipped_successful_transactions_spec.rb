require 'rails_helper'

RSpec.describe "When I visit /api/v1/revenue/unshipped i see the potential revenue for those invoices" do
  describe "the json returns merchant id, type, and attributes of revenue" do
    it "can visit the page and return the revenue" do
      @merchant = create(:merchant, name: 'merchant 1')
      @customer_1= create(:customer)
      @item_1 = create(:item, merchant_id: @merchant.id, unit_price: 1)
      @invoice_1 = create(:invoice, customer_id: @customer_1.id, merchant_id: @merchant.id, status: 'shipped' )
      @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: 2)
      @transaction_1 = create(:transaction, invoice_id: @invoice_1.id, result: "success")

      @item_2 = create(:item, merchant_id: @merchant.id)
      @customer_2 = create(:customer)
      @invoice_2 = create(:invoice, customer_id: @customer_2.id, merchant_id: @merchant.id, status: 'shipped' )
      @invoice_item_2 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 2, unit_price: 3)
      @transaction_2 = create(:transaction, invoice_id: @invoice_2.id, result: "success")
      @item_2 = create(:item, merchant_id: @merchant.id, unit_price: 6)

      @item_3 = create(:item, merchant_id: @merchant.id)
      @customer_3 = create(:customer)
      @invoice_3 = create(:invoice, customer_id: @customer_3.id, merchant_id: @merchant.id, status: 'in progress' )
      @invoice_item_3 = create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_3.id, quantity: 3, unit_price: 4)
      @transaction_3 = create(:transaction, invoice_id: @invoice_3.id, result: "success")

      @item_4 = create(:item, merchant_id: @merchant.id, unit_price: 11)
      @customer_4 = create(:customer)
      @invoice_4 = create(:invoice, customer_id: @customer_4.id, merchant_id: @merchant.id, status: 'shipped' )
      @invoice_item_4 = create(:invoice_item, item_id: @item_4.id, invoice_id: @invoice_4.id, quantity: 4, unit_price: 5)
      @transaction_4 = create(:transaction, invoice_id: @invoice_4.id, result: "failed")


      get "/api/v1/revenue/unshipped?quantity=2"

      response = parse(@response)
      expect(response[:data].first).to have_key(:id)
      expect(response[:data].first[:id]).to be_a(String)
      expect(response[:data].first[:id].to_i).to eq(@invoice_3.id)

      expect(response[:data].first).to have_key(:type)
      expect(response[:data].first[:type]).to be_a(String)
      expect(response[:data].first[:type].capitalize).to eq("Unshipped_order")

      expect(response[:data].first).to have_key(:attributes)
      expect(response[:data].first[:attributes]).to be_a(Hash)

      expect(response[:data].first[:attributes]).to have_key(:potential_revenue)
      expect(response[:data].first[:attributes][:potential_revenue]).to be_a(Float)
      expect(response[:data].first[:attributes][:potential_revenue]).to eq(12)
    end
  end
  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
