path = File.expand_path '../', __FILE__

require "#{path}/config/env.rb"

class Estemporary < Sinatra::Base
  include Voidtools::Sinatra::ViewHelpers

  def load_photos(dir)
    @photos = Dir.glob("#{PATH}/public/photos/#{dir}/*.jpg").map do |photo|
      dimensions = Dimensions.dimensions photo
      vertical = dimensions[0] < dimensions[1]
      name = File.basename photo
      { name: name, vertical: vertical, width: dimensions[0], height: dimensions[1], path: "/photos/#{dir}/#{name}" }
    end.sort_by{ |p| p[:name].to_i }
  end

  # partial :comment, { comment: "blah" }
  # partial :comment, comment

  def partial(name, value={})
    locals = if value.is_a? Hash
      value
    else
      hash = {}; hash[name] = value
      hash
    end
    haml "_#{name}".to_sym, locals: locals
  end

  get "/" do
    haml :index
  end

  get "/contacts" do
    haml :contacts
  end

  get "/photos/*/*" do |dir, subdir|
    @dir = dir
    @subdir = subdir
    haml :collections
  end
end

require_all "#{path}/routes"