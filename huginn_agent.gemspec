# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'huginn_agent/version'

Gem::Specification.new do |spec|
  spec.name          = "huginn_agent"
  spec.version       = HuginnAgent::VERSION
  spec.authors       = ["Andrew Cantino"]
  spec.email         = ["cantino@gmail.com"]
  spec.summary       = %q{Helpers for making new Huginn Agents}
  spec.homepage      = "https://github.com/huginn/huginn"
  spec.license       = "MIT"

  spec.files         = Dir['CHANGELOG.md', 'LICENSE.txt', 'lib/**/*', 'bin/*']
  spec.executables   = Dir['bin/*'].map { |p| File.basename(p) }
  spec.test_files    = Dir['spec/**/*']
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'thor'
  spec.add_development_dependency "bundler", "~> 2.5"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "rspec", "~> 3.12"
  spec.add_development_dependency "simplecov", "~> 0.12"
  spec.add_development_dependency "guard", "~> 2.18"
  spec.add_development_dependency "guard-rspec", "~> 4.7"
end
