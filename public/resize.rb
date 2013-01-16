# photos_src -> photos

# creates a copy of the same directories with the resized files

# helpers

class String

  def dir_path
    split("/")[-3..-1].join("/")
  end

end

def exec(cmd)
  puts "executing: #{cmd}"
  out = nil
  # out = `#{cmd}`
  puts out
end


# main

@dir_src = dir_src = "photos_src"
@dir_dest = dir_dest = "photos"

Dir.glob("#{dir_src}/*/*").each do |dir|
  name = File.basename dir
  exec "mkdir -p #{dir_dest}/#{name}"

  photos = Dir.glob "#{dir_dest}/*.jpg"
  photos.each_with_index do |photo, idx|
    name = File.basename photo
    puts "name: #{name}, dir path: #{photo.dir_path}"

    exec "convert #{photo} -geometry 1100x -density 72 #{idx}.jpg"
    exec "convert #{photo} -thumbnail 300x300 -gravity center -density 72 #{dir_dest}/#{photo.dir_path}/#{name}"
  end
end
