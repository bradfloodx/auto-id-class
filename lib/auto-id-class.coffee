{CompositeDisposable} = require 'atom'

module.exports = AutoIdClass =
  subscriptions: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-text-editor', 'auto-id-class:insert_id_attribute': => @insert_id_attribute()
    @subscriptions.add atom.commands.add 'atom-text-editor', 'auto-id-class:insert_class_attribute': => @insert_class_attribute()

  deactivate: ->
    @subscriptions.dispose()

  insert_id_attribute: ->
    editor = atom.workspace.getActiveTextEditor()
    console.log 'insert_id_attribute fired'
    editor.insertText(' id=""')

  insert_class_attribute: ->
    editor = atom.workspace.getActiveTextEditor()
    console.log 'insert_class_attribute fired'
    editor.insertText(' class=""')
