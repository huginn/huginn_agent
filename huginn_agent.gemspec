# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'huginn_agent'

Gem::Specification.new do |spec|
  spec.name          = "huginn_agent"
  spec.version       = HuginnAgent::VERSION
  spec.authors       = ["Andrew Cantino"]
  spec.email         = ["cantino@gmail.com"]
  spec.summary       = %q{Helpers for making new Huginn Agents}
  spec.homepage      = "https://github.com/cantino/huginn"
  spec.license       = "MIT"

  spec.files         = Dir['LICENSE.txt', 'lib/**/*']
  spec.executables   = Dir['bin/*']
  spec.test_files    = Dir['spec/**/*']
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1"
end
