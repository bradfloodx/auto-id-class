"use babel";

// ----------------------------------------------------------------------------
//  auto id class
// ----------------------------------------------------------------------------
import { CompositeDisposable } from "atom";

export default {
  subscriptions: null,

  /*
   * Activate
   * Subscribe key mappings to methods
   */

  // can consume state: activate(state) {
  activate() {
    this.subscriptions = new CompositeDisposable();
    this.subscriptions.add(
      atom.commands.add("atom-text-editor", {
        "auto-id-class:insert_id_attribute": () => this.insert_id_attribute()
      })
    );
    this.subscriptions.add(
      atom.commands.add("atom-text-editor", {
        "auto-id-class:insert_class_attribute": () =>
          this.insert_class_attribute()
      })
    );
  },

  /*
   * Insert ID attribute method
   */
  insert_id_attribute() {
    if (this.cursor_inside_html_tag() || this.cursor_inside_jsx_html_tag()) {
      return this.insert_attribute("id");
    }

    return event.abortKeyBinding();
  },

  /*
   * Insert Class attribute method
   */
  insert_class_attribute() {
    if (this.cursor_inside_html_tag()) {
      return this.insert_attribute("class");
    } else if (this.cursor_inside_jsx_html_tag()) {
      return this.insert_attribute("className");
    }

    return event.abortKeyBinding();
  },

  /*
   * Check if cursor is within an HTML tag
   * returns {Bool}
   */
  cursor_inside_html_tag() {
    const editor = atom.workspace.getActiveTextEditor();
    let cursor;
    if (!editor) {
      return false;
    }

    // Get cursor
    if (editor.cursors) {
      cursor = editor.cursors[0];
    } else {
      return false;
    }

    // Get cursor position and scope
    const cursorBufferPos = cursor.getBufferPosition();
    const cursorScopes = editor.scopeDescriptorForBufferPosition(
      cursorBufferPos
    ).scopes;

    // Checking scope strings against the scope descriptions.
    // First, check if cursor within HTML scope description:
    if (cursorScopes[0] && cursorScopes[0].search("text.html") < 0) {
      return false;
    }

    // Within tag types:
    if (
      cursorScopes[1] &&
      cursorScopes[1].search("meta.tag..*.html") < 0 &&
      cursorScopes[1].search("comment.block.html") < 0
    ) {
      return false;
    }

    // Invalid cursor scope positions:
    const scopesToSkip = [
      "string.quoted.double.html",
      "string.quoted.single.html",
      "entity.other.attribute-name.html"
    ];
    // iterate through every scope, check is it among forbidden-ones
    for (let i = scopesToSkip.length; i--; ) {
      if (cursorScopes.includes(scopesToSkip[i])) {
        return false;
      }
    }

    // Finally is the cursor truly within an html tag? Check for < and > chars now
    // Get the cursors current column and line of buffer for evaluation
    const cursorColumn = cursorBufferPos.column;
    const bufferLine = cursor.getCurrentBufferLine();
    const codeLeftOfColumn = bufferLine.substring(0, cursorColumn);
    const codeRightOfColumn = bufferLine.substring(
      cursorColumn,
      bufferLine.length
    );

    // Is the cursor within < and > ? Exit if not
    if (
      codeLeftOfColumn.lastIndexOf("<") <= codeLeftOfColumn.lastIndexOf(">")
    ) {
      return false;
    }
    if (
      codeRightOfColumn.lastIndexOf(">") <= codeRightOfColumn.lastIndexOf("<")
    ) {
      return false;
    }

    // Is cursor within a closing tag or doctype tag?
    if (
      codeLeftOfColumn.lastIndexOf("/") ===
        codeLeftOfColumn.lastIndexOf("<") + 1 ||
      (codeLeftOfColumn.lastIndexOf("!") ===
        codeLeftOfColumn.lastIndexOf("<") + 1 &&
        // don't exclude HTML comments that start with <!--
        bufferLine.substring(
          codeLeftOfColumn.lastIndexOf("<") + 2,
          codeLeftOfColumn.lastIndexOf("<") + 3
        ) !== "-")
    ) {
      return false;
    }

    // TODO: check if cursor within { curly braces } within an html tag and return false
    // as this can be very annoying when trying to use . and # within Angular tags

    // Made it this far? Must be worthy of a class or id attribute
    return true;
  },

  cursor_inside_jsx_html_tag() {
    const editor = atom.workspace.getActiveTextEditor();
    let cursor;
    if (!editor) {
      return false;
    }

    // Get cursor
    if (editor.cursors) {
      cursor = editor.cursors[0];
    } else {
      return false;
    }

    // Get cursor position and scope
    const cursorBufferPos = cursor.getBufferPosition();
    const cursorScopes = editor.scopeDescriptorForBufferPosition(
      cursorBufferPos
    ).scopes;

    // Checking scope strings against the scope descriptions.
    // First, check if cursor within HTML scope description:
    if (cursorScopes[0] && cursorScopes[0].search("source.js") < 0) {
      return false;
    }

    // Within tag types:
    if (cursorScopes[3] && cursorScopes[3].search("meta.tag.jsx") < 0) {
      return false;
    }

    // Invalid cursor scope positions:
    if (cursorScopes[5]) {
      switch (cursorScopes[5]) {
        case "string.quoted.double.js":
          return false;
        case "entity.other.attribute-name.js":
          return false;
      }
    }

    // Finally is the cursor truly within an html tag? Check for < and > chars now
    // Get the cursors current column and line of buffer for evaluation
    const cursorColumn = cursorBufferPos.column;
    const bufferLine = cursor.getCurrentBufferLine();
    const codeLeftOfColumn = bufferLine.substring(0, cursorColumn);
    const codeRightOfColumn = bufferLine.substring(
      cursorColumn,
      bufferLine.length
    );

    // Is the cursor within < and > ? Exit if not
    if (
      codeLeftOfColumn.lastIndexOf("<") <= codeLeftOfColumn.lastIndexOf(">")
    ) {
      return false;
    }
    if (
      codeRightOfColumn.lastIndexOf(">") <= codeRightOfColumn.lastIndexOf("<")
    ) {
      return false;
    }

    return true;
  },

  /*
   * Insert attribute by string
   */
  insert_attribute(attrType) {
    const editor = atom.workspace.getActiveTextEditor();

    // Insert space, attribute and =""
    // TODO: Don't add space char if already present
    editor.insertText(` ${attrType}=""`);

    // Move multiple cursors back into quotes "|"
    for (var i = 0; i < atom.workspace.getActiveTextEditor().cursors.length; i++) {
      atom.workspace.getActiveTextEditor().cursors[i].moveLeft(1);
    }
    return;
  },

  /*
   * Deactivate
   */
  deactivate() {
    return this.subscriptions.dispose();
  }
};
