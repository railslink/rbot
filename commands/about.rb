module RBot
  module Commands
    class About < SlackRubyBot::Commands::Base
      command 'about'
      match(/^(?<bot>[[:alnum:][:punct:]@<>]*)$/u)

      def self.call(client, data, _match)
        client.web_client.chat_postMessage(
          as_user: true,
          channel: data.channel,
          attachments: [
            {
              fallback: "RBot version #{RBot::VERSION}",
              title: "About RBot",
              fields: [
                { title: "Website", value: "http://www.rubyonrails.link", short: true },
                { title: "Resources", value: "https://github.com/railslink/resources/wiki", short: true },
                { title: "Source", value: "https://github.com/railslink/rbot", short: true },
                { title: "Version", value: RBot::VERSION, short: true },
              ],
              footer: "Uptime: #{uptime}",
              ts: RBot::STARTED_AT.to_i
            }
          ]
        )
      end

      def self.uptime
        s = (Time.now - RBot::STARTED_AT).to_i
        d = s / 86400
        s %= 86400
        h = s / 3600
        s %= 3600
        m = s / 60
        s %= 60
        "#{d}d #{h}h #{m}m #{s}s"
      end
    end
  end
end
