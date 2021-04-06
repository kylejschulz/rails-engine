class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items


  def self.find_one(search)
    name = search.downcase
    merchant = Merchant.where("NAME ILike ?", "%#{name}%").order(name: :asc).limit(1).first
  end

  def self.find_all(search)

  end
end
