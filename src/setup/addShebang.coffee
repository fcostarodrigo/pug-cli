fs = require 'fs'

shebang = '#!/usr/bin/env node\n'

do ->
  content = await fs.promises.readFile 'dist/index.js'
  fs.promises.writeFile 'dist/index.js', shebang + content
