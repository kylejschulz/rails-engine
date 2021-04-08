class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  scope :successful_transactions, -> { where('result = ?', "success") }
  scope :shipped_items, -> { where('status = ?', "shipped") }



  def self.find_one(search)
    name = search.downcase
    merchant = Merchant.where("NAME ILike ?", "%#{name}%").order(name: :asc).limit(1).first
  end

  def total_revenue
    transactions
    .where('result = ?', "success")
    .where('status = ?', "shipped")
    .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price)')
    .first
    .round(2)
  end

  def self.with_most_revenue(quantity)
    joins(items: { invoices: :transactions })
    .where('transactions.result = ?', "success")
    .where('invoices.status = ?', "shipped")
    .select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) AS revenue')
    .group('merchants.id')
    .order('revenue DESC')
    .limit(quantity)
  end

  def self.with_most_items_sold(quantity)
    joins(items: { invoices: :transactions })
    .select('merchants.*, sum(invoice_items.quantity) as items_sold')
    .where('transactions.result = ?', "success")
    .where('invoices.status = ?', "shipped")
    .group(:id)
    .order('items_sold DESC')
    .limit(quantity)
  end

  # def items_sold
  #   invoices.joins(:transactions)
  #   .where('transactions.result = ?', "success")
  #   .where('invoices.status = ?', "shipped")
  #   .pluck('sum(invoice_items.quantity)')
  #   .first
  # end
end
