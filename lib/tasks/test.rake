namespace :redmine_lightbox do

  desc 'Runs the redmine_lightbox plugin tests'
  Rake::TestTask.new :test do |t|
    t.libs << 'test'
    t.verbose = true
    t.warning = false
    t.pattern = 'plugins/redmine_lightbox/test/**/*_test.rb'
  end

end