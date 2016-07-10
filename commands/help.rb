#
# NOTE: This model is a pure monkey patch of 
# https://github.com/dblock/slack-ruby-bot/blob/master/lib/slack-ruby-bot/commands/help.rb
#
module SlackRubyBot
  module Commands
    class HelpCommand < Base
      command 'help' do |client, data, match|
        command = match[:expression]

        payload = if command.present?
                    {
                      text: CommandsHelper.instance.command_full_desc(command)
                    }
                  else
                    {
                      attachments: [
                        {
                          fallback: general_text,
                          title: "RBot Help",
                          fields: fields_for_commands,
                        }
                      ]
                    }
                  end

        client.web_client.chat_postMessage({as_user: true, channel: data.channel}.merge(payload))
      end

      def self.fields_for_commands
        CommandsHelper.instance.
          commands_help_attrs.
          sort_by(&:command_name).
          map { |e| { title: e.command_name, value: e.command_desc, short: false } }
      end
    end
  end
end
