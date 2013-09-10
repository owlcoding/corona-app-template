-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )
screenW, screenH, halfW, halfH = display.contentWidth, display.contentHeight, display.contentWidth*0.5, display.contentHeight*0.5
fontName = "AppleCasual"

require "KendersLib.kendersLib"
require "KendersLib.sceneNavigator"

local cust = savedState:get ( "options" )
if ( cust == nil ) then
    cust = {options = {}}
    savedState:set ( "options", cust )
    savedState:save ()
end
savedState:setSync( true ) -- enable iCloud store

storyboard = require "storyboard"

-- load menu screen
storyboard.navigator.isNavigationBarVisible = true
storyboard.navigator.navigationBarHiddenScenes = { "menu", "play", "customizationPage" }

storyboard.gotoScene ( "titlescreen" ) -- here we "go to scene", not push, as we don't want the going back to be possible 
