generateUVs = assert require "generateUVs"
Map = assert require "UVmap"
export Keyboard = love.keyboard
Keyboard.keysPressed = {}
export Event = love.event

atlas = love.graphics.newImage "assets/atlas.png"

with love
  .load  = ->
    mapDef = assert require "assets.map"
    export map = Map mapDef, "assets/"
    --x, y = map\pointToTile 32,-16
    --print x, y

    --for i, uv in ipairs map.uvs
      --print uv[1], uv[2], uv[3], uv[4]
      --uv\release!

  .update = (dt) ->
    map\update dt
    Keyboard.keysPressed = {}


  .keypressed = (key) ->
    Keyboard.keysPressed[key] = true
    if key == 'escape'
      Keyboard.keysPressed = nil
      Event.quit!

  .keyboard.wasPressed = (key) ->
    if Keyboard.keysPressed[key]
      return true
    else
      return false

  .draw = ->
      map\draw!


