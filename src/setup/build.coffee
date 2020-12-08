{ promises: { readFile, writeFile } } = require 'fs'
{ spawn } = require 'child_process'
makeIgnore = require 'ignore'
{ glob } = require 'glob-gitignore'

shebang = '#!/usr/bin/env node\n'

do ->
  ignore = makeIgnore().add('/src/setup/').add('*.test.coffee')
  files = await glob 'src/**/*.coffee', { ignore }
  process = spawn 'coffee', ['--compile', '--output', 'dist', files...]

  process.once 'close', ->
    content = await readFile 'dist/cliRun.js'
    writeFile 'dist/cliRun.js', shebang + content
