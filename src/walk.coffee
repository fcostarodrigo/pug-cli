walk = require '@fcostarodrigo/walk'
shouldCompile = require './shouldCompile'

module.exports = (files, ignore, callback) ->
  shouldWalk = (file) -> file is '.' or not ignore.ignores file

  for root in files
    for await file from walk root, false, shouldWalk
      await callback root, file

  return
