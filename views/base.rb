class Base < Erector::Widget
  def cal_date(date)
    date.strftime("%Y.%m.%d")
  end
end
