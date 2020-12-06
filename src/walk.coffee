{ extname, relative } = require 'path'
walk = require '@fcostarodrigo/walk'

module.exports = (files, cwd, ignore, extensions, callback) ->
  checkFile = (file) -> file is '.' or not ignore.ignores file
  files.push '.' if cwd

  for root in files
    asyncIterator = walk root, false, checkFile
    loop
      { value: file, done } = await asyncIterator.next()
      break if done
      continue unless checkFile file
      continue unless extensions.includes(extname(file))
      await callback root, file

  return
