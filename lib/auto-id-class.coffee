AutoIdClassView = require './auto-id-class-view'
{CompositeDisposable} = require 'atom'

module.exports = AutoIdClass =
  autoIdClassView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @autoIdClassView = new AutoIdClassView(state.autoIdClassViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @autoIdClassView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'auto-id-class:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @autoIdClassView.destroy()

  serialize: ->
    autoIdClassViewState: @autoIdClassView.serialize()

  toggle: ->
    console.log 'AutoIdClass was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
