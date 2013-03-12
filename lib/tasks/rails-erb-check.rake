namespace :check do

  desc 'Syntax checks all erb files'
  task :syntax => :environment do
    files = Dir[Rails.root.join('app', 'views', '**', '*.erb')]
    success = RailsErbCheck.check_files(files)
  
    exit(success)
  end
  
end