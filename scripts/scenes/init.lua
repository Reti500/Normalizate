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
local searchField 

 -- Function to handle button events
local function handleButtonEvent( event )
    if  "ended" == event.phase  then
        print( "Button was pressed and released" )
    end
end

local function textListener( event )

    if ( event.phase == "began" ) then

        -- user begins editing text field
        print( event.text )

    elseif ( event.phase == "ended" or event.phase == "submitted" ) then

        -- text field loses focus
        -- do something with defaultField's text
        print( "Submitted text: " .. event.target.text )

    elseif ( event.phase == "editing" ) then

        print( event.newCharacters )
        print( event.oldText )
        print( event.startPosition )
        print( event.text )

    end
end

local function addLayer(sceneGroup)  

   

    local normButton = widget.newButton
    {
        id = "normButton",
        label = "NOM",
        onEvent = handleButtonEvent,
        width = _W*0.2,
        height = _W*0.2
    }
    normButton.x = _W*0.25
    normButton.y = _H*0.2 +_W*0.3

    local normMXButton = widget.newButton
    {
        id = "normMXButton",
        label = "NOMX",
        onEvent = handleButtonEvent,
        width = _W*0.2,
        height = _W*0.2
    }
    normMXButton.x = _W*0.75
    normMXButton.y = _H*0.2+_W*0.3

    productButton = widget.newButton
    {
        id = "productButton",
        label = "Producto",
        onEvent = handleButtonEvent,
        width = _W*0.15,
        height = _W*0.15
    }
    productButton.x = _W*0.5
    productButton.y = _H*0.55

    local dependenceButton = widget.newButton
    {
        id = "dependenceButton",
        label = "Por Dependencia",
        onEvent = handleButtonEvent,
        width = _W*0.15,
        height = _W*0.15
    }
    dependenceButton.x = _W*0.5
    dependenceButton.y = _H*0.65

    local advancedButton = widget.newButton
    {
        id = "advancedButton",
        label = "Avanzada",
        onEvent = handleButtonEvent,
        width = _W*0.15,
        height = _W*0.15
    }
    advancedButton.x = _W*0.5
    advancedButton.y = _H*0.75

    local directoryButton = widget.newButton
    {
        id = "directoryButton",
        label = "Directorio",
        onEvent = handleButtonEvent,
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
    actionbar.create()
    addLayer(sceneGroup) 
    slide_menu.create(sceneGroup)
    productButton:setEnabled(false)
    
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then 
        
       
      
       
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