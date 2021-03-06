# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: rails-erb-check 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "rails-erb-check".freeze
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["jugyo".freeze]
  s.date = "2019-12-13"
  s.description = "A command to check syntax as rails's erb. It provides the rails-erb-check command.".freeze
  s.email = "jugyo.org@gmail.com".freeze
  s.executables = ["rails-erb-check".freeze]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "bin/rails-erb-check",
    "lib/rails-erb-check.rb",
    "lib/rails-erb-check/railtie.rb",
    "lib/tasks/rails-erb-check.rake",
    "rails-erb-check.gemspec",
    "spec/fixtures/invalid1.erb",
    "spec/fixtures/invalid2.erb",
    "spec/fixtures/valid1.erb",
    "spec/fixtures/valid2.erb",
    "spec/rails-erb-check_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/jugyo/rails-erb-check".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "A command to check syntax as rails's erb.".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<actionpack>.freeze, ["= 6.0.0"])
      s.add_runtime_dependency(%q<railties>.freeze, ["= 6.0.0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_development_dependency(%q<jeweler>.freeze, [">= 0"])
    else
      s.add_dependency(%q<actionpack>.freeze, ["= 6.0.0"])
      s.add_dependency(%q<railties>.freeze, ["= 6.0.0"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_dependency(%q<jeweler>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<actionpack>.freeze, ["= 6.0.0"])
    s.add_dependency(%q<railties>.freeze, ["= 6.0.0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<jeweler>.freeze, [">= 0"])
  end
end

