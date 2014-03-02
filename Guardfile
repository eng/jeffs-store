guard :rspec do
  watch(%r{^app/(.+)\.rb})                               { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/controllers/application_controller\.rb}) { 'spec/controllers' }
  watch(%r{^lib/(.+)\.rb})                               { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^spec/.+_spec\.rb})
  watch(%r{^spec/spec_helper\.rb}) { 'spec' }
end 
