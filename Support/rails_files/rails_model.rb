

class RailsModel < RailsBaseFile
  

  def initialize(name)
    @name=name.split("/").last.split(".").first
    @full_name = name
  end
  
  def raw_alternatives
    [
      [:controller,"#{name} controller","app/controllers/#{name}s?_controller.rb"],
      [:view,"Index #{@name}","app/views/#{@name}s?/index"],
      [:view,"New #{@name}","app/views/#{@name}s?/new"],
      [:view,"Create #{@name}","app/views/#{@name}s?/create"],
      [:view,"Show #{@name}","app/views/#{@name}s?/show"],
      [:view,"Edit #{@name}","app/views/#{@name}s?/edit"],
      [:view,"Update #{@name}","app/views/#{@name}s?/update"],
      [:view,"Destroy #{@name}","app/views/#{@name}s?/destroy"],
      [:view,"Form #{@name}","app/views/#{@name}s?/_form"],
      [:view,"Object #{@name}","app/views/#{@name}s?/_object"]
    ]
    
  end  
end