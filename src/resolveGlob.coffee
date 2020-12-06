{ glob } = require 'glob-gitignore'

module.exports = (files, ignore) ->
  if files.length > 0
    glob files, { ignore }
  else
    files
