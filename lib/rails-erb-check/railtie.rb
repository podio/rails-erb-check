module RailsErbCheck
  class Railtie < Rails::Railtie
    railtie_name :rails_erb_check

    rake_tasks do
      load "tasks/rails-erb-check.rake"
    end
  end
end