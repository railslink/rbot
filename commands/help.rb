module RBot
  module Commands
    class Help < Base
      command 'help'
      match(/^(?<bot>[[:alnum:][:punct:]@<>]*)$/u)

      def self.call(client, data, match)
        command = match[:expression]

        payload = if command.present?
                    {
                      text: SlackRubyBot::CommandsHelper.instance.command_full_desc(command)
                    }
                  else
                    {
                      attachments: [
                        {
                          fallback: fields_for_commands.join("\n"),
                          title: "RBot Help",
                          fields: fields_for_commands,
                        }
                      ]
                    }
                  end

        client.web_client.chat_postMessage({as_user: true, channel: data.channel}.merge(payload))
      end

      def self.fields_for_commands
        SlackRubyBot::CommandsHelper.instance.
          commands_help_attrs.
          reject { |e| %w[help hi].include?(e.command_name) }.
          sort_by(&:command_name).
          map { |e| { title: e.command_name, value: e.command_desc, short: false } }
      end
    end
  end
end
