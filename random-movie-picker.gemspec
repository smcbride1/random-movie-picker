require_relative 'lib/random_movie_picker/version'

Gem::Specification.new do |spec|
  spec.name          = "random-movie-picker"
  spec.version       = RandomMoviePicker::VERSION
  spec.authors       = ["Stephen McBride"]
  spec.email         = ["stevemcbride3@gmail.com"]

  spec.summary       = "Random movie from Rotten Tomatoes' top 100 lists."
  spec.description   = "Picks a random movie from Rotten Tomatoes top 100 lists based off of a category and subcategory."
  spec.homepage      = "https://github.com/smcbride1/random-movie-picker"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/smcbride1/random-movie-picker"
  #spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
