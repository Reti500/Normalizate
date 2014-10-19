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

local function addLayer_product(sceneGroup)

    
    local background = display.newImageRect( "images/slide_menu/background@2x.png", _W*0.95, _H*0.95)
    background.x = _W*0.5
    background.y = _H*0.5

    local titleTxt = display.newText( "Busqueda Por Producto", _W*0.5, _H*0.1, native.systemFont, 22 )
    titleTxt:setFillColor( 1, 1,1)

    local dependence_id = display.newText( "Lista de Productos", _W*0.1, _H*0.24, native.systemFont, 17)
    dependence_id.anchorX = 0
    dependence_id:setFillColor( 1, 1,1 )
   

    searchButton = widget.newButton
    {
        id = "search",
        label = "Buscar",
        onEvent = handleButtonEvent,
        width = _W*0.2,
        height = _W*0.2
    }
    searchButton.x = _W*0.5
    searchButton.y = _H*0.8

   
    sceneGroup:insert(background)
    sceneGroup:insert(searchButton)
    sceneGroup:insert(titleTxt)
    sceneGroup:insert(dependence_id)
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