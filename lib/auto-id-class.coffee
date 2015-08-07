{CompositeDisposable} = require 'atom'

module.exports =
  subscriptions: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-text-editor', 'auto-id-class:insert_id_attribute': => @insert_id_attribute(evnt)
    @subscriptions.add atom.commands.add 'atom-text-editor', 'auto-id-class:insert_class_attribute': => @insert_class_attribute(evnt)

  deactivate: ->
    @subscriptions.dispose()

  insert_id_attribute ->
    if @cursor_inside_html_tag()
      @insert_attribute('id')
    else
      evnt.abortKeyBinding()

  insert_class_attribute ->
    if @cursor_inside_html_tag()
      @insert_attribute('class')
    else
      evnt.abortKeyBinding()

  cursor_inside_html_tag: ->
    # Get contents of current line to evaluate if within HTML tag.
    # TODO: support multiple cursors.
    cursor = atom.workspace.getActiveTextEditor().cursors[0]
    console.log(cursor)
    currentLine = cursor.getCurrentBufferLine()
    console.log(currentLine)
    bufferPos = cursor.getBufferPosition
    console.log(bufferPos)
    return true

  insert_attribute: ->
    editor = atom.workspace.getActiveTextEditor()
    editor.insertText(' id=""')
    editor.insertText(' class=""')
