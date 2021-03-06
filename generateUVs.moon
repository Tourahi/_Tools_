import insert from table
import floor from math
import newQuad from love.graphics

generateUVs = (texture, tileWidth, tileHeight) ->
  uvsQuads = {}
  uvs = {}

  textureW = texture\getWidth!
  textureH = texture\getHeight!


  -- tile width/height as a persentage of the texture
  widthPs = tileWidth / textureW
  heightPs = tileHeight / textureH
  cols = textureW / tileWidth
  rows = textureH / tileHeight

  -- top left position of the tile in texture
  left = 0
  top = 0

  -- bottom right position of the tile in texture
  right = widthPs
  bottom = heightPs

  for j = 0, rows - 1
    for i = 0, cols - 1
      insert uvsQuads, newQuad left * textureW,
        top * textureH,
        tileWidth,
        tileHeight,
        texture
      insert uvs, {top, left, bottom, right}
      left += widthPs
      right += heightPs
    -- print left,top,right,bottom
    left = 0
    top += heightPs
    right = widthPs
    bottom += heightPs


  uvsQuads, uvs


generateUVs
