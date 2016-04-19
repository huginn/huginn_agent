require 'open3'

class HuginnAgent
  class Helper
    def self.open3(command, streaming_output = true)
      output = ""
      print "\n" if streaming_output

      status = Open3.popen3(ENV, "#{command} 2>&1") do |stdin, stdout, _stderr, wait_thr|
        stdin.close

        until stdout.eof do
          next unless IO.select([stdout])
          data = stdout.read_nonblock(1024)
          print data if streaming_output
          output << data
        end
        wait_thr.value
      end
      [status.exitstatus, output]
    rescue IOError => e
      return [1, "#{e} #{e.message}"]
    end
  end
end
