# SportsDatabase

A ruby client to help with interacting to http://www.sportsdatabase.com/api. Currently tested and working on Ruby 2.2.1.

JSONP is returned from the API and this gem will handle the calls made to the API as well as parsing the JSONP returned.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sports_database'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sports_database

## Usage

Example call:

```ruby
require 'sports_database'

# By default if no params are passed api_key will be set to quest and sport to ncaabb
client = SportsDatabase::Client.new({ api_key: "guest", sport: "ncaabb" })
client.query("full name,school name,team@season=2014 and team=PURD")
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/sdb_api_client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
