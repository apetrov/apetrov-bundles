require ENV['TM_SUPPORT_PATH'] + '/lib/textmate.rb'
require ENV['TM_SUPPORT_PATH'] + '/lib/ui.rb'
require 'rubygems'
require 'activesupport'

class ProjectScanner
  def scan
    unless self.actual?
      %x{cd '#{ENV['TM_PROJECT_DIRECTORY']}'; find .  -name '*' | sed s/^..// | grep [^\.] > #{file_name} }
    end
  end

  def actual?()
    File.exists?(full_name)  && (File.atime(full_name)) > 10.minute.ago
  end

  def self.observe
    t = Thread.new do
      loop do
        ProjectScanner.new.scan
        sleep 1.minute
      end
    end
    #t.join
  end
  
  def files
    @files||= File.read(full_name).split("\n").select{|t| !t.include?(".svn")}
  end
  

  def full_name
    File.join(ENV['TM_PROJECT_DIRECTORY'],file_name)
  end

  def file_name
    '.tmfiles'
  end
end

ProjectScanner.new.scan

require File.dirname(__FILE__)+"/rails_files/init.rb"

filename = ENV['TM_FILEPATH'].gsub(ENV['TM_PROJECT_DIRECTORY']+"/",'')
files = ReverseFilename.new.parse(filename).alternatives.select{|t| t.to_file_name}
file = files[TextMate::UI.menu(files.map(&:to_s))]
TextMate.go_to({:file=>File.join(ENV['TM_PROJECT_DIRECTORY'],file.to_file_name)}) rescue nil

# 
# puts ReverseFilename.new.parse('app/controllers/trailers_controller.rb').alternatives.inspect
# puts ReverseFilename.new.parse('app/controllers/trailers_controller.rb').alternatives.map(&:to_file_name)
# puts ReverseFilename.new.parse('app/models/trailer.rb').alternatives.map(&:to_file_name)
#puts ReverseFilename.new.parse('app/models/user.rb').alternatives.map(&:to_file_name)
#puts ReverseFilename.new.parse('app/views/users/_form.rb')