generateUVs = assert require "generateUVs"

atlas = love.graphics.newImage "assets/atlas.png"

with love
	.load  = ->
		uvs = generateUVs atlas, 16
		print #uvs
		for i, uv in ipairs uvs
			print uv
			uv\release!

