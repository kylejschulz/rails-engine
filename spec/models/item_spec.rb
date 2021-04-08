require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe "class methods" do
    it "#find_all" do
      Item.destroy_all
      @item_21 = create(:item, name: 'ring')
      @item_21 = create(:item, name: 'turing')
      @items = create_list(:item, 20)
      expect(Item.find_all(name: 'ring').count).to eq(22)
      expect(Item.find_all(name: 'ring').first.name).to eq('MyString')
      expect(Item.find_all(name: 'ring').last.name).to eq('turing')
    end

    it "#find_all" do
      @item_1 = create(:item, name: 'apple', unit_price: 99)
      @item_2 = create(:item, name: 'turing', unit_price: 101)

      expect(Item.find_all({ min_price: 100 })).to eq([@item_2])
    end

    it "#find_all" do
      @item_1 = create(:item, name: 'apple', unit_price: 1001)
      @item_2 = create(:item, name: 'turing', unit_price: 999)
      expect(Item.find_all({ max_price: 1000 })).to eq([@item_2])
    end

    it "#min_or_max" do
      @item_1 = create(:item, name: 'apple', unit_price: 1001)
      @item_2 = create(:item, name: 'turing', unit_price: 999)

      expect(Item.min_or_max({ min_price: 1000 })).to eq([@item_1])
    end

    it "#min_and_max" do
      @item_1 = create(:item, name: 'apple', unit_price: 1001)
      @item_2 = create(:item, name: 'turing', unit_price: 999)
      expect(Item.min_and_max({ min_price: 998, max_price: 1002 })).to eq([@item_2, @item_1])

    end
    it "#min_price" do
      @item_1 = create(:item, name: 'apple', unit_price: 1001)
      @item_2 = create(:item, name: 'turing', unit_price: 999)
      expect(Item.min_price(100)).to eq([@item_2, @item_1])
    end

    it "#max_price" do
      @item_1 = create(:item, name: 'apple', unit_price: 1001)
      @item_2 = create(:item, name: 'turing', unit_price: 999)
      expect(Item.max_price(1000)).to eq([@item_2])
    end

    it "#name_search" do
      @item_1 = create(:item, name: 'apple', unit_price: 1001)
      @item_2 = create(:item, name: 'turing', unit_price: 999)
      @item_3 = create(:item, name: 'turings', unit_price: 999)

      expect(Item.name_search("ring")).to eq([@item_2, @item_3])
    end
  end
end
