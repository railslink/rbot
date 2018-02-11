require 'dotenv'
Dotenv.load('.env.local', '.env')

require 'slack-ruby-bot'
require 'pry'

SlackRubyBot::Client.logger.level = Logger::WARN

SlackRubyBot.configure do |config|
  config.send_gifs = false
end

module RBot
  VERSION = '0.0.2'
  STARTED_AT = Time.now

  class Bot < SlackRubyBot::Bot
  end
end

require_relative 'commands/base'
require_relative 'commands/help'
require_relative 'commands/about'
require_relative 'commands/welcome'

# Must be last as it is a catchall
require_relative 'commands/monitor'

RBot::Bot.run
