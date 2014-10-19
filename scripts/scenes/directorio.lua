local composer = require( "composer" )
local actionbar = require ("scripts.scenes.actionbar")
local scene = composer.newScene()

local _W = display.contentWidth
local _H = display.contentHeight
local halfW = display.contentCenterX
local halfH = display.contentCenterY

local body = nil
local bg = nil
------------Functions.-----------------------------------------------------------------------

--------------------------------End Functions-------------------------------------------------------------------

-----------------------------------Scenes Functions---------------------------------
function scene:create( event )
    local sceneGroup = self.view

    body = display.newGroup()
    actionbar.create(sceneGroup)
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
        

        bg = display.newRect( body, 0, 0, _W, 10 )
        body.y = actionbar.getHeigth()
    elseif phase == "did" then
    end 
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    
    if event.phase == "will" then
      
    elseif phase == "did" then
    end 
end


function scene:destroy( event )
    local sceneGroup = self.view
end
------------------------------End Funcitons--------------------------------------
---------------------------------------------------------------------------------
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
--------------------------------------------------------------------------------
return scene