{ promises: { writeFile, mkdir, rmdir } } = require 'fs'
{ join } = require 'path'
ignore = require 'ignore'
resolveGlob = require './resolveGlob'

testFolder = 'resolveGlobTest'

beforeEach ->
  await mkdir testFolder
  process.chdir testFolder

afterEach ->
  process.chdir '..'
  await rmdir testFolder, { recursive: true }

test 'empty array', ->
  files = await resolveGlob [], ignore()
  expect(files).toEqual []

test 'resolve to a file', ->
  await writeFile 'test.txt', 'hello'

  files = await resolveGlob ['*'], ignore()

  expect(files).toEqual [ 'test.txt' ]

test 'resolve to files', ->
  await writeFile 'test1.txt', 'hello'
  await writeFile 'test2.txt', 'hello'

  files = await resolveGlob ['*'], ignore()

  expect(files.sort()).toEqual [
    'test1.txt'
    'test2.txt'
  ].sort()

test 'work with the working directory', ->
  await writeFile 'test.txt', 'hello'

  files = await resolveGlob ['*'], ignore()

  expect(files).toEqual [ 'test.txt' ]

test 'ignore files', ->
  await writeFile 'test1.txt', 'hello'
  await writeFile 'test2.txt', 'hello'

  files = await resolveGlob ['*'], ignore().add('test2.txt')

  expect(files).toEqual [ 'test1.txt' ]

test 'resolve to folders', ->
  await mkdir 'fruits'
  await writeFile join('fruits', 'banana.txt'), 'hello'
  await writeFile join('fruits', 'apple.txt'), 'hello'

  files = await resolveGlob ['*'], ignore()

  expect(files).toEqual [ 'fruits' ]

test 'resolve to files in folders', ->
  await mkdir 'fruits'
  await writeFile join('fruits', 'banana.txt'), 'hello'
  await writeFile join('fruits', 'apple.txt'), 'hello'

  files = await resolveGlob ['**/*.txt'], ignore()

  expect(files.sort()).toEqual [
    join 'fruits', 'banana.txt'
    join 'fruits', 'apple.txt'
  ].sort()

test 'skip folders', ->
  await mkdir 'fruits'
  await writeFile join('fruits', 'banana.txt'), 'hello'
  await writeFile join('fruits', 'apple.txt'), 'hello'

  await mkdir 'vegetables'
  await writeFile join('vegetables', 'carrot.txt'), 'hello'
  await writeFile join('vegetables', 'potato.txt'), 'hello'

  files = await resolveGlob ['**/*.txt'], ignore().add('fruits')

  expect(files.sort()).toEqual [
    join 'vegetables', 'carrot.txt'
    join 'vegetables', 'potato.txt'
  ].sort()
