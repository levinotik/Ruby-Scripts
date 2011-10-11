#!/usr/bin/env ruby
require 'digest/md5'

#Author: Levi Notik

# Pass the directory path in which to 
# recursively search for duplicate JPEG files as the ARG. The uniqueness of each JPEG
# is determined by its hexidigest. Duplicates are added to an array and
# then deleted.   

ARGV.each do |path|
  unique_photos = Hash.new
  duplicates = Array.new
  files = Dir[File.join(path, '**', "*.{JPG,jpg}")].each do |f| 
    if unique_photos[Digest::MD5.hexdigest(File.read(f))]
      duplicates.push(f)
    else
      unique_photos[Digest::MD5.hexdigest(File.read(f))] = f
      print '.'
    end
  end

  puts "#{unique_photos.count+duplicates.count} files checked... #{unique_photos.count} were unique
  and #{duplicates.count} were duplicates"

  space_recovered = 0
  duplicates.each do |duplicate| 
    space_recovered +=  File.new(duplicate).size
    File.delete(duplicate)
  end

  puts "by deleting duplicates, you freed up #{space_recovered.to_f/1024/1024}
  megabytes or #{space_recovered.to_f/1024/1024/1024} gigabytes"

end

