walk = require './walk'
compile = require './compile'
loadArgs = require './loadArgs'
checkCWD = require './checkCWD'
loadConfig = require './loadConfig'
loadIgnore = require './loadIgnore'
resolveGlob = require './resolveGlob'
mergeConfig = require './mergeConfig'
resolvePath = require './resolvePath'
filterPaths = require './filterPaths'

module.exports = ->
  args = await loadArgs()
  argConfig = await loadConfig args.configPath, 'load'
  args = mergeConfig args, argConfig
  ignore = await loadIgnore args.ignorePath
  cwd = checkCWD args.files
  files = await resolveGlob filterPaths(args.files), ignore

  await walk files, cwd, ignore, args.extensions, (root, file) ->
    config = loadConfig file, 'search'
    fileConfig = mergeConfig args, config
    target = resolvePath root, file, fileConfig.out
    await compile file, fileConfig.options, target
