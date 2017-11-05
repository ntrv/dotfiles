require 'serverspec'
require 'net/ssh'

set :backend, :ssh

RSpec.configure do |c|
  c.before :all do
    set :host, ENV['TARGET_HOST']
    opts = Net::SSH::Config.for(c.host)
    opts[:user] = ENV['SSH_USER'] || Etc.getlogin
    opts[:password] = ENV['SSH_PASSWORD']
    set :sudo_password, ENV['SUDO_PASSWORD']
    set :ssh_options, opts
  end
end

# Disable sudo
# set :disable_sudo, true


# Set environment variables
# set :env, :LANG => 'C', :LC_MESSAGES => 'C'

# Set PATH
# set :path, '/sbin:/usr/local/sbin:$PATH'
