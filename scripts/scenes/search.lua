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

local function addLayer_dependence(sceneGroup)

    
    local background = display.newImageRect( "images/slide_menu/background@2x.png", _W*0.95, _H*0.95)
    background.x = _W*0.5
    background.y = _H*0.5

    local titleTxt = display.newText( "Busqueda Por Dependencia", _W*0.5, _H*0.1, native.systemFont, 22 )
    titleTxt:setFillColor( 1, 1,1)

    local dependence_id = display.newText( "Dependencia", _W*0.1, _H*0.24, native.systemFont, 17)
    dependence_id.anchorX = 0
    dependence_id:setFillColor( 1, 1,1 )

    local product_id = display.newText( "Producto", _W*0.1, _H*0.34, native.systemFont, 17)
    product_id.anchorX = 0
    product_id:setFillColor( 1, 1,1 )

    local word_id = display.newText( "Palabra", _W*0.1, _H*0.44, native.systemFont, 17)
    word_id.anchorX = 0
    word_id:setFillColor( 1, 1,1 )

   

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
    sceneGroup:insert(product_id)
    sceneGroup:insert(word_id)
end

local function addLayer_advance(sceneGroup)

    
    local background = display.newImageRect( "images/slide_menu/background@2x.png", _W*0.95, _H*0.95)
    background.x = _W*0.5
    background.y = _H*0.5

    local titleTxt = display.newText( "Busqueda Avanzada", _W*0.5, _H*0.1, native.systemFont, 25 )
    titleTxt:setFillColor( 1, 1,1 )

    local dependence_id = display.newText( "Dependencia", _W*0.1, _H*0.24, native.systemFont, 17)
    dependence_id.anchorX = 0
    dependence_id:setFillColor( 1, 1,1 )

    local product_id = display.newText( "Producto", _W*0.1, _H*0.34, native.systemFont, 17)
    product_id.anchorX = 0
    product_id:setFillColor( 1, 1,1 )

    local word_id = display.newText( "Palabra", _W*0.1, _H*0.44, native.systemFont, 17)
    word_id.anchorX = 0
    word_id:setFillColor( 1, 1,1 )

   

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
    sceneGroup:insert(product_id)
    sceneGroup:insert(word_id)
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
    print("create --one search.lua")
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase
    local search_type = event.params.search_type
    print("type",params)
    if phase == "will" then 
        print("show will ---search") 
        if search_type == "advance" then   
            addLayer_advance(sceneGroup)
        elseif search_type == "dependence" then
             addLayer_dependence(sceneGroup)
        elseif search_type == "product" then
            addLayer_product(sceneGroup)
        end
         slide_menu.move = false
          
    elseif phase == "did" then
        print("show did ---search")    
    end 
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    
    if event.phase == "will" then
        print("hide will ---search")    
      
    elseif phase == "did" then
        print("hide did ---search")    
    end 
end


function scene:destroy( event )
    local sceneGroup = self.view
    print("destroy  ---search")    

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