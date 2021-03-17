ignore = require 'ignore'
watchr = require 'watchr'
watch = require './watch'
compile = require './compile'

jest.mock 'watchr'
jest.mock './compile'
process.once = jest.fn()

test 'close on interruption', ->
  close = jest.fn()
  watchr.open.mockReturnValueOnce { close }

  args = extensions: ['.pug']
  ignorer = ignore()
  root = '.'

  watch args, ignorer, root
  process.once.mock.calls[0][1]()

  expect(close).toBeCalled()

test 'propagate errors', ->
  args = extensions: ['.pug']
  ignorer = ignore()
  root = '.'

  watchr.open.mockImplementationOnce (root, listener, callback) ->
    callback new Error

  expect(watch(args, ignorer, root)).rejects.toThrow()

test 'compile on file creation', ->
  args = extensions: ['.pug']
  ignorer = ignore()
  root = '.'

  watch args, ignorer, root

  watchr.open.mock.calls[0][1]('create', 'index.pug')
  expect(compile).toBeCalledWith(args, ignorer, root, 'index.pug', false)

test 'compile on file update', ->
  args = extensions: ['.pug']
  ignorer = ignore()
  root = '.'

  watch args, ignorer, root

  watchr.open.mock.calls[0][1]('update', 'index.pug')
  expect(compile).toBeCalledWith(args, ignorer, root, 'index.pug', false)
