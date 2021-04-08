require 'rails_helper'

RSpec.describe "When I visit /api/v1/revenue/unshipped i see the potential revenue for those invoices" do
  describe "the json returns merchant id, type, and attributes of revenue" do
    it "can visit the page and return the revenue" do
      @merchant = create(:merchant)
      @customer_1= create(:customer)
      @item_1 = create(:item, merchant_id: @merchant.id, unit_price: 1)
      @invoice_1 = create(:invoice, customer_id: @customer_1.id, merchant_id: @merchant.id, status: 'shipped' )
      @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id)
      @transaction_1 = create(:transaction, invoice_id: @invoice_1.id, result: "success")

      @item_2 = create(:item, merchant_id: @merchant.id, unit_price: 2)
      @customer_2 = create(:customer)
      @invoice_2 = create(:invoice, customer_id: @customer_2.id, merchant_id: @merchant.id, status: 'shipped' )
      @invoice_item_2 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_2.id)
      @transaction_2 = create(:transaction, invoice_id: @invoice_2.id, result: "success")

      @item_3 = create(:item, merchant_id: @merchant.id, unit_price: 3)
      @customer_3 = create(:customer)
      @invoice_3 = create(:invoice, customer_id: @customer_3.id, merchant_id: @merchant.id, status: 'shipped' )
      @invoice_item_3 = create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_3.id)
      @transaction_3 = create(:transaction, invoice_id: @invoice_3.id, result: "success")

      @item_4 = create(:item, merchant_id: @merchant.id, unit_price: 4)
      @customer_4 = create(:customer)
      @invoice_4 = create(:invoice, customer_id: @customer_4.id, merchant_id: @merchant.id, status: 'shipped' )
      @invoice_item_4 = create(:invoice_item, item_id: @item_4.id, invoice_id: @invoice_4.id)
      @transaction_4 = create(:transaction, invoice_id: @invoice_4.id, result: "success")

      @item_5 = create(:item, merchant_id: @merchant.id, unit_price: 5)
      @customer_5 = create(:customer)
      @invoice_5 = create(:invoice, customer_id: @customer_5.id, merchant_id: @merchant.id, status: 'shipped' )
      @invoice_item_5 = create(:invoice_item, item_id: @item_5.id, invoice_id: @invoice_5.id)
      @transaction_5 = create(:transaction, invoice_id: @invoice_5.id, result: "success")

      @item_6 = create(:item, merchant_id: @merchant.id, unit_price: 6)
      @customer_6 = create(:customer)
      @invoice_6 = create(:invoice, customer_id: @customer_6.id, merchant_id: @merchant.id, status: 'shipped' )
      @invoice_item_6 = create(:invoice_item, item_id: @item_6.id, invoice_id: @invoice_6.id)
      @transaction_6 = create(:transaction, invoice_id: @invoice_6.id, result: "success")

      @item_7 = create(:item, merchant_id: @merchant.id, unit_price: 7)
      @customer_7 = create(:customer)
      @invoice_7 = create(:invoice, customer_id: @customer_7.id, merchant_id: @merchant.id , status: 'shipped')
      @invoice_item_7 = create(:invoice_item, item_id: @item_7.id, invoice_id: @invoice_7.id)
      @transaction_7 = create(:transaction, invoice_id: @invoice_7.id, result: "success")

      @item_8 = create(:item, merchant_id: @merchant.id, unit_price: 8)
      @customer_8 = create(:customer)
      @invoice_8 = create(:invoice, customer_id: @customer_8.id, merchant_id: @merchant.id, status: 'shipped' )
      @invoice_item_8 = create(:invoice_item, item_id: @item_8.id, invoice_id: @invoice_8.id)
      @transaction_8 = create(:transaction, invoice_id: @invoice_8.id, result: "success")

      @item_9 = create(:item, merchant_id: @merchant.id, unit_price: 9)
      @customer_9 = create(:customer)
      @invoice_9 = create(:invoice, customer_id: @customer_9.id, merchant_id: @merchant.id, status: 'shipped' )
      @invoice_item_9 = create(:invoice_item, item_id: @item_9.id, invoice_id: @invoice_9.id)
      @transaction_9 = create(:transaction, invoice_id: @invoice_9.id, result: "success")
      # item has shipped and transaction is successful

      get "/api/v1/revenue/unshipped"
      response = parse(@response)
      require "pry"; binding.pry

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
      expect(response[:data][:attributes][:revenue]).to eq(45.00)
    end
  end
  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
