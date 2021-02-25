#these are gems
# require 'json'
# require 'open-uri'
# require 'net/http'
require 'pry'
require 'httparty'
require 'tty-prompt'

require_relative '../lib/modules/findbrewery.rb'
require_relative '../lib/brewery.rb'
require_relative '../lib/cli.rb'
require_relative '../lib/api.rb'
 
#FINDBREWERY::CLI.new.greeting