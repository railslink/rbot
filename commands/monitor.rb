module RBot
  module Commands
    class Monitor < RBot::Commands::Base

      match(/./)

      def self.call(client, data, match)
        if data.type == 'message'
          user = client.users[data.user]
          logger.info "Heard from #{user.real_name} (#{user.name}) at #{Time.now}"
        else
          logger.debug "DATA: #{data.inspect}"
        end
      end

      private

      def self.permitted?(client, data, match)
        true
      end
    end
  end
end
