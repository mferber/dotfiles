--
-- Display settings for ZoomMuteMonitor
-- May be edited at will to suit preferences
--

local transparentColor = {white=1.0, alpha=0.0}
local displaySettings = {colors={transparent=transparentColor}}

--
-- General
--

-- ...how often to check mute status?
-- (note Hammerspoon console, and possibly Hammerspoon, becomes sluggish if we
-- check too often)
displaySettings.pollIntervalSecs = 2.0

-- ...how often should the widgets blink in each state? (0 = no blinking)
displaySettings.blinkIntervalSecs = {
   muted = 0.85,
   unmuted = 2.0,
   unknown = 5.0,
   error = 0.5
}

-- ...how long should the widgets blink 'off'?
displaySettings.blinkDurationSecs = 0.15

--
-- Circular dot widget
--

displaySettings.dotWidget = {}

-- ...how should the dot widget appear (other than color)?
displaySettings.dotWidget.diameter = 75
displaySettings.dotWidget.alpha = 0.75
displaySettings.dotWidget.alphaWhenBlinkedOff = 0.3
displaySettings.dotWidget.strokeWidth = 0

-- ...what colors should it use in each state?
displaySettings.dotWidget.colors = {
   muted = {
      stroke = {hex="#600"},
      fill = {hex="#f00"}
   },
   unmuted = {
      stroke = {hex="#060"},
      fill = {hex="#0f0"}
   },
   unknown = {
      stroke = transparent,
      fill = {hex="#aaa"}
   },
   error = {
      stroke = {hex="#660"},
      fill = {hex="#ff0"}
   }
}

-- ...how far from the bottom and right edges of the screen should it appear?
displaySettings.dotWidget.edgeOffset = hs.geometry(10, 10)

--
-- Menu bar widget
--

displaySettings.menuBarWidget = {}

-- ...what should be displayed in the widget in each state?
displaySettings.menuBarWidget.text = {
   muted = "Zoom: muted",
   unmuted = "Zoom: unmuted",
   unknown = "Zoom: waiting",
   error = "Zoom: ERROR"
}

-- ...what font should the menu bar monitor use, optionally including style
-- and/or size? List fonts in order of preference; we do our best on this
-- but the font lookup is a bit dodgy
displaySettings.menuBarWidget.fonts = {
   {name="Futura", size=18, style="bold"},
   {name="Gill Sans", size=18, style="bold"},
   {name="Verdana", style="bold"},
   {name="Tahoma", style="bold"},
   {name="Helvetica"}
}

displaySettings.menuBarWidget.defaultFontSize = 14 -- if unspecified above
displaySettings.menuBarWidget.defaultFontStyle = "plain" -- if unspecified above

-- ...what colors should the menu bar monitor text use for each state?
displaySettings.menuBarWidget.colors = {
   muted = {
      text={hex="#d00"},
      background={transparent}
   },
   unmuted = {
      text={hex="#090"},
      background={transparent}
   },
   unknown = {
      text={hex="#000"},
      background={transparent}
   },
   error = {
      text={hex="#000"},
      background={transparent}
   }
}

return displaySettings
