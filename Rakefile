ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'

task :console do
  Pry.start
end

task :drop do
  system('rm db/development.sqlite && rm db/schema.rb && rm db/test.sqlite')
end

task :migrations do
  system('rake db:migrate && rake db:migrate SINATRA_ENV=test')
end
