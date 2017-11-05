require_relative '../../utils/utils'

execute 'pip::install' do
  command 'easy_install pip'
  not_if Dotfiles::Utils.cmd_exists?('pip')
end
