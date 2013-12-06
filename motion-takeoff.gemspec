# -*- encoding: utf-8 -*-
require File.expand_path('../lib/project/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "motion-takeoff"
  spec.version       = MotionTakeoff::VERSION
  spec.authors       = ["Mark Rickert"]
  spec.email         = ["mjar81@gmail.com"]
  spec.description   = %q{A RubyMotion specific iOS gem that helps you do things at launch.}
  spec.summary       = %q{A RubyMotion specific iOS gem that helps you do things at launch. You can use this gem to display messages at certain launch counts.}
  spec.homepage      = "https://www.github.com/MohawkApps/motion-takeoff"
  spec.license       = "MIT"

  files = []
  files << 'README.md'
  files.concat(Dir.glob('lib/**/*.rb'))
  spec.files         = files
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"
  spec.add_runtime_dependency "bubble-wrap", ">1.0.0"
end
