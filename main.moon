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
    export inpt = Input!
    Dump inpt



    inpt\bind 'c', ->
      print "c was pressed"
    inpt\bind 'p', "print"
    inpt\bind 'right', "right"
    --x, y = map\pointToTile 32,-16
    --print x, y

    --for i, uv in ipairs map.uvs
      --print uv[1], uv[2], uv[3], uv[4]
      --uv\release!
    export s = Shake(4, 60, 100)


  .update = (dt) ->
    if inpt\pressed "print"
      print "p is indeed pressed"
    if inpt\released "print"
      print "p is indeed released"

    if inpt\down "print"
      print "p is indeed downed"

    if inpt\sequence('right', 0.5, 'right')
      print "right"
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


