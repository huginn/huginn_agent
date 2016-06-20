require 'spec_helper'

describe HuginnAgent::Helper do
  context '#open3' do
    it "returns the exit status and output of the command" do
      expect(HuginnAgent::Helper).not_to receive(:print)
      (status, output) = HuginnAgent::Helper.open3("pwd", false)
      expect(status).to eq(0)
      expect(output).to eq("#{Dir.pwd}\n")
    end

    it "prints the output directly when specified" do
      expect(HuginnAgent::Helper).to receive(:print).twice
      (status, output) = HuginnAgent::Helper.open3("pwd", true)
      expect(status).to eq(0)
      expect(output).to eq("#{Dir.pwd}\n")
    end

    it "return 1 as the status for failing command" do
      (status, output) = HuginnAgent::Helper.open3("false", false)
      expect(status).to eq(1)
    end

    it "returns 1 when an IOError occurred" do
      expect(IO).to receive(:select).and_raise(IOError)
      (status, output) = HuginnAgent::Helper.open3("pwd", false)
      expect(status).to eq(1)
      expect(output).to eq('IOError IOError')
    end
  end
end
