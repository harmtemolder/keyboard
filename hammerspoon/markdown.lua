function wrapSelectedText(wrapCharacters)
  -- Preserve the current contents of the system clipboard
  local originalClipboardContents = hs.pasteboard.getContents()

  -- Copy the currently-selected text to the system clipboard
  keyUpDown('cmd', 'c')

  -- Allow some time for the command+c keystroke to fire asynchronously before
  -- we try to read from the clipboard
  hs.timer.doAfter(0.2, function()
    -- Construct the formatted output and paste it over top of the
    -- currently-selected text
    local selectedText = hs.pasteboard.getContents()
    local wrappedText = wrapCharacters .. selectedText .. wrapCharacters
    hs.pasteboard.setContents(wrappedText)
    keyUpDown('cmd', 'v')

    -- Allow some time for the command+v keystroke to fire asynchronously before
    -- we restore the original clipboard
    hs.timer.doAfter(0.2, function()
      hs.pasteboard.setContents(originalClipboardContents)
    end)
  end)
end

function inlineLink()
  -- Fetch URL from the system clipboard
  local linkUrl = hs.pasteboard.getContents()

  -- Copy the currently-selected text to use as the link text
  keyUpDown('cmd', 'c')

  -- Allow some time for the command+c keystroke to fire asynchronously before
  -- we try to read from the clipboard
  hs.timer.doAfter(0.2, function()
    -- Construct the formatted output and paste it over top of the
    -- currently-selected text
    local linkText = hs.pasteboard.getContents()
    local markdown = '[' .. linkText .. '](' .. linkUrl .. ')'
    hs.pasteboard.setContents(markdown)
    keyUpDown('cmd', 'v')

    -- Allow some time for the command+v keystroke to fire asynchronously before
    -- we restore the original clipboard
    hs.timer.doAfter(0.2, function()
      hs.pasteboard.setContents(linkUrl)
    end)
  end)
end

--------------------------------------------------------------------------------
-- Define Markdown Mode
--
-- Markdown Mode allows you to perform common Markdown-formatting tasks anywhere
-- that you're editing text. Use hyper+m to turn on Markdown mode. Then, use
-- any shortcut below to perform a formatting action. For example, to format the
-- selected text as bold in Markdown, hit hyper+m, and then b.
--
--   b => wrap the selected text in double asterisks ("b" for "bold")
--   c => wrap the selected text in backticks ("c" for "code")
--   i => wrap the selected text in single asterisks ("i" for "italic")
--   s => wrap the selected text in double tildes ("s" for "strikethrough")
--   l => convert the currently-selected text to an inline link, using a URL
--        from the clipboard ("l" for "link")
--------------------------------------------------------------------------------

markdownMode = hs.hotkey.modal.new({}, 'f19')

local msgStr = 'Markdown Mode (Vim Mode > `m`)'
msgStr = msgStr .. (string.format('\n%11s => %s', 'b', 'bold'))
msgStr = msgStr .. (string.format('\n%11s => %s', 'c', 'code'))
msgStr = msgStr .. (string.format('\n%11s => %s', 'i', 'italic'))
msgStr = msgStr .. (string.format('\n%11s => %s', 's', 'strikethrough'))
msgStr = msgStr .. (string.format('\n%11s => %s', 'l', 'link from clipboard'))
msgStr = msgStr .. '\n`m` again to cancel'

local message = require('keyboard.status-message')
markdownMode.statusMessage = message.new(msgStr)

markdownMode.entered = function()
  markdownMode.statusMessage:show()
end

markdownMode.exited = function()
  markdownMode.statusMessage:hide()
end

-- Bind the given key to call the given function and exit Markdown mode
function markdownMode.bindWithAutomaticExit(mode, key, fn)
  mode:bind({}, key, function()
    mode:exit()
    fn()
  end)
end

markdownMode:bindWithAutomaticExit('b', function()
  wrapSelectedText('**')
end)

markdownMode:bindWithAutomaticExit('i', function()
  wrapSelectedText('*')
end)

markdownMode:bindWithAutomaticExit('s', function()
  wrapSelectedText('~~')
end)

markdownMode:bindWithAutomaticExit('l', function()
  inlineLink()
end)

markdownMode:bindWithAutomaticExit('c', function()
  wrapSelectedText('`')
end)

-- Use Vim Mode > `m` to enter Markdown Mode, `m` again to exit
hs.hotkey.bind({}, 'f19', function()
  markdownMode:enter()
end)
markdownMode:bind({}, 'm', function()
  markdownMode:exit()
end)
