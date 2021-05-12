generateUVs = assert require "generateUVs"

atlas = love.graphics.newImage "assets/atlas.png"

with love
	.load  = ->
		uvsQ, uvs = generateUVs atlas, 16
		print #uvsQ
		for i, uv in ipairs uvs
			print uv[1], uv[2], uv[3], uv[4]
			--uv\release!

