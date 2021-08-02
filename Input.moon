import insert from table
import timer from love
import keyboard from love
import mouse from love

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

keyToButton = {
  mouse1: '1',
  mouse2: '2',
  mouse3: '3',
  mouse4: '4',
  mouse5: '5'
}

getTableKeys = (tab) ->
  keyset = {}
  for k,v in pairs(tab)
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

  sequence: (...) =>
    sequence = {...}
    if #sequence <= 1
      error("Use pressed if only checking one action.")
    if type(sequence[#sequence]) ~= 'string'
      error("The last argument must be an action :: string.")
    if #sequence % 2 == 0
      error("The number of arguments must be odd.")

    sequenceKey = ''
    for _, seq in ipairs sequence
      sequence ..= tostring(seq)

    if not @sequences[sequenceKey]
      @sequences[sequenceKey] = {
        sequence: sequence,
        currentIdx: 1
      }
    else
      if @sequences[sequenceKey].currentIdx == 1
        action = @sequences[sequenceKey].sequence[@sequences[sequenceKey].currentIdx]
        for _, key in ipairs @binds[action]
          if @state[key] and not @prevState[key]
            @sequences[sequenceKey].lastPressed = timer.getTime!
            @sequences[sequenceKey].currentIdx += 1

      else
        delay = @sequences[sequenceKey].sequence[@sequences[sequenceKey].currentIdx]
        action = @sequences[sequenceKey].sequence[@sequences[sequenceKey].currentIdx + 1]
        if (timer.getTime! - @sequences[sequenceKey].lastPressed) > delay
          @sequences[sequenceKey] = nil
          return
        for _, key in ipairs @binds[action]
          if @state[key] and not @prevState[key]
            if (timer.getTime! - @sequences[sequenceKey].lastPressed) <= delay
              if @sequences[sequenceKey].currentIdx + 1 == #@sequences[sequenceKey].sequence
                @sequences[sequenceKey] = nil
                return true
              else
                @sequences[sequenceKey].lastPressed = timer.getTime!
                @sequences[sequenceKey].currentIdx += 2
            else
              @sequences[sequenceKey] = nil

  down: (action = nil, interval = nil, delay = nil) =>

    if action and interval and delay
      for _, key in ipairs @binds[action]
        if @state[key] and not @prevState[key]
          @repeatState[key] = {
            pressedTime: timer.getTime!,
            delay: 0,
            interval: interval,
            delayed: true
          }
          return true
        else if @state[key] and @prevState[key]
          return true


    if action and interval and not delay
      for _, key in ipairs @binds[action]
        if @state[key] and not @prevState[key]
          @repeatState[key] = {
            pressedTime: timer.getTime!,
            delay: 0,
            interval: interval,
            delayed: false
          }
          return true
        else if @state[key] and @prevState[key]
          return true

    if action and not interval and not delay
      for _, key in ipairs @binds[action]
        if keyboard.isDown(key) or mouse.isDown(keyToButton[key] or 0)
          return true





