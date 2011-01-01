class ReverseFilename
  def parse(name)
    klass = case name
    when /app\/models/
      RailsModel
    when /app\/controllers/
      RailsController
    when /app\/views/
      RailsView
    end
    klass.new(name)
  end
  
end