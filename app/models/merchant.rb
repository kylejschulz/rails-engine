class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices



  def self.find_one(search)
    name = search.downcase
    merchant = Merchant.where("NAME ILike ?", "%#{name}%").order(name: :asc).limit(1).first
  end

  def self.find_all(search)
    require "pry"; binding.pry
  end

  def total_revenue
    transactions
    .where('result = ?', "success")
    .where('status = ?', "shipped")
    .pluck('sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .first
    .round(2)
    #join merchant with items where status is 'shipped', join items to invoices,
    #join invoices to transactions where result is 'success'

  end
end


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
