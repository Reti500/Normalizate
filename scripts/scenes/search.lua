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
local canTouch = true
local up,down

------------Functions.-----------------------------------------------------------------------

local function close(event)
    print("hola")
    if canTouch then
        canTouch = false
        slide_menu.move = true
        composer.hideOverlay( "fade", 400 )
    end
   
end

local function addLayer_dependence(sceneGroup)

    local titleTxt = display.newText( "Búsqueda Por Dependencia", _W*0.5, _H*0.25,"Quicksand-Bold", 20 )
    titleTxt:setFillColor(1,1,1)   

    local product_id = display.newText( "Lista", _W*0.1, _H*0.35, "Quicksand-Bold", 17)
    product_id.anchorX = 0
    product_id:setFillColor( 1, 1,1 )

    local word_id = display.newText( "Búsqueda", _W*0.1, _H*0.5, "Quicksand-Bold", 17)
    word_id.anchorX = 0
    word_id:setFillColor( 1, 1,1 )
   
  
    sceneGroup:insert(titleTxt)

    sceneGroup:insert(product_id)
    sceneGroup:insert(word_id)
end

local function addLayer_advance(sceneGroup)

  
    local titleTxt = display.newText( "Búsqueda Avanzada", _W*0.5, _H*0.25, "Quicksand-Bold", 20 )
    titleTxt:setFillColor( 1, 1,1 )

    local dependence_id = display.newText( "Dependencia", _W*0.1, _H*0.35, "Quicksand-Bold", 17 )
    dependence_id.anchorX = 0
    dependence_id:setFillColor( 1, 1,1 )

    local product_id = display.newText( "Producto", _W*0.1, _H*0.45, "Quicksand-Bold", 17 )
    product_id.anchorX = 0
    product_id:setFillColor( 1, 1,1 )

    local word_id = display.newText( "Palabra", _W*0.1, _H*0.55, "Quicksand-Bold", 17 )
    word_id.anchorX = 0
    word_id:setFillColor( 1, 1,1 )


    sceneGroup:insert(titleTxt)
    sceneGroup:insert(dependence_id)
    sceneGroup:insert(product_id)
    sceneGroup:insert(word_id)
end

local function addLayer_product(sceneGroup)
    
    local titleTxt = display.newText( "Busqueda Por Producto", _W*0.5, _H*0.25, "Quicksand-Bold", 20 )
    titleTxt:setFillColor( 1, 1,1)

    local dependence_id = display.newText( "Lista de Productos", _W*0.1, _H*0.34,"Quicksand-Bold", 17)
    dependence_id.anchorX = 0
    dependence_id:setFillColor( 1, 1,1 )
   
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
        canTouch = true
        up = display.newRect( _W*0.5, _H*0.08, _W, _H*0.25)  
        up:setFillColor(0,0,0)
        up.alpha = 0.01
        up:addEventListener("touch",close)

        down = display.newRect( _W*0.5, _H*0.9, _W, _H*0.2)  
        down:setFillColor(0,0,0)
        down.alpha = 0.01
        down:addEventListener("touch",close)

        local back = display.newRect( _W*0.5, _H*0.5, _W, _H)  
        back:setFillColor(0.5)
        back.alpha = 0.8


        local background = display.newRoundedRect( _W*0.5, _H*0.5, _W*0.9, _H*0.6,12)  
        background:setFillColor(0.2666666667)  

         searchButton = widget.newButton
          {
        id = "search",
        defaultFile = "images/init/buscar.png",
        overFile = "images/init/buscar_push.png",
        onEvent = handleButtonEvent,
        width = _W*0.6,
        height = _W*0.1
         }
         searchButton.x = _W*0.5
         searchButton.y = _H*0.7 

        sceneGroup:insert(up)
        sceneGroup:insert(down)
        sceneGroup:insert(back)
        sceneGroup:insert(background)
        sceneGroup:insert(searchButton)

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
    up:removeEventListener("touch",close)   
    down:removeEventListener("touch",close)   

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