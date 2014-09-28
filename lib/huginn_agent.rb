class HuginnAgent
  def self.register(*paths)
    @paths ||= []
    paths.each do |path|
      @paths << path
    end
  end

  def self.require!
    @paths.each do |path|
      require path
      Agent::TYPES << "Agents::#{File.basename(path.to_s).camelize}"
    end
  end
end