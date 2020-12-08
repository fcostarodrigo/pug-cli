{ spawn } = require 'child_process'

files = [
  'src/setup/transform.coffee'
  'src/setup/dependencyExtractor.coffee'
]

spawn 'coffee', ['--compile', '--output', 'testSetup', files...]
