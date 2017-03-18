# HuginnAgent [![Build Status](https://travis-ci.org/cantino/huginn_agent.svg?branch=master)](https://travis-ci.org/cantino/huginn_agent)

This is a dependency for new external Huginn Agent Gems.

## Installation

It is recommended to have a [local development setup](https://github.com/cantino/huginn#local-installation) of Huginn running before starting to develop a Huginn Agent Gem.

```shell
gem install huginn_agent
```

### Creating a new Agent Gem

Use the provided generator to create a skeleton of the new Agent Gem.

```shell
huginn_agent new huginn_awesome_agent
```

You can now start developing the new Agent in `./huginn_awesome_agent`. An example Agent class skeleton is located in `./huginn_awesome_agent/lib/huginn_awesome_agent/awesome_agent.rb`.

Every Agent and ruby source file needs to be "registered", so that the `huginn_agent` can load them during the startup of Huginn. After creating new files add them in `lib/huginn_<your agent name>_agent.rb`:

```ruby
# use register to add more agents to Huginn
HuginnAgent.register 'path_to/<agent name>_agent'
# use load to require concern or other library classes
HuginnAgent.load 'path_to/concerns/<file name>'
```

You can add your Agent Gem to your Huginn instance for testing by adding it the to list of `ADDITIONAL_GEMS` in the Huginn `.env` file:

```
ADDITIONAL_GEMS=huginn_awesome_agent(path: /local/path/to/huginn_awesome_agent)
```

### Running the specs for the Agent Gem

Running `rake` will clone and set up Huginn in `spec/huginn` to run the specs of the Gem in Huginn as if it were a builtin Agent. The desired Huginn repository and branch can be modified in the `Rakefile`:

```ruby
HuginnAgent.load_tasks(branch: '<your branch>', remote: 'https://github.com/<github user>/huginn.git')
```

Make sure to delete the `spec/huginn` directory and re-run `rake` after changing the `remote` to update the Huginn source code.

After the setup is done, `rake spec` will only run the tests, without cloning Huginn again. To get code
coverage reports set the `COVERAGE` environment variable: `COVERAGE=true rake spec`

## Examples

You can see a list of gems using Huginn Agent [on RubyGems.org](https://rubygems.org/gems/huginn_agent/reverse_dependencies).

We're also aware of these additional gems:
* [huginn_lifx_agents](https://github.com/omniscopeio/huginn_lifx_agents): Huginn agents to interact with your LIFX light blubs
* [huginn_readability_agent](https://github.com/kreuzwerker/DKT.huginn_readability_agent): The huginn_readability_agent extracts the primary readable content of a website.
* [huginn_garoon_agents](https://github.com/namutaka/huginn_garoon_agents): Garoon Workflow Agent
* [huginn_mysql2_agent](https://github.com/yubuylov/huginn_mysql2_agent): Mysql Agent for huginn.
* [huginn_dkt_curation_agents](https://github.com/kreuzwerker/DKT.huginn_dkt_curation_agents): Agents for doing natural language processing use the DKT APIs.
* [huginn_freme_enrichment_agents](https://github.com/kreuzwerker/DKT.huginn_freme_enrichment_agents): Agents for doing natural language processing using the FREME APIs.
* [huginn_website_metadata_agent](https://github.com/kreuzwerker/DKT.huginn_website_metadata_agent): The Huginn WebsiteMetadata Agent extracts metadata from HTML. It supports schema.org microdata, embedded JSON-LD, and the common meta tag attributes.
* [huginn_naive_bayes_agent](https://github.com/nogre/huginn_naive_bayes_agent): The Huginn Naive Bayes agent uses some incoming Events as a training set for Naive Bayes Machine Learning. Then it classifies Events from other sources accordingly using tags.
* [huginn_todoist_agent](https://github.com/stesie/huginn_todoist_agent): Huginn agent to add items to your Todoist.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/huginn_agent/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
