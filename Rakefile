require 'rake'
require 'rspec/core/rake_task'

module TaskUtils
  def list_basedir(path)
    Dir.glob(path).map do |dir|
      next unless File.directory?(dir)
      File.basename(dir)
    end
  end
end

module DefaultTask
  extend Rake::DSL

  task :default do
    sh 'bundle exec rake -vT'
  end
end

module ItamaeTask
  extend Rake::DSL
  extend TaskUtils

  namespace :itamae do
    namespace :recipe do
      targets = self.list_basedir('./recipes/*')
      targets.each do |target|
        desc "Run itamae using recipe #{target} into Docker"
        task target, [:image] do |target_fullname, args|
          args.with_defaults(image: 'centos:7')
          target_dst = "recipes/#{target}"
          sh "bundle exec itamae docker --ohai #{target_dst}/default.rb -y #{target_dst}/node.yml --image=#{args['image']}"
        end
      end
    end
  end
end

module SpecTask
  extend Rake::DSL
  extend TaskUtils

  namespace :spec do
    namespace :recipe do
      ENV['SPEC_BACKEND'] = 'DOCKER'
      targets = self.list_basedir('./spec/recipe/*')
      targets.each do |target|
        desc "Run serverspec tests for recipe #{target} using Docker"
        RSpec::Core::RakeTask.new(target.to_sym, [:image]) do |t, args|
          args.with_defaults(image: 'centos:7')
          t.pattern = "spec/recipe/#{target}/*_spec.rb"
          ENV['DOCKER_IMAGE'] = args['image']
        end
      end
    end

    namespace :role do
      targets = self.list_basedir('./spec/role/*')
      targets.each do |target|
        desc "Run serverspec tests to #{target}"
        RSpec::Core::RakeTask.new(target.to_sym, [:backend]) do |t, args|
          args.with_defaults(backend: 'SSH')
          t.pattern = "spec/role/#{target}/*_spec.rb"
          ENV['SPEC_BACKEND'] ||= args['backend']
          ENV['TARGET_HOST'] ||= target
        end
      end
    end
  end
end
