local composer = require( "composer" )
local scene = composer.newScene()
local widget = require ("widget")

local centerX = display.contentCenterX
local centerY = display.contentCenterY
local _W = display.contentWidth
local _H = display.contentHeight

---------------------------------------------------------------------------------
local function onKeyEvent( event )
    -- Print which key was pressed down/up to the log.
    local message = "Key '" .. event.keyName .. "' was pressed " .. event.phase
    --print( message )
    -- If the "back" key was pressed on Android, then prevent it from backing out of your app.
    if (event.keyName == "back") and (system.getInfo("platformName") == "Android") and (event.phase == "up") then                           
        return true
    else
        return false    
    end
end

-----------------End Check internet connection---------------------------------------------------------
local function ui(group)
    
    local background = display.newImageRect("images/splash.png",_W, _H)
    background.x = _W*0.5
    background.y = _H*0.5
    group:insert(background)

    local spinner = widget.newSpinner
    {
        width = 60,
        height = 60,
        incrementEvery = 50
    }
    spinner.x = centerX
    spinner.y = centerY*1.55
    spinner:start()

    local function listener( event )
        local options = {
        effect = "fade",
        time = 1000,
        }
        composer.gotoScene("scripts.scenes.init",options)
    end

    timer.performWithDelay( 1000, listener )
    
    group:insert(spinner)
end        

function scene:create( event )
    local sceneGroup = self.view
    print("Creando loading ---loading")
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase
    
    if phase == "will" then
         ui(sceneGroup) 
         Runtime:addEventListener( "key", onKeyEvent )  

    elseif phase == "did" then
    end 
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    
    if event.phase == "will" then
        print("hide loading ---loading")
    elseif phase == "did" then
    end 
end

function scene:destroy( event )
    local sceneGroup = self.view
    print("Destroy loading ---loading")
    Runtime:removeEventListener( "key", onKeyEvent )    
end
---------------------------------------------------------------------------------
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
---------------------------------------------------------------------------------
return scene