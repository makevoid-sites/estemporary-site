path = File.expand_path '../', __FILE__

require "#{path}/config/env.rb"

class Estemporary < Sinatra::Base
  include Voidtools::Sinatra::ViewHelpers

  def self.glob_photo_dir(dir)
    Dir.glob("#{PATH}/public/photos/#{dir}/*").sort.map do |path|
      name = File.basename path.sub(/\/\d+_/, '/')
      dir = File.basename path
      { name: name, dir: dir, path: path }
    end
  end

  COLLECTIONS = glob_photo_dir "latest_collections"
  PAST_COLL = glob_photo_dir "past_collections"

  def load_photos(dir)
    @photos = Dir.glob("#{PATH}/public/photos/#{dir}/*.{jpg,JPG}").map do |photo|
      dimensions = Dimensions.dimensions photo
      vertical = dimensions[0] < dimensions[1]
      name = File.basename photo
      title = File.basename photo, ".jpg"
      title = title.gsub(/^\d+[_-]/, '').gsub(/_/, " ").capitalize
      { name: name, vertical: vertical, width: dimensions[0], height: dimensions[1], path: "/photos/#{dir}/#{name}", thumb: "/photos_thumbs/#{dir}/#{name}", title: title }
    end.sort_by{ |p| p[:name].to_i }
    puts "PHOTOS!!!!!!!"
    p Dir.glob("#{PATH}/public/photos/#{dir}/*.{jpg,JPG}")
    @photos
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

  def section
    request.path.split("/")[1]
  end

  def subsection
    request.path.split("/")[2]
  end

  def subpath(level)
    request.path.split("/")[level]
  end

  def nav_selected(klass)
    "selected" if section == klass
  end

  def nav_sub_sel(klass)
    "selected" if subsection == klass
  end

  # routes

  get "/" do
    haml :index
  end

  get "/contacts" do
    haml :contacts
  end

  get "/concept" do
    haml :concept
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