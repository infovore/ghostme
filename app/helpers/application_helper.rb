module ApplicationHelper
  def format_time(time)
    time.strftime("%H:%M")
  end

  def format_date(time)
    time.strftime("%d %B %Y")
  end

  def format_datetime(time)
    "#{format_date(time)}, #{format_time(time)}"
  end
end
