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
    @mapViewX = 0
    @mapViewY = 0

  draw: () =>
    -- top_left & bottom right of the camera
    tLeft, tBottom = @pointToTile @mX - @mapWidthpx,
      -@mY - @mapHeightpx
    tRight, tTop = @pointToTile @mX + @mapWidthpx,
      -@mY + @mapHeightpx

    for j = tTop, tBottom
      for i = tLeft, tRight
        tile = @getTile i, j
        quad = @UVs[tile]
        if quad != nil
          Graphics.draw @textureAtlas, quad, @mapViewX + i * @tileWidth,
            @mapViewY + j * @tileHeight


  update: (dt) =>
    Graphics.translate -@mapViewX, -@mapViewY
    if Keyboard.wasPressed 'd'
      @mapViewX -= 16
    if Keyboard.wasPressed 'q'
      @mapViewX += 16
    if Keyboard.wasPressed 'z'
      @mapViewY += 16
    if Keyboard.wasPressed 's'
      @mapViewY -= 16
    if Keyboard.wasPressed 'a'
      @goto 500, 500
    if Keyboard.wasPressed 'e'
      @goto 0, 0

  goto: (x, y) =>
    @mapViewX = -(x - @mapWidthpx / 2)
    @mapViewY = -(y - @mapHeightpx / 2)

  -- associates a point in the window to a tile
  pointToTile: (x, y) =>
    -- y should be negative so : y == -y
    x += @tileWidth / 2
    y += @tileHeight / 2

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





