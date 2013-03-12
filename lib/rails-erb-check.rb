require 'action_view'

module RailsErbCheck
  require 'rails-erb-check/railtie' if defined?(Rails)
  
  def self.check_files(file_paths)
    success = true
    
    file_paths.each do |file|
      relative_path = Pathname.new(file).relative_path_from(Rails.root)
    
      begin
        ActionView::Template::Handlers::Erubis.new(File.read(file)).result
  
        puts "#{relative_path}\e[34m => \e[32mvalid\e[0m"
      rescue SyntaxError => ex
        puts "#{relative_path}\e[34m => \e[31minvalid\e[0m"
        puts ex
        
        success = false
      rescue Exception
        # Assume ok, exception caused because output fails, but parsing has succeeded
      end
    end
    
    success
  end
end