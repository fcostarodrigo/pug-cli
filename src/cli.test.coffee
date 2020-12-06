{ promises: { readFile, writeFile, mkdir, rmdir, readdir } } = require 'fs'
{ spawnSync } = require 'child_process'
{ join } = require 'path'

testFolder = 'cliTest'

script = join '..', 'src', 'cli.coffee'

beforeEach ->
  await mkdir testFolder
  process.chdir testFolder

afterEach ->
  process.chdir '..'
  await rmdir testFolder, { recursive: true }

test 'display help', ->
  process = spawnSync 'coffee', [script, '--help']
  expect(process.stdout.toString()).toMatchSnapshot();

test 'compile a pug file', ->
  await writeFile 'index.pug', 'div hello'

  spawnSync 'coffee', [script]

  content = await readFile 'index.html', 'utf-8'
  expect(content).toBe('<div>hello</div>')

test 'compile a specific pug file', ->
  await writeFile 'index1.pug', 'div hello'
  await writeFile 'index2.pug', 'div hello'

  spawnSync 'coffee', [script, 'index1.pug']

  files = await readdir '.'
  expect(files.sort()).toEqual [
    'index1.pug'
    'index2.pug'
    'index1.html'
  ].sort()

test 'compile to a target folder', ->
  await writeFile 'index.pug', 'div hello'

  spawnSync 'coffee', [script, '--out', 'dist']

  content = await readFile join('dist', 'index.html'), 'utf-8'
  expect(content).toBe('<div>hello</div>')
