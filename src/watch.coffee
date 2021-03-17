watchr = require 'watchr'
compile = require './compile'

module.exports = (args, ignore, root) ->
  callback = (err) -> throw err if err?
  listener = (type, file) ->
    switch type
      when 'update', 'create'
        await compile args, ignore, root, file, false

  watcher = watchr.open root, listener, callback

  process.once 'SIGINT', -> watcher.close()
