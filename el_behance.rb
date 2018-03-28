require 'thor'
require 'net/telnet'
require 'mechanize'
require 'socksify'

APPRECIATE_URL = 'https://www.behance.net/v2/projects/PROJECT_ID/appreciate?client_id=BehanceWebSusi1'.freeze
TCPSocket.socks_server = '127.0.0.1'
TCPSocket.socks_port = '50001'

class ElBehance < Thor
  class_option 'project_url', aliases: '-p', type: 'string', required: true,
                              desc: 'Project URL'
  class_option 'votes', aliases: '-v', type: 'numeric', default: 256,
                        desc: 'Max number of appreciations'
  desc 'appreciate PROJECT_ID', 'Appreciate Behance project!'
  def appreciate
    project_id = URI(options[:project_url]).request_uri.split('/')[2]
    options[:votes].times do
      switch_ip
      post_url = APPRECIATE_URL.gsub('PROJECT_ID', project_id)
      response = Mechanize.new.post(URI(post_url))
      puts 'Voted!' if response.code == '200'
    end
    telnet.close
  end

  private

  def vote(project_id)
    post_url = APPRECIATE_URL.gsub('PROJECT_ID', project_id)
    Mechanize.new.post(URI(post_url))
  end

  def switch_ip
    telnet.cmd('AUTHENTICATE "hi"') do |c|
      raise('Cannot authenticate to Tor') if c != "250 OK\n"
    end
    telnet.cmd('signal NEWNYM') do |c|
      c != "250 OK\n" ? raise('Cannot switch IP') : puts('IP Switched')
    end
    sleep rand 10..20
  end

  def telnet
    @telnet ||= Net::Telnet.new('Host' => 'localhost', 'Port' => 9050,
                                'Timeout' => 10, 'Prompt' => /250 OK\n/)
  end
end

ElBehance.start(ARGV)
