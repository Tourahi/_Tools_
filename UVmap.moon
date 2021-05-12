Graphics = love.graphics

class UVMap

	new: (mapDef, assetsPath) =>
		@mapDef = mapDef
		@layer = mapDef.layers[1]
		@mapWidth = @layer.width  -- tiles
		@mapHeight = @layer.height -- tiles
		@textureAtlas = Graphics\newImage assetsPath..@mapDef.tilesets[1].image
		@tiles = @layer.data
		@tileWidth = @mapDef.tilesets[1].tilewidth
		@tileHeight = @mapDef.tilesets[1].tileheight
		@mX = Graphics\getWidth! / 2 + @tileWidth / 2
		@mY = Graphics\getHeight! / 2 - @tileHeight / 2
		@mapWidthpx = @mapWidth * @tileWidth
		@mapHeightpx = @mapHeight * @tileHeight


