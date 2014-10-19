local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
local slide_menu = require ("scripts.scenes.slide_menu")
local actionbar = require ("scripts.scenes.actionbar")


local _W = display.contentWidth
local _H = display.contentHeight
local halfW = display.contentCenterX
local halfH = display.contentCenterY

local productButton
 
local normButton
local normMXButton
local productButton
local dependenceButton
local advancedButton
local directoryButton

 -- Function to handle button events
local function handleButtonEvent( event )
    if  "advancedButton" == event.target.id  then
        local options = 
        {
            effect = "fade",
            time = 500,
            isModal = true,
            params = 
            {
                search_type = "advance",
            }
        }
        composer.showOverlay( "scripts.scenes.search", options )
    elseif  "normButton" == event.target.id  then
        composer.showOverlay( "scripts.scenes.one_result", options )
    elseif  "dependenceButton" == event.target.id  then
        local options = 
            {
                effect = "fade",
                time = 500,
                isModal = true,
                params = 
                {
                    search_type = "dependence",
                }
            }
        composer.showOverlay( "scripts.scenes.search", options )
    elseif  "productButton" == event.target.id  then
        local options = 
        {
            effect = "fade",
            time = 500,
            isModal = true,
            params = 
            {
                search_type = "product",
            }
        }
        composer.showOverlay( "scripts.scenes.search", options )
        
    elseif  "directoryButton" == event.target.id  then
        print("llamando")
        system.openURL( "tel:415-867-5309" )        
    end
end

function listenersButtons(isActive)
    productButton:setEnabled(isActive)
    normButton:setEnabled(isActive)
    normMXButton:setEnabled(isActive)
    dependenceButton:setEnabled(isActive)
    advancedButton:setEnabled(isActive)
    directoryButton:setEnabled(isActive)
end

local function addLayer(sceneGroup)     

    normButton = widget.newButton
    {
        id = "normButton",
        label = "NOM",
        onRelease = handleButtonEvent,
        width = _W*0.2,
        height = _W*0.2
    }
    normButton.x = _W*0.25
    normButton.y = _H*0.2 +_W*0.3

    normMXButton = widget.newButton
    {
        id = "normMXButton",
        label = "NOMX",
        onRelease = handleButtonEvent,
        width = _W*0.2,
        height = _W*0.2
    }
    normMXButton.x = _W*0.75
    normMXButton.y = _H*0.2+_W*0.3

    productButton = widget.newButton
    {
        id = "productButton",
        label = "Producto",
        onRelease = handleButtonEvent,
        width = _W*0.15,
        height = _W*0.15
    }
    productButton.x = _W*0.5
    productButton.y = _H*0.55

    dependenceButton = widget.newButton
    {
        id = "dependenceButton",
        label = "Por Dependencia",
        onRelease = handleButtonEvent,
        width = _W*0.15,
        height = _W*0.15
    }
    dependenceButton.x = _W*0.5
    dependenceButton.y = _H*0.65

    advancedButton = widget.newButton
    {
        id = "advancedButton",
        label = "Avanzada",
        onRelease = handleButtonEvent,
        width = _W*0.15,
        height = _W*0.15
    }
    advancedButton.x = _W*0.5
    advancedButton.y = _H*0.75

    directoryButton = widget.newButton
    {
        id = "directoryButton",
        label = "Directorio",
        onRelease = handleButtonEvent,
        width = _W*0.15,
        height = _W*0.15
    }
    directoryButton.x = _W*0.5
    directoryButton.y = _H*0.9

    sceneGroup:insert(normButton)
    sceneGroup:insert(normMXButton)
    sceneGroup:insert(productButton)
    sceneGroup:insert(dependenceButton)
    sceneGroup:insert(advancedButton)
    sceneGroup:insert(directoryButton)
end
--------------------------------End Functions-------------------------------------------------------------------

-----------------------------------Scenes Functions---------------------------------
function scene:create( event )
    local sceneGroup = self.view
    print("create init.lua")
    --actionbar.create()
    addLayer(sceneGroup) 
    slide_menu.create(sceneGroup)
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then 
        print("show will init.lua")
       
    elseif phase == "did" then
        print("show did init.lua")
    end 
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    
    if event.phase == "will" then
        print("hide will init.lua")
      
    elseif phase == "did" then
        print("hide did init.lua")
    end 
end

function scene:destroy( event )
    local sceneGroup = self.view
    print("destroy init.lua")

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