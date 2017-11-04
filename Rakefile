require 'rake'
require 'rspec/core/rake_task'

# task :spec    => 'spec:role:all'
# task :default => :spec

namespace :spec do
  namespace :role do
    targets = Dir.glob('./spec/role/*').map do |dir|
      next unless File.directory?(dir)
      File.basename(dir)
    end

    task :all     => targets
    task :default => :all

    targets.each do |target|
      desc "Run serverspec tests to #{target}"
      RSpec::Core::RakeTask.new(target.to_sym) do |t|
        ENV['TARGET_HOST'] = target
        t.pattern = "spec/role/#{target}/*_spec.rb"
      end
    end
  end
end
