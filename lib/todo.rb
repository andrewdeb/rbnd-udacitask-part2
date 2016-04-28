class TodoItem
  # include Listable
  require_relative "listable"
  attr_reader :description, :due, :priority

  #initialize the class instance and use Chronic gem to parse the date
  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
     @priority = validated_priority(options[:priority])
  end

  #method to format the item in the list, calling on methods in listable.rb
  def details
    format_indent(type: 'Todo:') +
      format_indent(description: @description) +
      'Due: ' +
      format_date(@due) +
      format_priority(@priority) #uses formatdate and format_priority method from listable.rb
  end

  #method to format priority, uses method from listable.rb and raises error if priority is invalid
  def validated_priority(priority)
    if ['high', 'medium', 'low', nil].include?(priority)
      priority
    else
      raise InvalidPriorityValue, "'#{priority}' is not a valid priority" #calls on error in errors.rb
    end
  end
end