checkCWD = require './checkCWD'

test 'find exact match of cwd', ->
  expect(checkCWD([ process.cwd() ])).toBe(true)

test 'find relative path of cwd', ->
  expect(checkCWD([ '.' ])).toBe(true)

test 'find not resolved paths of cwd', ->
  expect(checkCWD([ 'abc/../.' ])).toBe(true)

test 'negative', ->
  expect(checkCWD([ 'foo' ])).toBe(false)
