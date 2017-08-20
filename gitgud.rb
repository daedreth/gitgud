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

messages =  [
                "test1",
                "test2"
            ]

msize = messages.size
mpos = 0

serverid = "341967942956875796"

tokens =    [
                "MzQ2MTMxMzEwMDIyMjMwMDE5.DHFX-w.vN3HCVKTQ0rpTa-cXPfbx4Beqrg",
                "MzQ2MTI5NTkwMDQzMDE3MjE2.DHFWYg.TUw1VuLbhpuaCScaoPjZSdCRQAU"
            ]

tokens.each { |token|
    bots.push(Discordrb::Bot.new(log_mode: :silent, token: token, type: :user, parse_self: true))
    bots[bots.size-1].run(true)
    puts "Logged into #{bots[bots.size-1].profile.username}!"
    if not bots[bots.size-1].servers.has_key? serverid.to_i then
        puts "Account #{bots[bots.size-1].profile.username} is not in the server!"
    end
}

puts "#{bots.size} bots online!"

if options[:dryrun] then exit end

puts "Starting spam"

loop do
    bots.each { |bot|
        server = bot.server(serverid)
        server.channels.each { |channel|
            if mpos == msize then mpos = 0 end
            channel.send_message(messages[mpos]) rescue nil
            mpos += 1
        }
    }
end