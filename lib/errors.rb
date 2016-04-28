module UdaciListErrors
  # Error classes go here
  class InvalidItemType < StandardError
  end

  class IndexExceedsListSize < StandardError
  end

  class InvalidPriorityValue < StandardError
  end
  
end

# add error if priority value is not valid
module TodoErrors
  class InvalidPriorityValue < StandardError
  end
end
