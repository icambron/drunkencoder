class Base < Erector::Widget
  def cal_date(date)
    date.strftime("%y.%m.%d")
  end
end
