require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customer).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe "class methods" do
    it "#find_one" do
      expect(Merchant.find_one('ring')).to eq()
    end

    it "#with_most_revenue" do
      expect(Merchant.with_most_revenue(5).count).to eq(5)
      expect(Merchant.with_most_revenue(1)).to eq(5)
    end

    it "#merchant_with_most_items_sold" do
      expect(Merchant.with_most_items_sold(5).count).to eq(5)
      expect(Merchant.with_most_items_sold(1).count).to eq(5)
    end

  describe "instance methods" do
    it "#total_revenue" do
      expect(@merchant_1.total_revenue).to eq(100)
    end
  end
end
