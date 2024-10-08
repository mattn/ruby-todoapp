require 'bundler/setup'
require 'json'
require 'yaml'
Bundler.require

set :database, ENV.fetch('DATABASE_URL')
set :show_exceptions, false
set :public_folder, proc { File.join(root, 'assets') }

class Task < ActiveRecord::Base
  self.table_name = 'Task'
  self.primary_key = :id
end

error ActiveRecord::RecordNotFound do |_|
  not_found
end

use Rack::PostBodyContentTypeParser

get '/' do
  File.read('assets/index.html')
end

get '/tasks' do
  content_type :json
  Task.all.order(:id).to_json
end

get '/tasks/:id' do
  content_type :json
  Task.find(params[:id].to_i).to_json
end

post '/tasks', provides: :json do
  content_type :json
  Task.create(text: params[:text].to_s).to_json
end

post '/tasks/:id', provides: :json do
  content_type :json
  Task.update(params[:id].to_i, completed: params[:completed]).to_json
end

delete '/tasks/:id' do
  content_type :json
  Task.destroy_by(id: params[:id].to_i).to_json
end
