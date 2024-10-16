require 'huginn_agent/version'

class HuginnAgent
  class << self
    attr_accessor :branch, :remote

    def load_tasks(options = {})
      @branch = options[:branch] || 'master'
      @remote = options[:remote] || 'https://github.com/huginn/huginn.git'
      Rake.add_rakelib File.join(File.expand_path('../', __FILE__), 'tasks')
    end

    def load(*paths)
      paths.each do |path|
        load_paths << path
      end
    end

    def register(*paths)
      paths.each do |path|
        agent_paths << path
      end
    end

    def require!
      load_paths.each do |path|
        require path
      end
      agent_paths.each do |path|
        if Rails.autoloaders.zeitwerk_enabled?
          setup_zeitwerk_loader path
        else
          require_dependency path
        end

        Agent::TYPES << "Agents::#{File.basename(path.to_s).camelize}"
      end
    end

    private

    def load_paths
      @load_paths ||= []
    end

    def agent_paths
      @agent_paths ||= []
    end

    def setup_zeitwerk_loader(gem_path)
      gem, _, mod_path = gem_path.partition('/')
      gemspec = Gem::Specification.find_by_name(gem)
      gem_dir = Pathname.new(gemspec.gem_dir)
      module_dir = gem_dir + gemspec.require_paths[0] + gem

      loader = Zeitwerk::Loader.new
      loader.tag = gem
      loader.push_dir(module_dir, namespace: Agents)
      loader.setup
    end
  end
end
