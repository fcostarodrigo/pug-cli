{ extname } = require 'path'

module.exports = (file, ignore, extensions) ->
  file isnt '.' and not ignore.ignores(file) and extensions.includes(extname(file))
