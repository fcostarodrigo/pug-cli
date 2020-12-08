{ config } = require 'dotenv'

builder = (command) ->
  command
    .env 'PUG'

    .positional 'files',
      describe: 'Files and folders to compile'
      default: ['.']
      type: 'array'

    .option 'watch',
      alias: 'w',
      describe: 'Watch for changes'
      type: 'boolean'

    .option 'out',
      alias: 'o',
      describe: 'Output directory'
      type: 'string'

    .option 'config',
      alias: 'c',
      describe: 'Configuration file path'
      type: 'string'

    .option 'ignore',
      alias: 'i'
      describe: 'Path of file containing patterns like gitignore'
      default: '.pugignore'
      type: 'string'

    .option 'extensions',
      alias: 'e'
      describe: 'List of extensions to compile'
      default: ['.jade', '.pug']
      type: 'array'

    .option 'options.basedir',
      describe: 'The root directory of all absolute inclusion'
      type: 'string'

    .option 'options.doctype',
      describe: 'Doctype to include in the templates if not specified'
      type: 'string'

    .option 'options.self',
      describe: 'Use a self namespace to hold the locals'
      type: 'boolean'

    .option 'options.debug',
      describe: 'Log tokens and functions to stdout'
      type: 'boolean'

    .option 'options.compileDebug',
      describe: 'Include function source in the compiled template'
      type: 'boolean'

module.exports = ->
  new Promise (resolve) ->
    config()
    require 'yargs'
      .command '* [files..]', false, builder, resolve
      .parse()
