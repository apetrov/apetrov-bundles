class FormBuilder
  def FormBuilder.form_for(name)
    table = ActiveRecord::Schema.schema_info.tables.find{|t| t.name.downcase == name.downcase}
    
    output=["%table"]
    puts table.columns.inspect
    table.columns.each_pair do |name,type|
    
      output<<"\t%tr"
      output<<"\t\t%td"
      output<<"\t\t\t=f.label :#{name},\"#{name.humanize}\""
      
      
      
      
      output<<"\t\t%td"
      if(name.match(/password/))
        output<<"\t\t\t=f.password_field(:#{name})"
      elsif(type == :string || (type == :integer && !name.match(/_id$/)) )
        output<<"\t\t\t=f.text_field(:#{name})"
      elsif(type == :integer && name.match(/_id$/) )
        assoc_name = name.gsub(/_id$/,'').camelize
        output<<"\t\t\t=f.select(:#{name}, #{assoc_name}.all.map{|t| [t.name, t.id]})"
      elsif type == :datetime
        output<<"\t\t\t=f.datetime_select(:#{name}, {:include_blank=>true})"
      elsif type == :date
        output<<"\t\t\t=f.date_select(:#{name}, {:include_blank=>true})"
      elsif type == :boolean
        output<<"\t\t\t=f.check_box(:#{name})"
      elsif type == :text
        output<<"\t\t\t=f.text_area(:#{name}, :size => \"20x20\")"
      end
      
    end
    puts output.join("\n")
  end
end

