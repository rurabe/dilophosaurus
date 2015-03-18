require 'sinatra'
require 'slim'
require_relative 'models/subnet'

get '/' do
  slim :index
end

post '/split' do
  @data = params[:ips].split(/\n/).map{|i| Subnet.new(i) }
  slim :split
end
