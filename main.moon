generateUVs = assert require "generateUVs"
Map = assert require "UVmap"

atlas = love.graphics.newImage "assets/atlas.png"

with love
	.load  = ->
		mapDef = assert require "assets.map"
		map = Map mapDef, "assets/"
		print map.mX
		print map.mY
		print map.mapWidthpx
		x, y = map\pointToTile 32,-40
		print x, y
		for i, uv in ipairs map.uvs
			print uv[1], uv[2], uv[3], uv[4]
			--uv\release!

