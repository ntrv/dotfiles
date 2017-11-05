require 'open3'

module Dotfiles
  module Utils
    def self.cmd_exists?(cmd)
      Open3.capture3('which', cmd)[2].exitstatus == 0 rescue nil
    end
  end
end

