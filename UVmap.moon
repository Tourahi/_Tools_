generateUVs = assert require "generateUVs"
import max from math
import min from math
import floor from math
Graphics = love.graphics


class UVMap
  new: (mapDef, assetsPath) =>
    @mapDef = mapDef
    @layer = mapDef.layers[1]
    @mapWidth = @layer.width  -- tiles
    @mapHeight = @layer.height -- tiles
    @textureAtlas = Graphics.newImage assetsPath..@mapDef.tilesets[1].image
    @tiles = @layer.data
    @tileWidth = @mapDef.tilesets[1].tilewidth
    @tileHeight = @mapDef.tilesets[1].tileheight
    @mX = 0
    @mY = 0
    @mapWidthpx = @mapWidth * @tileWidth
    @mapHeightpx = @mapHeight * @tileHeight
    @UVs, @uvs = generateUVs @textureAtlas,
      @mapDef.tilesets[1].tilewidth,
      @mapDef.tilesets[1].tileheight
    -- Camera
    @mapCamX = 0
    @mapCamY = 0

  draw: () =>
    -- top_left & bottom right of the camera
    tLeft, tBottom = @pointToTile @mapCamX - Graphics\getWidth!,
      @mapCamY - Graphics\getHeight!
    tRight, tTop = @pointToTile @mapCamX + Graphics\getWidth!,
      @mapCamY + Graphics\getHeight!

    for j = tTop, tBottom
      for i = tLeft, tRight
        tile = @getTile i, j
        uvs = @UVs[tile]
        Graphics.draw @textureAtlas, uvs, i * @tileWidth,
          j * @tileHeight

  -- associates a point in the window to a tile
  pointToTile: (x, y) =>
    -- y should be negative so : y == -y
    x += @tileWidth / 2
    y -= @tileHeight / 2

    x = max @mX , x
    y = min @mY , y

    x = min @mX + @mapWidthpx - 1, x
    y = max @mY - @mapHeightpx + 1, y

    tileX = floor (x - @mX) / @tileWidth
    tileY = floor (@mY - y) / @tileHeight

    tileX, tileY

  getTile: (x, y) =>
    x += 1
    @tiles[x + y * @mapWidth]





