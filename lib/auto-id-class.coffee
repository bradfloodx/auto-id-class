{CompositeDisposable} = require 'atom'

module.exports = AutoIdClass =
  subscriptions: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'auto-id-class:auto_id': => @auto_id()

  deactivate: ->
    @subscriptions.dispose()

  auto_id: ->
    console.log 'auto_id activated'
    editor.insertText(' id=""')

  auto_class: ->
    console.log 'auto_class activated'
    editor.insertText(' class=""')
