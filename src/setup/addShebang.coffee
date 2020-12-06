{ promises: { writeFile, readFile } } = require 'fs'

shebang = '#!/usr/bin/env node\n'

do ->
  content = await readFile 'dist/cli.js'
  writeFile 'dist/cli.js', shebang + content
