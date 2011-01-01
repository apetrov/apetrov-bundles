class RailsView < RailsBaseFile
  def initialize(name)
    @name = name.split("/").last.split(".").first
    @controller = name.split("/")[-2]
  end
  
  
  def raw_alternatives
    [
      [:controller,"controller #{@controller}","app/controllers/#{@controller}"]
    ]
  end
end