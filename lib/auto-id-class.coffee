{CompositeDisposable} = require 'atom'

module.exports = AutoIdClass =
  subscriptions: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-text-editor', 'auto-id-class:insert_id_attribute': (event) => @insert_id_attribute()
    @subscriptions.add atom.commands.add 'atom-text-editor', 'auto-id-class:insert_class_attribute': (event) => @insert_class_attribute()

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
    evnt.abortKeyBinding()

  old_insert_id_attribute: ->
    console.log('done')
    # if @cursor_inside_html_tag()
    #   @insert_attribute('id')
    # else
    #   evnt.abortKeyBinding()

  old_insert_class_attribute: ->
    console.log('done')
    # if @cursor_inside_html_tag()
    #   @insert_attribute('class')
    # else
    #   evnt.abortKeyBinding()

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
