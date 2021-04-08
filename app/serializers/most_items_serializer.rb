class MostItemsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name

  attributes :count do |merchant|
    merchant.items_sold
  end
end
