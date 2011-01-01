class RailsBaseFile
  attr_accessor :name,:full_name
  
  def match?(file)
    result=false
    alternatives.each { |a| result||=a.last.match(file) }
    result
  end
  
  def alternatives
    @alternatives||=self.raw_alternatives.map{|t| RailsAssociation.new(t.first,t[1],t.last)}
  end
end


class RailsAssociation
  attr_accessor :kind #RailsBaseFile
  attr_accessor :name #'object'
  attr_accessor :pattern #regexp
  def initialize(kind,name,pattern)
    @kind,@name,@pattern=constantize(kind),name,pattern.is_a?(String) ? Regexp.new(pattern) : pattern
    RailsAssociation.project||=ProjectScanner.new
  end
  
  def to_file_name
    @real_name||=RailsAssociation.project.files.select{|f| f.match(self.pattern)}.first
  end
  
  def to_s
    "#{name} (#{to_file_name})"
  end
  
  
  class<<self
    attr_accessor :project
  end
  
  
  def constantize(kind)
    "Rails#{kind.to_s.titlecase}".constantize
  end
end