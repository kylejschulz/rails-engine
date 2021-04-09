require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "relationships" do
    it { should belong_to(:customer)}
    it { should have_many(:invoice_items)}
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many(:transactions) }
  end

  describe "class methods" do
    it "#revenue_of_unshipped_successful_transactions" do
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

      expect(Invoice.potential_revenue(2).first.revenue).to eq(12)
    end
  end
end
