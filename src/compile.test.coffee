{ promises: { writeFile, mkdir, readFile, rmdir } } = require 'fs'
{ join } = require 'path'
compile = require './compile'

testFolder = 'compileTest'

beforeEach ->
  await mkdir testFolder
  process.chdir testFolder

afterEach ->
  process.chdir '..'
  await rmdir testFolder, { recursive: true }

test 'compile a file', ->
  await writeFile 'index.pug', 'div hello'
  await compile 'index.pug', {}, 'index.html'
  content = await readFile 'index.html', 'utf-8'
  expect(content).toBe('<div>hello</div>')

test 'compile to target folder', ->
  target = join 'dist', 'index.html'
  await writeFile 'index.pug', 'div hello'
  await compile 'index.pug', {}, target
  content = await readFile target, 'utf-8'
  expect(content).toBe('<div>hello</div>')

test 'pass parameters to pug compiler', ->
  await writeFile 'index.pug', 'div= message'
  await compile 'index.pug', { message: 'hello' }, 'index.html'
  content = await readFile 'index.html', 'utf-8'
  expect(content).toBe('<div>hello</div>')
