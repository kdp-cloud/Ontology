# frozen_string_literal: true

require_relative "lib/Ontology/version"

Gem::Specification.new do |spec|
  spec.name = "Ontology"
  spec.version = Ontology::VERSION
  spec.authors = ["Kevin De Pelseneer"]
  spec.email = ["kevin.depelseneer@gmail.com"]

  spec.summary = "Assignment for the application of the software developer position."
  spec.description = "The assignment consists of producing some (reusable) code which can interact with the
  Ontology Loopup Service REST API."
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.5"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  # spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.executables = ["ontology"]
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
