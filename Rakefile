require 'rake'

# module TempFixForRakeLastComment
#   def last_comment
#     last_description
#   end
# end
# Rake::Application.send :include, TempFixForRakeLastComment

require 'rubygems'
require 'rspec/core/rake_task'
require 'bump'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = Dir.glob('spec/**/*_spec.rb')
  t.rspec_opts = '--format documentation --require spec_helper.rb'
end

task default: :spec
