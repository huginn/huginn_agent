require 'spec_helper'
require 'rubygems/dependency'

describe 'gemfile_helper patch' do
  let(:patch_path) { File.expand_path('../../../../lib/huginn_agent/patches/gemfile_helper.rb', __dir__) }
  let(:rspec_dependency) { Gem::Dependency.new('rspec', '>= 0') }
  let(:thor_dependency) { Gem::Dependency.new('thor', '~> 1.5') }
  let(:gemspec) { instance_double(Gem::Specification, development_dependencies: [rspec_dependency, thor_dependency]) }

  let(:context) do
    Object.new.tap do |object|
      object.instance_variable_set(:@dependencies, [Gem::Dependency.new('rspec', '~> 3.13')])
      object.instance_variable_set(:@added_gems, [])

      object.define_singleton_method(:dependencies) { @dependencies }
      object.define_singleton_method(:gem) { |*args| @added_gems << args }
      object.define_singleton_method(:added_gems) { @added_gems }
    end
  end

  before do
    allow(Gem::Specification).to receive(:load).and_return(gemspec)
  end

  it 'does not add development dependencies already present in Huginn' do
    context.instance_eval(File.read(patch_path), patch_path)

    expect(context.added_gems).to eq([['thor']])
  end
end
