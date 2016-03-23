$stdout.sync = true

def shell_out(command, message = nil, output_on_success = false)
  print message if message
  output = Bundler.with_clean_env do
    `#{command} 2>&1`
  end
  if $?.success?
    puts "\e[32m [OK]\e[0m" if message
    puts output #if output_on_success
  else
    puts "\e[31m [FAIL]\e[0m" if message
    puts "Tried executing '#{command}'"
    puts output
    fail
  end
end

BRANCH = 'feature/agents_in_gems'
REMOTE = 'https://github.com/kreuzwerker/DKT.huginn.git'

task :spec do
  unless File.exists?('spec/huginn/.git')
    shell_out "git clone #{REMOTE} -b #{BRANCH} spec/huginn", 'Cloning huginn source ...'
  end
  if File.exists?('.env')
    shell_out "cp .env spec/huginn"
  end

  Dir.chdir('spec/huginn') do
    shell_out "git fetch && git reset --hard #{BRANCH}", 'Resetting Huginn source ...'
    shell_out "echo \"gem 'huginn_nlp_agents', path: '../../'\" >> Gemfile"

    shell_out "bundle install --without development production -j 4", 'Installing ruby gems ...'
    shell_out('bundle exec rake db:create db:migrate', 'Creating database ...') if ENV['CI']
    shell_out "bundle exec rspec ../*.rb", 'Running specs ...', true
  end
end
task :default => :spec