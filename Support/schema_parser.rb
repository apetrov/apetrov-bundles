require "rubygems"
require "activesupport"

def create_table(name,*args,&proc)
  ActiveRecord::Schema.schema_info.tables<<ActiveRecord::Table.new(name,&proc)
end


def add_index(*args)
end


module ActiveRecord
  
  class Table
    
    attr_accessor :name,:columns
    
    def initialize(name,&proc)
      @name = name.camelize.singularize
      yield(self)
    end
    
    def method_missing(name,*args)
      @columns||={}
      @columns[args.first] = name
    end    
  end
  
  class SchemaInfo
    attr_accessor :tables
    
    def build(&proc)
      @tables = []
      yield
    end
    
    def find(name)
      name = name.camelize.singularize
      tables.select{|t| t.name == name}.first
    end
  end

  
  class Schema
    def self.schema_info
      @@schema_info
    end
    
    def self.define(version,&proc)
      @@schema_info = SchemaInfo.new
      @@schema_info.build(&proc)
    end
  end
end

require "#{ENV["TM_PROJECT_DIRECTORY"]}/db/schema.rb"