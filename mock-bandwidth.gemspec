# frozen_string_literal: true

require_relative "lib/mock/bandwidth/version"

Gem::Specification.new do |spec|
  spec.name = "mock-bandwidth"
  spec.version = Mock::Bandwidth::VERSION
  spec.authors = ['SchoolStatus Platform Team']
  spec.email = ["meemocol@gmail.com"]

  spec.summary = "This repository contains Mock::Bandwidth and Webhooks for Bandwidth's API."
  spec.description = "This repository contains Mock::Bandwidth for Bandwidth's API."
  spec.homepage = "https://github.com/schoolstatus/mock-bandwidth"
  spec.license = "MIT"
  spec.required_ruby_version = '>=2.7'

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/schoolstatus/mock-bandwidth"
  spec.metadata["changelog_uri"] = "https://github.com/schoolstatus/mock-bandwidth/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'faraday', '>= 1.0.1', '< 3.0'
  spec.add_dependency "bandwidth-sdk", ">= 14.0"
  spec.add_dependency "rufus-scheduler", ">= 3.9.1"
  spec.add_dependency "activesupport", ">= 6.0.0"
  spec.add_dependency "httparty", "~> 0.22.0"
end
