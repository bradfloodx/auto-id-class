{CompositeDisposable} = require 'atom'

module.exports = AutoIdClass =
  subscriptions: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-text-editor', 'auto-id-class:insert_id_attribute': => @insert_id_attribute()
    @subscriptions.add atom.commands.add 'atom-text-editor', 'auto-id-class:insert_class_attribute': (event) ->
        if false
          @insert_attribute('class')
        else
          event.abortKeyBinding()

  deactivate: ->
    @subscriptions.dispose()

  cursor_inside_html_tag: ->
    return true

    # Get contents of current line to evaluate if within HTML tag.
    # TODO: support multiple cursors.
    cursor = atom.workspace.getActiveTextEditor().cursors[0]
    console.log(cursor)
    currentLine = cursor.getCurrentBufferLine()
    console.log(currentLine)
    bufferPos = cursor.getBufferPosition
    console.log(bufferPos)
    return true

  insert_attribute: (type) ->
    editor = atom.workspace.getActiveTextEditor()
    # editor.insertText(' id=""')
    editor.insertText(' class=""')
