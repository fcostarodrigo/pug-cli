{ promises: { writeFile, mkdir, rmdir } } = require 'fs'
loadConfig = require './loadConfig'

testFolder = 'loadConfigTest'

beforeEach ->
  await mkdir testFolder
  process.chdir testFolder

afterEach ->
  process.chdir '..'
  await rmdir testFolder, { recursive: true }

test 'return null without a path', ->
  expect(await loadConfig()).toBe(null)

test 'load a config', ->
  await writeFile '.pugrc', JSON.stringify { x: 1 }

  config = await loadConfig '.pugrc', 'load'

  expect(config).toEqual({ x: 1 })

test 'search for a config', ->
  await writeFile '.pugrc', JSON.stringify { x: 1 }

  config = await loadConfig '.', 'search'

  expect(config).toEqual({ x: 1 })

test 'descend folders to search for a config', ->
  await mkdir 'folder'
  await writeFile '.pugrc', JSON.stringify { x: 1 }

  config = await loadConfig 'folder', 'search'

  expect(config).toEqual({ x: 1 })
