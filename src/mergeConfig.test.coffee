mergeConfig = require './mergeConfig'

test 'merge args with config giving args precedence', ->
  args = { a: 1, b: 2 }
  config = { b: 3, c: 4 }

  result = mergeConfig args, config

  expect(result).toEqual({ a: 1, b: 2, c: 4})

test 'return args when there is no config', ->
  args = { a: 1, b: 2 }

  result = mergeConfig args, null

  expect(result).toEqual({ a: 1, b: 2 })
