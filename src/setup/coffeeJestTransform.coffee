coffee = require 'coffeescript'

module.exports =
  process: (src, filename) ->
    { js, v3SourceMap } = coffee.compile src, { sourceMap: true }

    v3SourceMap = JSON.parse v3SourceMap

    map =
      version: v3SourceMap.version
      sources: [filename]
      names: []
      mappings: v3SourceMap.mappings
      sourcesContent: [src]

    { code: js, map }
