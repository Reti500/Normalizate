local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )

local _W = display.contentWidth
local _H = display.contentHeight
local halfW = display.contentCenterX
local halfH = display.contentCenterY

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

local function addLayer()  

    local searchField
    -- Create text field
    searchField = native.newTextField( _W*0.43, _H*0.2, _W*0.7, _H*0.07 )
    searchField:addEventListener( "userInput", textListener )
    searchField.placeholder = "Buscar"
    searchField:setReturnKey("search")
    -- -- Create the widget
    local searchButton = widget.newButton
    {
        id = "searchButton",
        label = "B",
        onEvent = handleButtonEvent,
        width = searchField.width*0.20,
        height = searchField.height
    }
    searchButton.x = _W*0.5+searchField.width*0.5
    searchButton.y = searchField.y

    local normButton = widget.newButton
    {
        id = "normButton",
        label = "NOM",
        onEvent = handleButtonEvent,
        width = _W*0.2,
        height = _W*0.2
    }
    normButton.x = _W*0.23
    normButton.y = searchField.y+_W*0.3

    local normMXButton = widget.newButton
    {
        id = "normMXButton",
        label = "NOMX",
        onEvent = handleButtonEvent,
        width = _W*0.2,
        height = _W*0.2
    }
    normMXButton.x = _W*0.7
    normMXButton.y = searchField.y+_W*0.3


end

--------------------------------End Functions-------------------------------------------------------------------

-----------------------------------Scenes Functions---------------------------------
function scene:create( event )
    local sceneGroup = self.view
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then 
        addLayer()    
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