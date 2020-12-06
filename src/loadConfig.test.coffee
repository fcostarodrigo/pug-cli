{ vol } = require 'memfs'
loadConfig = require './loadConfig'

afterEach ->
  vol.reset()

test 'return null without a path', ->
  expect(await loadConfig()).toBe(null)

test 'load a config', ->
  vol.fromJSON
    '/.pugrc': JSON.stringify { x: 1 }

  config = await loadConfig '/.pugrc', 'load'

  expect(config).toEqual({ x: 1 })

test 'search for a config', ->
  vol.fromJSON
    '/.pugrc': JSON.stringify { x: 1 }

  config = await loadConfig '/', 'search'

  expect(config).toEqual({ x: 1 })

test 'descend folders to search for a config', ->
  vol.fromJSON
    '/folder': {}
    '/.pugrc': JSON.stringify { x: 1 }

  config = await loadConfig '/folder', 'search'

  expect(config).toEqual({ x: 1 })
