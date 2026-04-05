require 'spec_helper'

describe HuginnAgent::SpecRunner do
  unless defined?(Bundler)
    class Bundler; def self.with_unbundled_env; yield end end
  end

  let(:runner) {HuginnAgent::SpecRunner.new }

  it "detects the gem name" do
    expect(runner.gem_name).to eq('huginn_agent')
  end

  context '#shell_out' do
    it 'does not output anything without a specifing message' do
      expect(runner).not_to receive(:puts)
      runner.shell_out('pwd')
    end

    it "outputs the message and status information" do
      output = capture(:stdout) { runner.shell_out('pwd', 'Testing') }
      expect(output).to include('Testing')
      expect(output).to include('OK')
      expect(output).not_to include('FAIL')
    end

    it "output the called command on failure" do
      output = capture(:stdout) {
        expect { runner.shell_out('false', 'Testing') }.to raise_error(RuntimeError)
      }
      expect(output).to include('Testing')
      expect(output).to include('FAIL')
      expect(output).not_to include('OK')

    end
  end

  context '#bundle' do
    before do
      allow(Dir).to receive(:chdir).with('spec/huginn').and_yield
      allow(File).to receive(:exist?).and_call_original
    end

    it 'uses bundle config instead of --without' do
      allow(File).to receive(:exist?).with('.env').and_return(false)

      expect(runner).to receive(:shell_out).with("cp .env.example .env").ordered
      expect(runner).to receive(:shell_out).with("bundle config set --local without 'development production'").ordered
      expect(runner).to receive(:shell_out).with('bundle install -j 4', 'Installing ruby gems ...').ordered

      runner.bundle
    end
  end

  context '#database' do
    before do
      allow(Dir).to receive(:chdir).with('spec/huginn').and_yield
      allow(File).to receive(:exist?).and_call_original
    end

    it 'removes a generated schema before migrating' do
      allow(File).to receive(:exist?).with('db/schema.rb').and_return(true)

      expect(File).to receive(:delete).with('db/schema.rb').ordered
      expect(runner).to receive(:shell_out).with('bundle exec rake db:create db:migrate', 'Creating database ...').ordered

      runner.database
    end
  end
end
