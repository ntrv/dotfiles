require 'rake'
require 'rspec/core/rake_task'

module TaskUtils
  def create_dir_list(path)
    Dir.glob(path).map do |dir|
      next unless File.directory?(dir)
      File.basename(dir)
    end
  end
end

module ItamaeTask
  extend Rake::DSL
  extend TaskUtils

  namespace :itamae do
    namespace :recipe do
      targets = self.create_dir_list('./recipes/*')
      targets.each do |target|
        desc "Run itamae using recipe #{target}"
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
      targets = self.create_dir_list('./spec/recipe/*')
      targets.each do |target|
        desc "Run serverspec tests for recipe #{target} using Docker"
        RSpec::Core::RakeTask.new(target.to_sym, [:image, :host]) do |t, args|
          args.with_defaults(image: 'centos:7', host: 'unix:///var/run/docker.sock')
          t.pattern = "spec/recipe/#{target}/*_spec.rb"
          ENV['DOCKER_IMAGE'] = args['image']
          ENV['DOCKER_HOST'] = args['host']
        end
      end
    end

    namespace :role do
      targets = self.create_dir_list('./spec/role/*')
      targets.each do |target|
        desc "Run serverspec tests to #{target}"
        RSpec::Core::RakeTask.new(target.to_sym, [:backend, :host]) do |t, args|
          args.with_defaults(backend: 'SSH', host: 'localhost')
          ENV['SPEC_BACKEND'] ||= args['backend']
          ENV['TARGET_HOST'] ||= args['host']
          t.pattern = "spec/role/#{target}/*_spec.rb"
        end
      end
    end
  end
end
