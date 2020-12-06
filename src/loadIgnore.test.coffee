{ promises: { writeFile, mkdir, rmdir } } = require 'fs'
{ join } = require 'path'
loadIgnore = require './loadIgnore'

testFolder = 'loadIgnoreTest'

beforeEach ->
  await mkdir testFolder
  process.chdir testFolder

afterEach ->
  process.chdir '..'
  await rmdir testFolder, { recursive: true }

test 'ignore paths of a file', ->
  await writeFile '.pugignore', 'test.pug'

  ignore = await loadIgnore '.pugignore'

  expect(ignore.ignores('test.pug')).toBe(true)
  expect(ignore.ignores('index.pug')).toBe(false)

test 'fallback to .gitignore', ->
  await writeFile '.gitignore', 'test.pug'

  ignore = await loadIgnore()

  expect(ignore.ignores('test.pug')).toBe(true)
  expect(ignore.ignores('index.pug')).toBe(false)

test 'fallback to node modules', ->
  ignore = await loadIgnore()

  expect(ignore.ignores(join('node_modules', 'index.pug'))).toBe(true)
  expect(ignore.ignores('index.pug')).toBe(false)
