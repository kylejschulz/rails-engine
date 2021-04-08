class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :transactions

  def revenue_of_unshipped_successful_transactions
    Transaction
    .where('result = ?', "success")
    .where('status != ?', "shipped")
    .pluck('sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    #how do i compress all of these down into one row and add the sum?
  end
end
