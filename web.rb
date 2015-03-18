require 'sinatra'
require 'slim'
require_relative 'models/subnet'

get '/' do
  slim :index
end

post '/split' do
  @subnets = params[:ips].split(/\n/).map{|i| Subnet.new(i) }
  @cs = @subnets.flat_map{|s| s.cs }.each_with_index {|c,i| c.generate_ips!(i) }
  @tm = @cs.flat_map(&:ticketmaster).shuffle
  @px = @cs.flat_map(&:proxy).shuffle
  @axs = @cs.flat_map(&:axs).shuffle
  slim :split
end

helpers do
  def download_href(data)
    %Q[data:text/plain;charset=utf-8,#{URI.escape(data.join("\n"), Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))}]
  end
end