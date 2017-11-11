require 'rake'
require 'rspec/core/rake_task'

# task :spec    => 'spec:role:all'
# task :default => :spec

namespace :itamae do
  namespace :recipe do
    targets = Dir.glob('./recipes/*').map do |dir|
      next unless File.directory?(dir)
      File.basename(dir)
    end

    base_image = 'centos:7'
    targets.each do |target|
      desc "Run itamae using recipe #{target}"
      task target do
        target_dir = "recipes/#{target}"
        sh "bundle exec itamae docker --ohai #{target_dir}/default.rb -y #{target_dir}/node.yml --image=#{base_image}"
      end
    end
  end
end

namespace :spec do
  namespace :recipe do
    ENV['SPEC_BACKEND'] ||= 'DOCKER'
    targets = Dir.glob('./spec/recipe/*').map do |dir|
      next unless File.directory?(dir)
      File.basename(dir)
    end

    task :all => targets
    task :default => :all

    targets.each do |target|
      desc "Run serverspec tests to #{target}"
      RSpec::Core::RakeTask.new(target.to_sym) do |t|
        t.pattern = "spec/recipe/#{target}/*_spec.rb"
      end
    end
  end

  namespace :role do
    ENV['SPEC_BACKEND'] ||= 'SSH'
    targets = Dir.glob('./spec/role/*').map do |dir|
      next unless File.directory?(dir)
      File.basename(dir)
    end

    task :all     => targets
    task :default => :all

    targets.each do |target|
      desc "Run serverspec tests to #{target}"
      RSpec::Core::RakeTask.new(target.to_sym) do |t|
        ENV['TARGET_HOST'] ||= target
        t.pattern = "spec/role/#{target}/*_spec.rb"
      end
    end
  end
end
