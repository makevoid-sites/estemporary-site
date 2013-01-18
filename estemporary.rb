path = File.expand_path '../', __FILE__

require "#{path}/config/env.rb"

class Estemporary < Sinatra::Base
  include Voidtools::Sinatra::ViewHelpers

  COLLECTIONS = Dir.glob("#{PATH}/public/photos/collections/*")


  def load_photos(dir)
    @photos = Dir.glob("#{PATH}/public/photos/#{dir}/*.jpg").map do |photo|
      dimensions = Dimensions.dimensions photo
      vertical = dimensions[0] < dimensions[1]
      name = File.basename photo
      title = File.basename photo, ".jpg"
      title = title.gsub(/^\d+[_-]/, '').gsub(/_/, " ").capitalize
      { name: name, vertical: vertical, width: dimensions[0], height: dimensions[1], path: "/photos/#{dir}/#{name}", thumb: "/photos_thumbs/#{dir}/#{name}", title: title }
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

  get "/gallery/*" do |dir|
    @dir = dir
    haml :gallery
  end

  get "/gallery/*/*" do |dir, subdir|
    @dir = dir
    @subdir = subdir
    haml :gallery
  end
end

require_all "#{path}/routes"

# monkeypatches

class String
  def humanize
    gsub(/_/, ' ').capitalize
  end
end