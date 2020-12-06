{ createHash } = require 'crypto';
coffee = require 'coffeescript'

module.exports =
  getCacheKey: (sourceText, sourcePath, configString) ->
    createHash 'md5'
      .update sourceText
      .update '\0', 'utf8'
      .update sourcePath
      .update '\0', 'utf8'
      .update configString
      .digest 'hex'

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
