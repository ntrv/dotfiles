require 'serverspec'
require 'pathname'
require 'net/ssh'

set :backend, :ssh
set :path, '/sbin:/usr/local/sbin:$PATH'
set :request_pty, true

set :host, ENV['TARGET_HOST']
opts = Net::SSH::Config.for(ENV['TARGET_HOST'])
opts[:user] = ENV['SSH_USER'] || Etc.getlogin
opts[:password] = ENV['SSH_PASSWORD']
set :sudo_password, ENV['SUDO_PASSWORD']
set :ssh_options, opts
