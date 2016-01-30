require 'rubygems'
require 'bundler/setup'

Bundler::GemHelper.install_tasks

# Test Task
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
  t.ruby_opts = %w(-rubygems)
end

task default: 'test'

# Appraisal
if !ENV['APPRAISAL_INITIALIZED'] && !ENV['TRAVIS']
  require 'appraisal'
  task default: :appraisal
end
