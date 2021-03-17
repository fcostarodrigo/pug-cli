{ promises: { readFile, writeFile, chmod }, constants: { S_IXUSR } } = require 'fs'
{ spawn } = require 'child_process'
makeIgnore = require 'ignore'
{ glob } = require 'glob-gitignore'

shebang = '#!/usr/bin/env node\n'
executable = 'dist/cliRun.js'

do ->
  ignore = makeIgnore().add('/src/setup/').add('*.test.coffee')
  files = await glob 'src/**/*.coffee', { ignore }
  args = ['--inline-map', '--compile', '--output', 'dist', files...]
  compiler = spawn 'coffee', args, stdio: 'inherit'

  compiler.once 'close', (code) ->
    if code is 0
      content = await readFile executable
      writeFile executable, shebang + content
      await chmod executable, S_IXUSR
    else
      process.exit 1
