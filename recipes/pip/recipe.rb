package 'epel-release' do
  action :install
  only_if node[:platform] == 'centos'
  notifies :install, 'package[python-pip]', :immediately
end

package 'python-pip' do
  action :nothing
end

execute 'pip::install' do
  command 'easy_install pip'
  not_if 'type pip 1>/dev/null 2>&1'
  only_if 'uname | grep -q Darwin'
end
