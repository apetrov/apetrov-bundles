prefix = File.dirname(__FILE__)

['rails_base_file','rails_controller','rails_model','rails_view','reverse_filename'].each { |f| require "#{prefix}/#{f}.rb"  }