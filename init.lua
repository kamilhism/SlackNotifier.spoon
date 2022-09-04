--- === SlackNotifier ===
---
--- Check Slack app badge periodically and provide a count of unread DMs and mentions
--- in a menubar app.

-- luacheck: globals hs

local obj = {}

-- Metadata
obj.name = 'SlackNotifier'
obj.version = '2.0'
obj.author = 'Chris Zarate <chris@zarate.org>'
obj.homepage = 'https://github.com/chriszarate/SlackNotifier.spoon'
obj.license = 'MIT - https://opensource.org/licenses/MIT'

-- create the icon
-- http://xqt2.com/asciiIcons.html
local iconAscii = [[ASCII:
............
............
....AD......
..F.....PQ..
..I.........
..........G.
..........H.
.K..........
.N..........
.........L..
..BC.....M..
......SR....
............
............
]]

local icon = hs.image.imageFromASCII(iconAscii)

-- on click, open slack
local function onClick()
	hs.application.launchOrFocus('Slack')
end

-- update the menu bar
local function updateCount(count)
	if count == '0' then
		obj.menu:setTitle('')
	else
		obj.menu:setTitle(count)
	end
end

-- timer callback, fetch badge
local function onInterval()
  local dock = hs.axuielement.applicationElement('Dock'):attributeValue('AXChildren')

  for _, v in pairs(dock[1].AXChildren) do
    if v:attributeValue('AXTitle') == 'Slack' then
      local count = v:attributeValue('AXStatusLabel') or '0'
			updateCount(count)
      break
    end
  end
end

--- SlackNotifier:start(config)
--- Method
--- Start the spoon
---
--- Parameters:
---  * config - A table containing config values:
--              interval: Interval in seconds to refresh the menu (default 1)
---
--- Returns:
---  * self (allow chaining)
function obj:start(config)
	local interval = config.interval or 1

	-- create menubar (or restore it)
	if self.menu then
		self.menu:returnToMenuBar()
	else
		self.menu = hs.menubar.new():setClickCallback(onClick):setIcon(icon)
	end

	-- set timer to fetch periodically
	self.timer = hs.timer.new(interval, onInterval)
	self.timer:start()

	-- fetch immediately, too
	onInterval()

	return self
end

--- SlackNotifier:stop()
--- Method
--- Stop the spoon
---
--- Parameters: none
---
--- Returns:
---  * self (allow chaining)
function obj:stop()
	if self.menu then
		self.menu:removeFromMenuBar()
	end

	if self.timer then
		self.timer:stop()
	end

	return self
end

return obj
