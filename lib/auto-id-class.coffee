# ----------------------------------------------------------------------------
#  auto id class
# ----------------------------------------------------------------------------

{CompositeDisposable} = require 'atom'

module.exports = AutoIdClass =

  subscriptions: null


  ###
  # Activate
  # Subscribe key mappings to methods
  ###
  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-text-editor', 'auto-id-class:insert_id_attribute': => @insert_id_attribute()
    @subscriptions.add atom.commands.add 'atom-text-editor', 'auto-id-class:insert_class_attribute': => @insert_class_attribute()


  ###
  # Insert ID attribute method
  ###
  insert_id_attribute: ->
    if @cursor_inside_html_tag()
      @insert_attribute('id')
    else
      event.abortKeyBinding()


  ###
  # Insert Class attribute method
  ###
  insert_class_attribute: ->
    if @cursor_inside_html_tag()
      @insert_attribute('class')
    else
      event.abortKeyBinding()


  ###
  # Check if cursor is within an HTML tag
  # returns {Bool}
  ###
  cursor_inside_html_tag: ->

    # Grab details of the current cursor
    editor = atom.workspace.getActiveTextEditor()
    cursor = editor.cursors[0] # TODO: Support multiple cursors
    cursorScopes = editor.scopeDescriptorForBufferPosition(cursor.getBufferPosition()).scopes

    console.log(cursorScopes)

    # Checking strings against the scope descriptions -- Is there a cleaner way?
    # Check if cursor within HTML scope description.
    if cursorScopes[0] != 'text.html.basic'
      return false

    # Within tag types:
    if cursorScopes[1].search('meta\.tag\..*\.html') < 0
      return false

    # Invalid positions:
    switch cursorScopes[2]
      when "string.quoted.double.html" then return false

    # Made it this far? Must be worthy of a class or id
    return true


  ###
  # Insert attribute by string
  ###
  insert_attribute: (attrType) ->
    editor = atom.workspace.getActiveTextEditor()
    editor.insertText ' ' + attrType + '=""'
    atom.workspace.getActiveTextEditor().cursors[0].moveLeft(1)


  ###
  # Deactivate
  ###
  deactivate: ->
    @subscriptions.dispose()
