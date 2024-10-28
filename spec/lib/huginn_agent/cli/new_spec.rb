require 'spec_helper'

require 'huginn_agent/cli/new'

describe HuginnAgent::CLI::New do
  sandbox = File.expand_path(File.join(File.dirname(__FILE__), '../../../sandbox'))
  let(:cli)  { HuginnAgent::CLI.new }
  let(:thor) { Thor.new }

  before(:each) do
    FileUtils.rm_rf(File.join(sandbox))
    allow(Pathname).to receive(:pwd).and_return(Pathname.new(sandbox))
  end

  after(:each) { FileUtils.rm_rf(File.join(sandbox)) }

  it "prefixes the gem name and copies the MIT license when told" do
    expect(cli).to receive(:yes?).with(HuginnAgent::CLI::New::PREFIX_QUESTION) { true }
    expect(cli).to receive(:yes?).with(HuginnAgent::CLI::New::MIT_QUESTION) { true }
    capture(:stdout) { cli.new('test') }
    expect(File.exist?(File.join(sandbox, 'huginn_test'))).to be_truthy
    expect(File.exist?(File.join(sandbox, 'huginn_test', 'LICENSE.txt'))).to be_truthy
  end

  it "does not prefix the gem name and does notcopies the MIT license when told" do
    expect(cli).to receive(:yes?).with(HuginnAgent::CLI::New::PREFIX_QUESTION) { false }
    expect(cli).to receive(:yes?).with(HuginnAgent::CLI::New::MIT_QUESTION) { false }

    capture(:stdout) { cli.new('test') }
    expect(File.exist?(File.join(sandbox, 'huginn_test'))).to be_falsy
    expect(File.exist?(File.join(sandbox, 'test'))).to be_truthy
    expect(File.exist?(File.join(sandbox, 'test', 'LICENSE.txt'))).to be_falsy
  end

  it "asks to use a .env file" do
    expect(cli).to receive(:yes?).with(HuginnAgent::CLI::New::PREFIX_QUESTION) { false }
    expect(cli).to receive(:yes?).with(HuginnAgent::CLI::New::MIT_QUESTION) { false }
    expect(cli).to receive(:ask).with(HuginnAgent::CLI::New::DOT_ENV_QUESTION) { 1 }
    FileUtils.touch('.env')
    capture(:stdout) { cli.new('test') }
    FileUtils.rm('.env')
    expect(File.exist?(File.join(sandbox, 'huginn_test'))).to be_falsy
    expect(File.exist?(File.join(sandbox, 'test'))).to be_truthy
    expect(File.exist?(File.join(sandbox, 'test', '.env'))).to be_truthy
  end
end
