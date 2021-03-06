{ promises: { writeFile, mkdir } } = require 'fs'
{ dirname } = require 'path'
pug = require 'pug'
loadConfig = require './loadConfig'
mergeConfig = require './mergeConfig'
resolvePath = require './resolvePath'
shouldCompile = require './shouldCompile'

module.exports = (args, ignore, root, source, cache) ->
  return unless shouldCompile source, ignore, args.extensions

  if args.config
    config = args
  else
    config = mergeConfig(args, await loadConfig(source, 'search', cache))

  target = resolvePath root, source, config.out
  try await mkdir dirname(target), { recursive: true }

  content = pug.compileFile(source, config.options)(config.options)
  writeFile target, content
