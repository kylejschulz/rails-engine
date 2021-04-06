class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items


  def self.find_all(args)
    if args[:name].nil?
      min_or_max(args)
    else
      name(args[:name])
    end

  end

  def min_or_max(args)
    if !args[:min_price].nil? && !args[:max_price].nil?
      min_and_max(args)
    elsif !args[:min_price].nil?
      max_price(args[:max_price])
    else !args[:max_price].nil?
      min_price(args[:min_price])
    end
  end

  def min_and_max(args)
    min = args[:min_price]
    max = args[:max_price]
    Items.where("unit_price < ? AND unit_price > ?", min, max).order(unit_price: :asc)

  end

  def min_price(min_price)
    min = args[:min_price]
    Items.where("unit_price < ?", min).order(unit_price: :asc)
  end

  def max_price(max_price)
    max = args[:max_price]
    Items.where("unit_price > ?", max).order(unit_price: :asc)
  end

  def name(search)
    name = search.downcase
    Items.where("NAME ILike ?", "%#{name}%").order(name: :asc)
  end
end
