{CompositeDisposable} = require 'atom'

module.exports =
  subscriptions: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-text-editor', 'auto-id-class:insert_id_attribute': => @insert_id_attribute(event)
    @subscriptions.add atom.commands.add 'atom-text-editor', 'auto-id-class:insert_class_attribute': => @insert_class_attribute(event)

  deactivate: ->
    @subscriptions.dispose()

  insert_id_attribute: ->
    if @cursor_inside_html_tag()
      @insert_attribute()

    event.abortKeyBinding()

  insert_class_attribute: ->
    if @cursor_inside_html_tag()
      @insert_attribute()

    event.abortKeyBinding()

  cursor_inside_html_tag: ->
    # Get contents of current line to evaluate if within HTML tag.
    # TODO: support multiple cursors.
    currentLine = atom.workspace.getActiveTextEditor().cursors[0].getCurrentBufferLine()
    console.log(currentLine)
    return true

  insert_attribute: ->
    editor = atom.workspace.getActiveTextEditor()
    editor.insertText(' id=""')
    editor.insertText(' class=""')
