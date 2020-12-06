{ promises: { writeFile } } = require 'fs'
openPath = require '@fcostarodrigo/open-path'
pug = require 'pug'

module.exports = (source, options, target) ->
  content = pug.compileFile(source, options)(options)
  await openPath target, true
  writeFile target, content
