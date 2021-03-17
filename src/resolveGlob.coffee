{ glob } = require 'glob-gitignore'

module.exports = (files, ignore) ->
  if files.length is 0
    files
  else
    glob files, { ignore }
