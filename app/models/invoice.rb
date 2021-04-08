class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :transactions

  def self.revenue_of_unshipped_successful_transactions
    joins(:transactions)
    .where('result = ?', "success")
    .where('status != ?', "shipped")
    .select('invoices.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .group(:id)
    .order('revenue DESC')
  end
end
