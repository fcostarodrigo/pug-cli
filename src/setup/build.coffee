{ promises: { readFile, writeFile, chmod }, constants: { S_IXUSR } } = require 'fs'
{ spawn } = require 'child_process'
makeIgnore = require 'ignore'
{ glob } = require 'glob-gitignore'

shebang = '#!/usr/bin/env node\n'
executable = 'dist/cliRun.js'

do ->
  ignore = makeIgnore().add('/src/setup/').add('*.test.coffee')
  files = await glob 'src/**/*.coffee', { ignore }
  process = spawn 'coffee', ['--compile', '--output', 'dist', files...]

  process.once 'close', ->
    content = await readFile executable
    writeFile executable, shebang + content
    await chmod executable, S_IXUSR
