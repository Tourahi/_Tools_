generateUVs = assert require "generateUVs"
import max from math
import min from math
import floor from math
import ceil from math
Graphics = love.graphics
Keyboard = love.keyboard

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
    @mapWidthpx = @mapWidth * @tileWidth
    @mapHeightpx = @mapHeight * @tileHeight
    @mX = 0
    @mY = 0
    @UVs, @uvs = generateUVs @textureAtlas,
      @mapDef.tilesets[1].tilewidth,
      @mapDef.tilesets[1].tileheight
    -- Camera
    @mapCamX = 0
    @mapCamY = 0
    @drawX = Graphics.getWidth!
    @drawY = Graphics.getHeight!
    @tLeft, @tBottom = @pointToTile @mX - @drawX,
      @mY - @drawY
    @tRight, @tTop = @pointToTile @mX + @drawX,
      @mY + @drawY

  draw: () =>
    -- top_left & bottom right of the camera
    tLeft, tBottom = @pointToTile @mX - @drawX,
      @mY - @drawY
    tRight, tTop = @pointToTile @mX + @drawX,
      @mY + @drawY

    tLeft += max 0, tRight - @tRight
    tTop += max 0, tBottom - @tBottom

    for j = tTop, tBottom
      for i = tLeft, tRight
        tile = @getTile i, j
        quad = @UVs[tile]
        Graphics.draw @textureAtlas, quad, @mX + i * @tileWidth,
          @mY + j * @tileHeight


  update: (dt) =>
    Graphics.translate -@mX, -@mY
    if Keyboard.wasPressed 'd'
      @mX -= 10
      @drawX += 10
    if Keyboard.wasPressed 'q'
      @mX += 10
      @drawX -= 10
    if Keyboard.wasPressed 'z'
      @mY += 10
      @drawY -= 10
    if Keyboard.wasPressed 's'
      @mY -= 10
      @drawY += 10
    if Keyboard.wasPressed 'a'
      @goto -240, -240

  -- associates a point in the window to a tile
  pointToTile: (x, y) =>
    -- y should be negative so : y == -y

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





