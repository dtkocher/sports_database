module SportsDatabase
  class Client
    include Api::Query
    include Helpers::Connection

    attr_accessor :api_key, :sport

    def initialize(opts={})
      self.api_key = opts.fetch(:api_key, "guest")
      self.sport = opts.fetch(:sport, "ncaabb")
    end

  end
end
