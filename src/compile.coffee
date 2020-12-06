{ promises: { writeFile, mkdir } } = require 'fs'
{ dirname } = require 'path'
pug = require 'pug'

module.exports = (source, options, target) ->
  content = pug.compileFile(source, options)(options)
  try await mkdir dirname(target), { recurse: true }
  writeFile target, content
