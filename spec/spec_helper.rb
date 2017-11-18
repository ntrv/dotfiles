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
  puts 'This is via docker serverspec'
when 'SSH'
  set :backend, :ssh
  set :request_pty, true
  set :path, '/sbin:/usr/local/sbin:$PATH'
  set :host, ENV['TARGET_HOST']
  set :ssh_options, Net::SSH::Config.for(ENV['TARGET_HOST'])
  puts 'This is via SSH serverspec'
else
  set :backend, :exec
  puts 'This is via Local serverspec'
end
