require 'action_view'
require 'pathname'

module RailsErbCheck
  require 'rails-erb-check/railtie' if defined?(Rails::Railtie)

  # Compiles the ERB source to Ruby (without executing it) and checks the Ruby syntax.
  def self.syntax_error(source)
    ruby_src = ActionView::Template::Handlers::ERB::Erubi.new(source).src
    RubyVM::InstructionSequence.compile(ruby_src)
    nil
  rescue SyntaxError => ex
    ex
  end

  def self.valid_syntax?(source)
    syntax_error(source).nil?
  end

  def self.check_files(file_paths)
    success = true

    file_paths.each do |file|
      error = syntax_error(File.read(file))
      next unless error

      relative_path = Pathname.new(File.expand_path(file)).relative_path_from(Rails.root)
      puts "#{relative_path}\e[34m => \e[31minvalid\e[0m"
      puts error

      success = false
    end

    puts "Checked #{file_paths.length} files"

    success
  end
end
