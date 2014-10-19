local composer = require( "composer" )
local widget = require( "widget" )
local slide_menu = require ("scripts.scenes.slide_menu")
local scene = composer.newScene()

local _W = display.contentWidth
local _H = display.contentHeight
local halfW = display.contentCenterX
local halfH = display.contentCenterY

-----------Buttons----------
local starButton
local closeButton
local downloadButton

------------Functions.-----------------------------------------------------------------------

local function handleButtonEvent(event)

    if event.target.id == "close" then
        slide_menu.move = true
        composer.hideOverlay( "fade", 400 )
    end
end

local function scrollListener( event )

    local phase = event.phase
    if ( phase == "began" ) then print( "Scroll view was touched" )
    elseif ( phase == "moved" ) then print( "Scroll view was moved" )
    elseif ( phase == "ended" ) then print( "Scroll view was released" )
    end

    -- In the event a scroll limit is reached...
    if ( event.limitReached ) then
        if ( event.direction == "up" ) then print( "Reached top limit" )
        elseif ( event.direction == "down" ) then print( "Reached bottom limit" )
        elseif ( event.direction == "left" ) then print( "Reached left limit" )
        elseif ( event.direction == "right" ) then print( "Reached right limit" )
        end
    end

    return true
end

local function addLayer(sceneGroup)

    
    local background = display.newImageRect( "images/init/pop_up.png", _W*0.95, _H*0.82)
    background.x = _W*0.5
    background.y = _H*0.55

    local titleTxt = display.newText( "Norma", _W*0.5, _H*0.2, native.systemFont, 25 )
    titleTxt:setFillColor( 1, 0, 0 )

    local norm_id = display.newText( "NOM-002-FITO-2000", _W*0.5, _H*0.28, native.systemFont, 20 )
    norm_id:setFillColor( 1, 0, 0 )

    -- Create the widget
    local scrollView = widget.newScrollView
    {
        -- top = 100,
        -- left = 10,
        --width = 300,
        --height = 400,
        --scrollWidth = 600,
       -- scrollHeight = 800,
        horizontalScrollDisabled = true,
        hideBackground = true,
        listener = scrollListener
    }
    scrollView.x = _W*0.5
    scrollView.y = _H*0.6
    scrollView.width = _W*0.85
    scrollView.height = _H*0.6

    local normTxt = display.newText( "Hello World!", _W*0.5+10, _H*0.53, scrollView.width, scrollView.height, native.systemFont, 16 )
    normTxt:setFillColor( 0,0,0)

    scrollView:insert(normTxt)

    -- Create a image and insert it into the scroll view
    -- local background = display.newImageRect( "assets/scrollimage.png", 768, 1024 )
    -- scrollView:insert( background )

    closeButton = widget.newButton
    {
        id = "close",
        label = "Cerrar",
        onEvent = handleButtonEvent,
        width = _W*0.2,
        height = _W*0.2
    }
    closeButton.x = _W*0.5
    closeButton.y = _H*0.93

    starButton = widget.newButton
    {
        id = "close",
        label = "Star",
        onRealease = handleButtonEvent,
        width = _W*0.2,
        height = _W*0.2
    }
    starButton.x = _W*0.15
    starButton.y = _H*0.93

    downloadButton = widget.newButton
    {
        id = "download",
        label = "Descargar",
        onEvent = handleButtonEvent,
        width = _W*0.2,
        height = _W*0.2
    }
    downloadButton.x = _W*0.85
    downloadButton.y = _H*0.93

    sceneGroup:insert(background)
    sceneGroup:insert(closeButton)
    sceneGroup:insert(scrollView)
    sceneGroup:insert(starButton)
    sceneGroup:insert(downloadButton)
    sceneGroup:insert(titleTxt)
    sceneGroup:insert(norm_id)
end
--------------------------------End Functions-------------------------------------------------------------------

-----------------------------------Scenes Functions---------------------------------
function scene:create( event )
    local sceneGroup = self.view
    print("create --one result.lua")
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then 
        print("show will ---one_result")    
        addLayer(sceneGroup)
         slide_menu.move = false
          
    elseif phase == "did" then
        print("show did ---one_result")    
    end 
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    
    if event.phase == "will" then
        print("hide will ---one_result")    
      
    elseif phase == "did" then
        print("hide did ---one_result")    
    end 
end


function scene:destroy( event )
    local sceneGroup = self.view
    print("destroy  ---one_result")    

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