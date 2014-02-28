direc = File.dirname(__FILE__)

$LOAD_PATH.push("#{direc}/../lib/")

require 'rubygems'
require "devil/gosu"

img = Devil.load_image("#{direc}/texture.png") 

img.crop(100,100, 200, 200)
img_dup = img.dup

img.rotate(rand(360)).show(200,200).free
img_dup.show(450, 200).free

?

Devil.load("10.jpg") do |img|
    img.crop(x, y, w, h).negate.save("10hut.jpg").show(300, 300).free
end