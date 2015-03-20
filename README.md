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

# the following will perform the same query
client.query("full name, school name, team @ season=2014 and team=PURD")
client.query("full name, school name, team", "season=2014 and team=PURD")

# Result class example
result = client.query("date,points,o:points@team=Bears and season=2011 and site")
result.success? # => true
result.fail? # => false
result.status_code # => 200
result.data # => returns the array of hashes
#      [{:group=>"team = Bears and season = 2011 and site = home",
#        :data_set=>[{:date=>20110911, :points=>30, :o_points=>12},
#                  {:date=>20110925, :points=>17, :o_points=>27},
#                  {:date=>20111002, :points=>34, :o_points=>29},
#                  {:date=>20111016, :points=>39, :o_points=>10},
#                  {:date=>20111113, :points=>37, :o_points=>13},
#                  {:date=>20111120, :points=>31, :o_points=>20},
#                  {:date=>20111204, :points=>3, :o_points=>10},
#                  {:date=>20111218, :points=>14, :o_points=>38}]},
#        {:group=>"team = Bears and season = 2011 and site = away",
#          :data_set=>[{:date=>20110918, :points=>13, :o_points=>30},
#                   {:date=>20111010, :points=>13, :o_points=>24},
#                   {:date=>20111023, :points=>24, :o_points=>18},
#                   {:date=>20111107, :points=>30, :o_points=>24},
#                   {:date=>20111127, :points=>20, :o_points=>25},
#                   {:date=>20111211, :points=>10, :o_points=>13},
#                   {:date=>20111225, :points=>21, :o_points=>35},
#                   {:date=>20120101, :points=>17, :o_points=>13}]}]
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/sdb_api_client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
