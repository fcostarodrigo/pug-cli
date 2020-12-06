{ isPathValid } = require 'ignore'
{ relative } = require 'path'

module.exports = (files) ->
  cwd = process.cwd()
  relativePath = (file) -> try relative cwd, file
  file for file in (relativePath file for file in files) when isPathValid file
