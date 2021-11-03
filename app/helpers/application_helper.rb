module ApplicationHelper
  def calculate_balance(debit, credit)
    debit ||= 0
    credit ||= 0
    (debit - credit).round(4)
  end

  def calculate_total_balance(running_total, item_balance)
    running_total ||= 0
    item_balance ||= 0
    (running_total + item_balance).round(4)
  end
end
