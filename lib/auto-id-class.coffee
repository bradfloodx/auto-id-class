{CompositeDisposable} = require 'atom'

module.exports = AutoIdClass =
  subscriptions: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-editor', 'auto-id-class:auto_id': => @auto_id()
    @subscriptions.add atom.commands.add 'atom-editor', 'auto-id-class:auto_class': => @auto_class()

  deactivate: ->
    @subscriptions.dispose()

  auto_id: ->
    editor = atom.workspace.getActiveTextEditor()
    console.log 'auto_id activated'
    editor.insertText(' id=""')

  auto_class: ->
    editor = atom.workspace.getActiveTextEditor()
    console.log 'auto_class activated'
    editor.insertText(' class=""')
