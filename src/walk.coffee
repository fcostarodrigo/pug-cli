walk = require '@fcostarodrigo/walk'
shouldCompile = require './shouldCompile'

module.exports = (files, ignore, callback) ->
  shouldWalk = (file) -> file is '.' or not ignore.ignores file

  for root in files
    asyncIterator = walk root, false, shouldWalk
    loop
      { value: file, done } = await asyncIterator.next()
      break if done
      await callback root, file

  return
