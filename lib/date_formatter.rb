module DateFormatter
  # convert a date to human format
  def humanize_date(date)
    date.strftime("%m/%d/%Y")
  end
  
  # convert a string to a date (using Chronic, of course)
  def convert_to_date(string)
    Chronic.parse(string).to_date
  end
  
  # convert a string to a datetime (Chronic's default)
  def convert_to_datetime(string)
    Chronic.parse(string)
  end
end