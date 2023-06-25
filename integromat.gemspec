# frozen_string_literal: true

require_relative "lib/integromat/version"

Gem::Specification.new do |spec|
  spec.name = "integromat"
  spec.version = Integromat::VERSION
  spec.authors = ["Nathan Lopez"]
  spec.email = ["nathan.lopez042@gmail.com"]

  spec.summary = "A simple solution for integrating Integromat (Make) webhooks into your Ruby applications."
  spec.description = "Integromat is a powerful automation platform that enables you to connect and automate various " \
    "applications and services. One of the key features of Integromat is the ability to utilize webhooks, which " \
    "allow you to send data to Integromat over HTTP. Webhooks act as instant triggers, allowing you to execute " \
    "scenarios immediately upon receiving a request at the webhook URL.\n\n" \
    "Integromat-Ruby is a lightweight Ruby gem that simplifies the process of triggering Integromat webhooks from " \
    "any Ruby application. With just a few lines of code, you can seamlessly integrate your Ruby app with Integromat " \
    "and automate various tasks."
  spec.homepage = "https://github.com/andrewdsilva/integromat-ruby"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/andrewdsilva/integromat-ruby"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday"
end
