require ENV['TM_SUPPORT_PATH'] + '/lib/textmate.rb'
require ENV['TM_SUPPORT_PATH'] + '/lib/ui.rb'

class AlternateFile
  def self.open(path='app')
    dir = ENV["TM_PROJECT_DIRECTORY"]||'/Users/apetrov/projects/quevita/rc'
    absolute_path = File.join(dir,path)
    Dir.chdir(absolute_path)
    collection = [".."]+Dir["*"]
    file_name = collection[TextMate::UI.menu(collection)]
    selected_value = File.join(absolute_path,file_name)
    if(File.directory?(selected_value))
      AlternateFile.open(path+"/"+file_name)
    else
      TextMate.go_to({:file=>selected_value})
    end
    
    
  end
end

#ENV.inspect{"Apple_PubSub_Socket_Render"=>"/tmp/launch-3qf2zk/Render", "BASH_ENV"=>"/Applications/TextMate.app/Contents/SharedSupport/Support/lib/bash_init.sh", "COMMAND_MODE"=>"legacy", "DIALOG"=>"/Applications/TextMate.app/Contents/PlugIns/Dialog2.tmplugin/Contents/Resources/tm_dialog2", "DIALOG_1"=>"/Applications/TextMate.app/Contents/PlugIns/Dialog.tmplugin/Contents/Resources/tm_dialog", "DIALOG_1_PORT_NAME"=>"com.macromates.dialog_1.34441", "DIALOG_PORT_NAME"=>"com.macromates.dialog.34441", "DISPLAY"=>"/tmp/launch-FIEO0V/:0", "HOME"=>"/Users/apetrov", "LOGNAME"=>"apetrov", "PATH"=>"/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/texbin:/usr/X11/bin:/usr/texbin", "SECURITYSESSIONID"=>"fb3920", "SHELL"=>"/bin/bash", "SHLVL"=>"1", "SSH_AUTH_SOCK"=>"/tmp/launch-AEntz7/Listeners", "TMPDIR"=>"/var/folders/iI/iIngwxEjE7CuTf3dGqNI4++++TI/-Tmp-/", "TMTOOLS"=>"/Users/apetrov/Library/Application Support/TextMate/PlugIns/TMTools.tmplugin/Contents/Resources/tm_tools", "TM_APP_PATH"=>"/Applications/TextMate.app", "TM_BUNDLE_PATH"=>"/Users/apetrov/Library/Application Support/TextMate/Bundles/Alexander.tmbundle", "TM_BUNDLE_SUPPORT"=>"/Users/apetrov/Library/Application Support/TextMate/Bundles/Alexander.tmbundle/Support", "TM_COLUMNS"=>"111", "TM_COLUMN_NUMBER"=>"21", "TM_COMMENT_END_2"=>"=end\n", "TM_COMMENT_START"=>"# ", "TM_COMMENT_START_2"=>"=begin\n", "TM_CURRENT_LINE"=>"    puts ENV.inspect", "TM_CURRENT_WORD"=>"inspect", "TM_DIRECTORY"=>"/Users/apetrov/Library/Application Support/TextMate/Bundles/Alexander.tmbundle/Support", "TM_FILENAME"=>"alternate_file.rb", "TM_FILEPATH"=>"/Users/apetrov/Library/Application Support/TextMate/Bundles/Alexander.tmbundle/Support/alternate_file.rb", "TM_FULLNAME"=>"Alexander Petrov", "TM_INPUT_START_COLUMN"=>"1", "TM_INPUT_START_LINE"=>"3", "TM_INPUT_START_LINE_INDEX"=>"0", "TM_LINE_INDEX"=>"20", "TM_LINE_NUMBER"=>"3", "TM_LINK_FORMAT"=>"(this language is not supported, see … for more info)", "TM_MODE"=>"Ruby on Rails", "TM_ORGANIZATION_NAME"=>"__MyCompanyName__", "TM_PID"=>"34441", "TM_SCOPE"=>"source.ruby.rails", "TM_SOFT_TABS"=>"YES", "TM_SUPPORT_PATH"=>"/Applications/TextMate.app/Contents/SharedSupport/Support", "TM_TAB_SIZE"=>"2", "USER"=>"apetrov", "__CF_USER_TEXT_ENCODING"=>"0x1F5:0:0"}