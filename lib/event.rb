class EventItem
  # include Listable
  require_relative "listable"
  attr_reader :description, :start_date, :end_date

  #method to initialize and use the Chronic gem to parse the start and end dates
  def initialize(description, options={})
    @description = description
    @start_date = Chronic.parse(options[:start_date]) if options[:start_date]
    @end_date = Chronic.parse(options[:end_date]) if options[:end_date]
  end

  def details
    row = [] #define an array
    row << format_description(@description)
    row << "event dates: " + format_date(:dual_dates, start_date: @start_date, end_date: @end_date)
  end

end