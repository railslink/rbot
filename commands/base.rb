module RBot
  module Commands
    class Base < SlackRubyBot::Commands::Base
      private

      def self.permitted?(client, data, match)
        return true
        return true unless ENV.key?('DEVELOPMENT_USER')
        client.users[data.user].name == ENV['DEVELOPMENT_USER']
      end
    end
  end
end
