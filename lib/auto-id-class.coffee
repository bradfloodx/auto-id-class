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

  ###
  Check if the cursor is within an HTML tag
  ###
  cursor_inside_html_tag: ->
    # Grab details of the current cursor and buffer line
    # TODO: Support multiple lines
    cursor = atom.workspace.getActiveTextEditor().cursors[0]
    bufferLine = cursor.getCurrentBufferLine()
    cursorColumn = cursor.getBufferPosition().column

    # Split the current buffer line left and right for evalation
    # to determine if within an HTML tag or not
    codeLeftOfColumn = bufferLine.substring(0, cursorColumn)
    codeRightOfColumn = bufferLine.substring(cursorColumn, bufferLine.length)

    console.log(codeLeftOfColumn)
    console.log(codeRightOfColumn)
    console.log(codeLeftOfColumn.lastIndexOf('"') + '-' + codeLeftOfColumn.lastIndexOf('='))

    # Is the cursor within HTML opening and closing tags? Exit if not
    if(codeLeftOfColumn.lastIndexOf('<') <= codeLeftOfColumn.lastIndexOf('>'))
      return false
    if(codeRightOfColumn.lastIndexOf('>') <= codeRightOfColumn.lastIndexOf('<'))
      return false

    # Is the cursor already within "quotes"?
    # Test by looking for a quote after an =
    if(codeLeftOfColumn.lastIndexOf('"') > 0)
      if(codeLeftOfColumn.lastIndexOf('"') < codeLeftOfColumn.lastIndexOf('=') + 2)
        return false

    # Seems to be, lets do it
    return true


  ###
  Insert attribute by string
  ###
  insert_attribute: (attrType) ->
    editor = atom.workspace.getActiveTextEditor()
    editor.insertText ' ' + attrType + '=""'
    atom.workspace.getActiveTextEditor().cursors[0].moveLeft(1)


  ###
  Deactivate
  ###
  deactivate: ->
  @subscriptions.dispose()
