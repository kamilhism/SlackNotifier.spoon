# Hammerspoon Slack notifier (without token)

This fork doesn't use Slack API, it just checks launched Slack app's icon badge and shows it in a menubar.

Check the Slack app badge periodically and provide a count of unread DMs and mentions
in a menubar app. Click on the menubar icon to open Slack.

![screenshot](https://zthings.files.wordpress.com/2020/02/screen-shot-2020-02-09-at-11.17.33-pm.png)

## Loading the sppon

Clone this repo in `~/.hammerspoon/Spoons/`. (After doing so, the path to this
readme should be `~/.hammerspoon/Spoons/SlackNotifier.spoon/readme.md`.

Now load the spoon from your Hammerspoon config:

```lua
hs.loadSpoon('SlackNotifier')
spoon.SlackNotifier:start({})
```

# Configuration

- `interval`: Interval in seconds to refresh the menu (default 60)
