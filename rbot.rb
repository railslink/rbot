require 'slack-ruby-bot'
require 'pry'

SlackRubyBot::Client.logger.level = Logger::WARN

SlackRubyBot.configure do |config|
  config.send_gifs = false
end

module RBot
  VERSION = '0.0.1'

  class Bot < SlackRubyBot::Bot
  end
end

require_relative 'commands/help'
require_relative 'commands/about'
require_relative 'commands/welcome'

RBot::Bot.run
