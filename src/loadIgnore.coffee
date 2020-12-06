{ promises: { readFile} } = require 'fs'
ignore = require 'ignore'

module.exports = (ignorePath) ->
  try
    ignore().add await readFile ignorePath, 'utf-8'
  catch
    try
      ignore().add await readFile '.gitignore', 'utf-8'
    catch
      ignore().add 'node_modules/'
