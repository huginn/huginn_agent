# HuginnAgent

This is a dependency for new external Huginn Agent Gems.

## Installation

It is recommended to have a [local development setup](https://github.com/cantino/huginn#local-installation) of Huginn running before starting to develop a Huginn Agent Gem.

```shell
gem install huginn_agent
```

### Creating a new Agent Gem

Use the provided generator to create a skeleton of the new Agent Gem.

```shell
huginn_agent new huginn_aweome_agent
```

You can now start developing the new Agent in `./huginn_awesome_agent`. An example Agent class skeleton is located in `./huginn_awesome_agent/lib/huginn_awesome_agent/awesome_agent.rb`.

Every Agent and ruby source file needs to be "registered", so that the `huginn_agent` can load them during the startup of Huginn. After creating new files add them in `lib/huginn_<your agent name>_agent.rb`:

```ruby
# use register to add more agents to Huginn
HuginnAgent.register 'path_to/<agent name>_agent'
# use load to require concern or other library classes
HuginnAgent.load 'path_to/concerns/<file name>'
```

You can add your Agent Gem to your Huginn instace by adding it the to list of `ADDITIONAL_GEMS` in the `.env` file:

```
ADDITIONAL_GEMS=huginn_awesome_agent(path: /local/path/to/huginn_awesome_agent)
```

### Running the specs for the Agent Gem

Running `rake` will clone and set up Huginn in `spec/huginn` to run the specs of the Gem in Huginn as if they would be build-in Agents. The desired Huginn repository and branch can be modified in the `Rakefile`:

```ruby
HuginnAgent.load_tasks(branch: '<your branch>', remote: 'https://github.com/<github user>/huginn.git')
```

Make sure to delete the `spec/huginn` directory and re-run `rake` after changing the `remote` to update the Huginn source code.

After the setup is done `rake spec` will only run the tests, without cloning the Huginn source again.


## Contributing

1. Fork it ( https://github.com/[my-github-username]/huginn_agent/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
