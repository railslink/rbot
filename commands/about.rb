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
                { title: "Version", value: RBot::VERSION, short: true },
                { title: "Website", value: "http://www.rubyonrails.link", short: true },
                { title: "Resources", value: "https://github.com/railslink/resources/wiki", short: true },
                { title: "Source", value: "https://github.com/railslink/rbot", short: true },
              ],
            }
          ]
        )
      end

    end
  end
end
