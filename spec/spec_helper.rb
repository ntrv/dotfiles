require 'serverspec'
require 'net/ssh'
require 'docker-api'

case ENV['SPEC_BACKEND']
when 'DOCKER'
  set :backend, :docker
  set :docker_url, ENV['DOCKER_HOST'] || 'unix:///var/run/docker.sock'
  set :docker_image, ENV['DOCKER_IMAGE'] || 'centos:7'
  set :docker_container_create_options, {'Cmd' => ['/bin/sh']}
  Excon.defaults[:ssl_verify_peer] = false
  puts 'This is docker'
when 'SSH'
  set :backend, :ssh
  set :request_pty, true
  set :path, '/sbin:/usr/local/sbin:$PATH'
  set :request_pty, true
  set :host, ENV['TARGET_HOST']
  opts = Net::SSH::Config.for(ENV['TARGET_HOST'])
  opts[:user] = ENV['SSH_USER'] || Etc.getlogin
  opts[:password] = ENV['SSH_PASSWORD']
  set :sudo_password, ENV['SUDO_PASSWORD']
  set :ssh_options, opts
  puts 'This is SSH'
else
  set :backend, :exec
end
