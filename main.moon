generateUVs = assert require "generateUVs"
import random from love.math
Map = assert require "UVmap"
export Keyboard = love.keyboard
Keyboard.keysPressed = {}
export Event = love.event
M = assert require 'moon'
export Dump = M.p

assert require "Shake"

export Random = (min , max) ->
  min, max = min or 0, max or 1
  (min > max and (love.math.random()*(min - max) + max)) or (love.math.random()*(max - min) + min)

atlas = love.graphics.newImage "assets/atlas.png"

Input = assert require 'Input'


with love
  .load  = ->
    mapDef = assert require "assets.map"
    export map = Map mapDef, "assets/"
    inpt = Input!
    Dump inpt
    --x, y = map\pointToTile 32,-16
    --print x, y

    --for i, uv in ipairs map.uvs
      --print uv[1], uv[2], uv[3], uv[4]
      --uv\release!
    export s = Shake(4, 60, 100)


  .update = (dt) ->
    map\update dt
    Keyboard.keysPressed = {}
    s\update dt


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


