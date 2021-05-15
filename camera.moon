import abs from math
import min from math
import max from math
Graphics = love.graphics

-- clamp x between min, max
clamp = (x, min, max) ->
  return x < min and min or (x > max and max or x)

-- send the name for better output
isNumiric = (x, name = "default") ->
  if type x ~= 'number'
    error name .. " must be a number (was: "..tostring x..")"

isPositive = (x, name) ->
  if type x ~= 'number' or x <= 0
    error name.." must be positive number (was: "..tostring x..")"

class Cmera
  new: (left, top, width, height) =>
    sw, sh = Graphics.getWidth!, Graphics.getHeight!
    @x,@y = 0, 0
    @scale = 1
    @angle = 0
    @sin = math.sin(0)
    @cos = math.cos(0)
    @l,@t = 0, 0
    @w,@h = sw, sh
    @w2,@h2 = sw*0.2, sh*0.5
    @setWorld left, top, width, height


  -- test if the boundries left, top, width, height
  -- are valide
  isltwhValid: (l, t, w, h) ->
    isNumiric l, "left"
    isNumiric t, "top"
    isPositive w, "width"
    isPositive h, "height"

  getVisibleArea: () =>
    sin, cos = abs(@sin), abs(@cos)
    w, h = @w / @scale, @h / @scale
    w, h = cos * w + sin * h, sin * w + cos * h
    return min(w, @ww), min(h, @wh)

  adjustPosition: () =>
    wl,wt,ww,wh = @wl,@wt,@ww,@wh
    w,h = @getVisibleArea!
    w2,h2 = w*0.5, h*0.5
    left,right = wl + w2, wl + ww - w2
    top,bottom = wt + h2, wt + wh - h2
    @x,@y = clamp(@x, left, right), clamp(@y, top, bottom)

  setWorld: (l, t, w, h) =>
    @isltwhValid l, t, w, h
    @wl,@wt,@ww,@wh = l,t,w,h
    @adjustPosition!






