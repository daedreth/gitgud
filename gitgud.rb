require "optparse"
require "discordrb"

options = {}

OptionParser.new do |opts|
    opts.banner = "Usage: gitgud.rb [options]"

    opts.on("-d", "--dry-run", "Do a dry run") do |d|
        options[:dryrun] = d
    end
end.parse!

bots = Array.new

message = ""

server = ""

tokens = 	[

			]

tokens.each { |token|
    bots.push(Discordrb::Bot.new(log_mode: :silent, token: token, type: :user, parse_self: true))
    bots[bots.size-1].run(true)
    puts "Logged into #{bots[bots.size-1].profile.username}!"
    if not bots[bots.size-1].servers.has_key? server.to_i then
        puts "Account #{bots[bots.size-1].profile.username} is not in the server!"
    end
}

puts "#{bots.size} bots online!"

if options[:dryrun] then exit end

puts "Starting spam"

bots.each { |bot|
    Thread.new {
        loop do
            server = bot.server(server)
            server.channels.each { |channel|
                channel.send_message(message) rescue nil
            }
        end
    }
}

loop do
    sleep(1)
end
