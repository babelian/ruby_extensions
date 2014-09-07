specs_to_run = Dir['./**/*_spec.rb']

specs_to_run.each do |file|
  require file
end
