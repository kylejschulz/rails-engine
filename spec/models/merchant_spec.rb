require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe "class methods" do
    it "#find_one" do
      Merchant.destroy_all
      @merchant_21 = create(:item, name: 'ring')
      @merchant_21 = create(:item, name: 'turing')
      @merchants = create_list(:item, 20)
      expect(Merchant.find_one('ring').name).to eq(@merchants[0].name)
    end

    it "#with_most_revenue" do
      @merchant = create(:merchant, name: 'merchant 1')
      @customer_1= create(:customer)
      @item_1 = create(:item, merchant_id: @merchant.id )
      @invoice_1 = create(:invoice, customer_id: @customer_1.id, merchant_id: @merchant.id, status: 'shipped' )
      @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: 1)
      @transaction_1 = create(:transaction, invoice_id: @invoice_1.id, result: "success")

      @merchant_2 = create(:merchant, name: 'merchant 2')
      @item_2 = create(:item, merchant_id: @merchant_2.id)
      @customer_2 = create(:customer)
      @invoice_2 = create(:invoice, customer_id: @customer_2.id, merchant_id: @merchant.id, status: 'shipped' )
      @invoice_item_2 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 2, unit_price: 1)
      @transaction_2 = create(:transaction, invoice_id: @invoice_2.id, result: "success")
      expect(Merchant.with_most_revenue(1)).to eq([@merchant_2])
    end

    it "#merchant_with_most_items_sold" do
      @merchant = create(:merchant, name: 'merchant 1')
      @customer_1= create(:customer)
      @item_1 = create(:item, merchant_id: @merchant.id)
      @invoice_1 = create(:invoice, customer_id: @customer_1.id, merchant_id: @merchant.id, status: 'shipped' )
      @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 1)
      @transaction_1 = create(:transaction, invoice_id: @invoice_1.id, result: "success")

      @merchant_2 = create(:merchant, name: 'merchant 2')
      @item_2 = create(:item, merchant_id: @merchant_2.id)
      @customer_2 = create(:customer)
      @invoice_2 = create(:invoice, customer_id: @customer_2.id, merchant_id: @merchant.id, status: 'shipped' )
      @invoice_item_2 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 6)
      @transaction_2 = create(:transaction, invoice_id: @invoice_2.id, result: "success")

      @merchant_3 = create(:merchant, name: 'merchant 3')
      @item_3 = create(:item, merchant_id: @merchant_3.id)
      @customer_3 = create(:customer)
      @invoice_3 = create(:invoice, customer_id: @customer_3.id, merchant_id: @merchant.id, status: 'shipped' )
      @invoice_item_3 = create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_3.id, quantity: 10)
      @transaction_3 = create(:transaction, invoice_id: @invoice_3.id, result: "success")
      expect(Merchant.with_most_items_sold(2)).to eq([@merchant_3, @merchant_2])
      expect(Merchant.with_most_items_sold(1)).to eq([@merchant_3])
    end
  end

  describe "instance methods" do
    it "#total_revenue" do
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

      expect(@merchant.total_revenue).to eq(8)
    end
  end
end
