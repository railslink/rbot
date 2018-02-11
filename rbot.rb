require 'dotenv'
Dotenv.load('.env.local', '.env')

require 'slack-ruby-bot'
require 'pry'

SlackRubyBot::Client.logger.level = Logger::WARN

SlackRubyBot.configure do |config|
  config.send_gifs = false
end

module RBot
  VERSION = '0.1.0'
  STARTED_AT = Time.now

  class Bot < SlackRubyBot::Bot
  end
end

require_relative 'models/user_activity'
require_relative 'commands/base'
require_relative 'commands/help'
require_relative 'commands/about'
require_relative 'commands/welcome'
require_relative 'commands/monitor' # must be last

Celluloid::Actor[:user_activity] = UserActivity.new

RBot::Bot.run
