class ModelAutocomplete
  def parse(line)
    line = line.strip
    tokens = line.split(".")
    subject = tokens.first
    
    
    
    if tokens.size == 1
      if(complete_last_token?(line))
        model_method_autocompete(tokens.first)
      else
        model_name_autocomplete(tokens.first)
      end
    else
      if(complete_last_token?(line))
        object_method_autocomplete(tokens.first,'')
      else
        object_method_autocomplete(tokens.first,tokens.last)
      end
    end
  end
  
  def get_class_name(token)
    token.camelize
  end
  
  def model_name_autocomplete(subject)
    ActiveRecord::Schema.schema_info.tables.map(&:name).sort.map{|t| [t,"Class"]}
  end
  
  def model_method_autocompete(subject)
    [:minium,:maxium,:count,:find,:destroy_all, :paginate,:update_all,:update,:destroy].map(&:to_s).sort.map{|t| [t,"method"]}
  end
  
  def object_method_autocomplete(subject,object)
    table = ActiveRecord::Schema.schema_info.find(subject)
    if table
      result = []
      table.columns.keys.map(&:to_s).sort.each do |t|
        result<<[t,table.columns[t]]
      end
      result
    else
      []
    end
  end
  
  def complete_last_token?(line)
    !!line.match(/\.$/)
  end
  
  def constant?(name)
    !!name.match(/^[A-Z]\w+$/)
  end
  
  def variable?(name)
    !!name.match(/^[@|a-z]\w+$/)
  end
end


