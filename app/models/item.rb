class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  def self.find_all(args)
    if args[:name]
      name_search(args[:name])
    else
      min_or_max(args)
    end
  end

  def self.min_or_max(args)
    if args[:min_price] && args[:max_price]
      min_and_max(args)
    elsif args[:min_price]
      min_price(args[:min_price])
    else args[:max_price]
      max_price(args[:max_price])
    end
  end

  def self.min_and_max(args)
    min = args[:min_price]
    max = args[:max_price]
    Item.where("unit_price > ? AND unit_price < ?", min, max).order(:unit_price)

  end

  def self.min_price(args)
    min = args
    Item.where("unit_price > ?", min).order(unit_price: :asc)
  end

  def self.max_price(args)
    max = args
    Item.where("unit_price < ?", max).order(unit_price: :asc)
  end

  def self.name_search(search)
    name = search.downcase
    Item.where("NAME ILike ?", "%#{name}%").order(:name)
  end
end
