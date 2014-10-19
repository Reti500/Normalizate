-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- require the composer library
local composer = require "composer"
composer.userData = {}

composer.userData.email = "-"--"nyabe.tabya@gmail.com"
composer.userData.name = "-"
composer.userData.lastName = "-"
composer.userData.id = 0
composer.userData.token = 0
composer.userData.sessionToken = "-"
composer.userData.sessionExpiry = "-"
composer.isFacebook = false

composer.data = {}
composer.data.normIsActive = false
composer.data.normMXIsActive = false

-- load init
composer.gotoScene( "scripts.scenes.splash" )

-- Add any objects that should appear on all scenes below (e.g. tab bar, hud, etc)