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

  spec.add_runtime_dependency "thor"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.4"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
end
