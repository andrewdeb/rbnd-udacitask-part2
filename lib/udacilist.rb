class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title]
    @items = []
  end

  #method to add items to a UdaciList instance
  def add(type, description, options={})
    type = type.downcase
    if type == 'todo' then @items.push TodoItem.new(description, options) #uses ToDoItem class in todo.rb
    elsif type == 'event' then @items.push EventItem.new(description, options) #uses EventItem class in event.rb
    elsif type == 'link' then @items.push LinkItem.new(description, options) #usesLinkItem class in event.rb
    else raise UdaciListErrors::InvalidItemType,
               "'#{type}' is not a valid data type" #raise error if type is not one of the 3 required
    end
  end

  #method to delete item from list, based on index number
  def delete(index)
    if index.between?(1, @items.count)
      @items.delete_at(index - 1)
    else
      raise UdaciListErrors::IndexExceedsListSize,
            "item '#{index}' does not exist"
    end
  end

  def all
    output
  end

  def output(class_filter = nil)
    output_header
    if !class_filter.nil? && !@items.any? { |item| item.is_a?(class_filter) }
      puts 'No items were found with given filter'
    else
      @items.each_with_index do |item, position|
        if class_filter.nil? || item.is_a?(class_filter)
          puts "#{position + 1}) #{item.details}"
        end
      end
    end
  end

  # prints the title inside 2 lines of dashes
  def output_header
    puts
    puts '-' * @title.length
    puts @title
    puts '-' * @title.length
  end

  #method to filter based on item type
  def filter(item_type)
    case item_type
    when 'todo' then item_type = TodoItem
    when 'event' then item_type = EventItem
    when 'link' then item_type = LinkItem
    else raise UdaciListErrors::InvalidFilterType,
               "#{type_desc} is not a valid filter type"
    end
    output(item_type)
  end

  #method to export to csv, using the csv gem
  def export_to_csv
    puts 'Please enter a file name:'
    filename = gets.chomp
    CSV.open(filename, 'w') do |csv|
      @items.each_with_index do |item, position|
        csv << [position + 1, item.details]
      end
    end
  end
end