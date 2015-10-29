# -*- encoding: utf-8 -*-
require File.expand_path('../lib/project/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "motion-takeoff"
  spec.version       = Takeoff::VERSION
  spec.authors       = ["Mark Rickert"]
  spec.email         = ["mjar81@gmail.com"]
  spec.description   = %q{A RubyMotion specific iOS gem for scheduling stuff.}
  spec.summary       = %q{A RubyMotion specific iOS gem for scheduling stuff. You can use motion-takeoff to display messages at certain launch counts and schedule local notifications.}
  spec.homepage      = "https://www.github.com/MohawkApps/motion-takeoff"
  spec.license       = "MIT"

  files = []
  files << 'README.md'
  files.concat(Dir.glob('lib/**/*.rb'))
  spec.files         = files
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency("rake")
  spec.add_runtime_dependency("bubble-wrap", "> 1.7.0")
end
