watchr = require 'watchr'
compile = require './compile'

module.exports = (args, ignore, root) ->
  error = new Error "Error in watching \"#{root}\""

  new Promise (resolve, reject) ->
    callback = (watcherError) ->
      return unless watcherError?
      error.watcherError = watcherError
      reject error

    listener = (type, file) ->
      return unless type in ['update', 'create']
      try await compile args, ignore, root, file, false
      catch compileError
        error.compileError = compileError
        reject error

    watcher = watchr.open root, listener, callback

    process.once 'SIGINT', ->
      watcher.close()
      process.stdout.write '\n'
