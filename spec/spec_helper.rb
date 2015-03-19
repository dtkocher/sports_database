$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'sports_database'
require 'simplecov'
SimpleCov.start do
  add_filter '/.gems/'
  add_filter '/spec/'
end
