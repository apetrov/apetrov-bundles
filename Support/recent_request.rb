#!/usr/bin/ruby
#data = STDIN.read.split("\n").reverse

def link_to_partial(rails_root,line)
  views_root = rails_root+"/app/views"

  partial = line.match(/(Rendered\s*)(\w+[\/\w+]+)/).captures.last.strip
  folder = partial.split("/")[0..-2]
  file = partial.split("/")[-1]
  file_path = views_root+"/"+folder.join("/")
  file = `find #{file_path} -name \"#{file}*\" | grep -v \".svn\"`.strip
  line = line.gsub(partial,"<a href='javascript:TextMate.system(\"mate #{file}\", null);window.close();'>#{partial}</a>")    
  #line = line.gsub(partial,"<a href='txmt://open/?url=file:/#{file}'>#{partial}</a>")
end

def link_to_code(rails_root,line)     
  #line = "/var/models/groups_controller.rb:194:in "                      
  name_and_line = line.match(/(\/app[\/\w|.+]+:\d+)/).captures.first.strip
  name,line = name_and_line.split(":")
  file_name = rails_root + name 
  "<a href='javascript:TextMate.system(\"mate #{file_name} -l #{line}\", null);window.close();'>#{name_and_line}</a>"
  # puts link
  # line = line.gsub(name_and_line.to_s,link)            
  # line
end

#echo $TM_PROJECT_DIRECTORY | /Users/apetrov/projects/scripts/recent_request.rb
rails_root = STDIN.read.strip 
data = `tail -n 2000 #{rails_root}/log/development.log`.split("\n").reverse

result = []
lasts = 0
all = []
data.each do |line|
  result<<line
  if line=~/^Processing\s/
    lasts+=1
    all<<result
    result=[]
  end
  break if lasts>3
end

result = all.reverse.flatten


counter = 1
result =result.reverse.map do |line| 
  line = line.gsub("[4;36;1m",'').gsub("[4;35;1m",'').gsub("[0;1m",'').gsub("[0m",'') 
  
  #newschool
  line = line.gsub(/(\(\d{1,2}\.?\d?ms\))/,"<b><span style='color:green;text-size:12px'>\\1</span></b>") #(17.1ms)
  line = line.gsub(/(\(\d{3}\.?\d?ms\))/,"<b><span style='color:#F88017;text-size:12px'>\\1</span></b>") #(417.1ms)
  line = line.gsub(/(\(\d{4,10}\.?\d?ms\))/,"<b><span style='color:red;text-size:12px'>\\1</span></b>") #(2417.1ms)
  
  #old school
  line = line.gsub(/(\(0.0\d{1,5}\))/,"<b><span style='color:green;text-size:12px'>\\1</span></b>") #(0.012312)
  line = line.gsub(/(\(0.[1..9]+\d{1,5}\))/,"<b><span style='color:#F88017;text-size:12px'>\\1</span></b>") #(0.012312)
  line = line.gsub(/(\([1-9].\d{1,6}\))/,"<b><span style='color:red;text-size:12px'>\\1</span></b>") #(1.123233)
  
  
  line = link_to_partial(rails_root,line) rescue line if line=~/(Rendered\s*)/
  line = link_to_code(rails_root,line) rescue line if line=~/\/app[\/w+]+/
  #line = line.gsub("(SELECT\.+$)","<span style='color:gray'>'\\1'</span>")
  #line = line.gsub("/(\w+Controller)/","<span style='color:red'>$1</span>")
  size,color = if line=~/^Completed/ || line=~/^Rendered/
    [12, :green]
  elsif line.include?("TemplateError")
    [12,:red]
  elsif line=~/^Processing/
    
    line = "#{line}<a name='request#{counter}'></a><a href='#request#{counter-1}'>Previous</a>&nbsp;<a href='#request#{counter+1}'>Next</a>"
    counter +=1
    [16, :black]
    
  elsif line=~/CACHE/ || line.include?("/gems/") || line.include?("/vendor/rails")
    [9, :gray]
  else
    [11,:black]
  end
  
  "<span style='color:#{color};font-size:#{size}px'>#{line}</span>"
  #line
end       
puts result.join("<br/>\n")
#puts result.join("\n")