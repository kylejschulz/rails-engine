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
    .pluck('sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .first
    .round(2)
  end

  def self.with_most_revenue(quantity)
    Items
    .joins(:invoices)
    .where('result = ?', "success")
    .where('status = ?', "shipped")
    .select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) AS revenue')
    .group('merchants.id')
    .order(revenue: :desc)
    .first(quantity)
  end

  def self.merchant_with_most_items_sold(quantity)
    Items
    .joins(:invoices)
    .where('result = ?', "success")
    .where('status = ?', "shipped")
    .select('merchants.*, sum(invoice_items.quantity) AS items_sold')
    .group(:id)
    .order(:items_sold)
    .limit(quantity)

  end
end


# def best_day
#     Invoice
#     .joins(:items)
#     .where('item_id = ?', self.id)
#     .select('items.*, invoices.created_at, sum(invoice_items.unit_price * invoice_items.quantity) AS best_item_day')
#     .group('items.id, invoices.created_at')
#     .order(best_item_day: :desc)
#     .first
#   end

# def top_five_customers
#   Customer.joins(invoices: :items)
#           .where('merchant_id = ?', self.id)
#           .joins(invoices: :transactions)
#           .successful_transactions
#           .select("customers.*, count('transactions.result') as successful_transactions")
#           .group('customers.id')
#           .order(successful_transactions: :desc)
#           .limit(5)
# end
#
#
# def top_five_items
#   Item.joins(:invoice_items)
#       .where('merchant_id = ?', self.id)
#       .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
#       .group('items.id')
#       .order(total_revenue: :desc)
#       .limit(5)
# end

# scope :joins_to_transactions, -> { joins(invoices: :transactions) }
# scope :successful_transactions, -> { where('result = ?', "success") }
# scope :successful_transaction_count, -> { select("customers.*, count('transactions.result') AS successful_transactions") }
# scope :group_by_id, -> { group("customers.id") }
# scope :order_successful_transactions_desc, -> { order(successful_transactions: :desc) }
# scope :limit_five, -> { limit(5) }
#
# def self.five_top_customers_by_transactions
#   joins_to_transactions
#   .successful_transactions
#   .successful_transaction_count
#   .group_by_id
#   .order_successful_transactions_desc
#   .limit_five
# end
