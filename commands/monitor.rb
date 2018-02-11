module RBot
  module Commands
    class Monitor < RBot::Commands::Base

      match(/.*/)

      def self.call(client, data, match)
        user = client.users[data.user]
        channel_name = client.channels[data.channel].try(:name)

        Celluloid::Actor[:user_activity].async.track(user_name: user.name)

        logger.info "Heard from #{user.real_name} (#{user.name}) at #{Time.now.utc} in ##{channel_name}"
      end

      private

      def self.permitted?(client, data, match)
        true
      end
    end
  end
end
