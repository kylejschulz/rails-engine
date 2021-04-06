FactoryBot.define do
  factory :item do
    name { "MyString" }
    unit_price { 1.5 }
    description {'random description'}
    merchant
  end
end
