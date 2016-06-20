require 'spec_helper'

describe HuginnAgent do
  it 'has a version number' do
    expect(HuginnAgent::VERSION).not_to be nil
  end

  context '#load_tasks' do
    class Rake; end

    before(:each) do
      expect(Rake).to receive(:add_rakelib)
    end

    it 'sets default values for branch and remote' do
      HuginnAgent.load_tasks
      expect(HuginnAgent.branch).to eq('master')
      expect(HuginnAgent.remote).to eq('https://github.com/cantino/huginn.git')
    end

    it "sets branch and remote based on the passed options" do
      HuginnAgent.load_tasks(branch: 'test', remote: 'http://git.example.com')
      expect(HuginnAgent.branch).to eq('test')
      expect(HuginnAgent.remote).to eq('http://git.example.com')
    end
  end

  context '#require!' do
    before(:each) do
      HuginnAgent.instance_variable_set(:@load_paths, [])
      HuginnAgent.instance_variable_set(:@agent_paths, [])
    end

    it 'requires files passed to #load' do
      HuginnAgent.load('/tmp/test.rb')
      expect(HuginnAgent).to receive(:require).with('/tmp/test.rb')
      HuginnAgent.require!
    end

    it 'requires files passwd to #register and assign adds the class name to Agents::TYPES' do
      class Agent; TYPES = []; end
      string_double= double('test_agent.rb', camelize: 'TestAgent')
      expect(File).to receive(:basename).and_return(string_double)
      HuginnAgent.register('/tmp/test_agent.rb')
      expect(HuginnAgent).to receive(:require).with('/tmp/test_agent.rb')
      HuginnAgent.require!
      expect(Agent::TYPES).to eq(['Agents::TestAgent'])
    end
  end
end
