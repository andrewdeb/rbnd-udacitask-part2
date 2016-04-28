class LinkItem
  # include Listable
  attr_reader :description, :site_name

  def initialize(url, options={})
    @description = url
    @site_name = options[:site_name]
  end

  #method to format the site name message and variable
   def format_name
    @site_name ? 'Site Name: ' + @site_name : ''
  end

  #method to format the link description and name, use format_indent method from listable.rb
  def details
    format_indent(type: 'Link:') +
      format_indent(description: @description) +
      format_name
  end
end
