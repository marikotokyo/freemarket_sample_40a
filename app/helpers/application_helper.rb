module ApplicationHelper
  def profit(price)
    profit = (price * 0.9).ceil
    "￥ #{profit} "
  end

  def commission(price)
     commission = (price * 0.1).floor
    "￥ #{commission} "
  end
end
