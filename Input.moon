import insert from table


callbacks = {
  'keypressed',
  'keyreleased',
  'mousepressed',
  'mousereleased',
  'gamepadpressed',
  'gamepadreleased',
  'gamepadaxis',
  'wheelmoved',
  'update'
}

getTableKeys = (tab) ->
  keyset = {}
  for k,v in pairs(tab) do
    keyset[#keyset + 1] = k
  keyset

class Input
  new: =>
    @state = {}
    @binds = {}
    @functions = {}
    @prevState = {}
    @repeatState = {}
    @sequences = {}

    -- register callback
    oldCallbacks = {}
    emptyF = -> return
    for _, f in ipairs callbacks
      oldCallbacks[f] = love[f] or emptyF
      love[f] = (...) ->
        oldCallbacks[f](...)
        if self[f]
          self[f](self, ...)

  bind: (key, action) =>
    if type(action) == 'function'
      @functions[key] = action
      return
    if not @binds[action]
      @binds[action] = {}

    insert @binds[action], key

  pressed: (action) =>
    if action
      for _, key in ipairs @binds[action]
        if @state[key] and not @prevState[key]
          return true
    else
      for _, key in ipairs(getTableKeys(@functions))
        if @state[key] and not @prevState[key]
          @functions[key]!


  released: (action) =>
    for _, key in ipairs(@binds[action])
      if @prevState[key] and not @state[key]
        return true




