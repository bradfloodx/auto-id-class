{CompositeDisposable} = require 'atom'

module.exports = AutoIdClass =

  subscriptions: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-text-editor', 'auto-id-class:insert_id_attribute': => @insert_id_attribute()
    @subscriptions.add atom.commands.add 'atom-text-editor', 'auto-id-class:insert_class_attribute': => @insert_class_attribute()

  insert_id_attribute: ->
    if @cursor_inside_html_tag()
      @insert_attribute('id')
    else
      event.abortKeyBinding()

  insert_class_attribute: ->
    if @cursor_inside_html_tag()
      @insert_attribute('class')
    else
      event.abortKeyBinding()

  deactivate: ->
    @subscriptions.dispose()

  cursor_inside_html_tag: ->
    cursor = atom.workspace.getActiveTextEditor().cursors[0]
    currentLine = cursor.getCurrentBufferLine()
    console.log(currentLine)
    bufferPos = cursor.getBufferPosition
    console.log(bufferPos)
    return true

  insert_attribute: (attrType) ->
    console.log '@insert attribute ' + attrType
    editor = atom.workspace.getActiveTextEditor()
    editor.insertText ' ' + attrType + '=""'
