class RailsController < RailsBaseFile
  attr_accessor :resources
  def initialize(name)
    @name=name.split("/").last.split(".").first
    @resource = @name.gsub("_controller",'').singularize
    @resources = @name.gsub("_controller",'')
    @full_name = name
  end
  
  
  def current_action
    lines = File.read(ENV['TM_FILEPATH']).split("\n")
    current_line = ENV['TM_LINE_NUMBER'].to_i
    action  = nil
    while(current_line>=0)
      line=lines[current_line]

      if line.match(/def\s+(\w+)[\(.\)]*/)
        action = $1
        break
      end

      current_line-=1
    end
    action ? [[:view, "#{action} #{@resources}","app/views/#{@resources}/_?#{action}"]] : []
  end
  
  def raw_alternatives
    
    
    current_action + 
    [
      [:model,"Model #{@resource}","app/models/#{@resource}"],
      [:view,"Index #{@resources}","app/views/#{@resources}/index"],
      [:view,"New #{@resources}","app/views/#{@resources}/new"],
      [:view,"Create #{@resources}","app/views/#{@resources}/create"],
      [:view,"Show #{@resources}","app/views/#{@resources}/show"],
      [:view,"Edit #{@resources}","app/views/#{@resources}/edit"],
      [:view,"Update #{@resources}","app/views/#{@resources}/update"],
      [:view,"Destroy #{@resources}","app/views/#{@resources}/destroy"],
      [:view,"Form #{@resources}","app/views/#{@resources}/_form"],
      [:view,"Object #{@resources}","app/views/#{@resources}/_object"]
    ]
  end
end