require 'action_view'
require 'pathname'
require 'ripper'

module RailsErbCheck
  require 'rails-erb-check/railtie' if defined?(Rails::Railtie)

  # Compiles the ERB source to Ruby (without executing it) and checks the Ruby syntax.
  def self.syntax_error(source)
    ruby_src = ActionView::Template::Handlers::ERB::Erubi.new(source).src
    # Rails compiles templates as method bodies, so wrap the source the same way
    # (e.g. to allow `yield`).
    wrapped_src = "def __rails_erb_check_template(local_assigns, output_buffer)\n#{ruby_src}\nend"
    check_ruby_syntax(wrapped_src)
    nil
  rescue SyntaxError => ex
    ex
  end

  # Line numbers start one line early so they stay aligned with the template.
  def self.check_ruby_syntax(src)
    if defined?(RubyVM::InstructionSequence)
      RubyVM::InstructionSequence.compile(src, nil, nil, 0)
    else
      # Portable fallback (e.g. JRuby): Ripper parses without executing any code.
      SyntaxChecker.check(src, '<compiled>', 0)
    end
  end
  private_class_method :check_ruby_syntax

  class SyntaxChecker < Ripper
    def self.check(src, file, line)
      checker = new(src, file, line)
      checker.parse
      return unless checker.error? || checker.errors.any?

      messages = checker.errors.empty? ? ["#{file}: syntax error"] : checker.errors
      raise SyntaxError, messages.join("\n")
    end

    def errors
      @errors ||= []
    end

    def on_parse_error(message)
      errors << "#{filename}:#{lineno}: #{message}"
    end
    alias compile_error on_parse_error

    # Semantic errors (e.g. dynamic constant assignment). The message argument
    # is only passed on newer Rubies; the last argument is always the node.
    %w(alias_error assign_error class_name_error param_error).each do |event|
      define_method("on_#{event}") do |*args|
        message = args.length > 1 ? args.first : event.tr('_', ' ')
        errors << "#{filename}:#{lineno}: #{message}"
        args.last
      end
    end
  end
  private_constant :SyntaxChecker

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
