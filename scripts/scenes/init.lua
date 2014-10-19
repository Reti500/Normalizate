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


local function onKeyEvent( event )
-- Print which key was pressed down/up to the log.
    local message = "Key '" .. event.keyName .. "' was pressed " .. event.phase
    --print( message )
    -- If the "back" key was pressed on Android, then prevent it from backing out of your app.
    if (event.keyName == "back") and (system.getInfo("platformName") == "Android") and (event.phase == "up") then                           
        local function onComplete( event )
            if "clicked" == event.action then
                local i = event.index
                if 1 == i then
                -- Do nothing; dialog will simply dismiss
                elseif 2 == i then
                  native.requestExit()
                end
            end
            
        end
        local alert = native.showAlert( "Normalizate", "Desea salir de la Applicación? ", {"Cancelar", "Salir" }, onComplete )
        return true
    else
        return false    
    end
end

 -- Function to handle button events
local function handleButtonEvent( event )
    if  "advancedButton" == event.target.id and event.phase == "began" then
        print("mostrando")
         backBut_avanzado.alpha = 1
    elseif  "dependenceButton" == event.target.id and event.phase == "began" then
        print("mostrando")
         backBut_dependencia.alpha = 1
    elseif  "productButton" == event.target.id and event.phase == "began" then
        print("mostrando")
         backBut_producto.alpha = 1
    else
        backBut_avanzado.alpha = 0
        backBut_dependencia.alpha = 0
        backBut_producto.alpha = 0
    end
    if  "advancedButton" == event.target.id  and event.phase == "ended" then
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
    elseif  "normButton" == event.target.id and event.phase == "ended" then
        if composer.data.normIsActive == false then
            --poner azul
            norm.alpha = 1
            composer.data.normIsActive = true
        else 
            --poner  normal
            norm.alpha = 0
            composer.data.normIsActive = false
        end 
    elseif  "normMXButton" == event.target.id and event.phase == "ended" then
        if composer.data.normMXIsActive == false then
            --poner azul
            normMX.alpha = 1
            composer.data.normMXIsActive = true
        else 
            --poner  normal
            normMX.alpha = 0
            composer.data.normMXIsActive = false
        end 
        --composer.showOverlay( "scripts.scenes.one_result", options )
    elseif  "dependenceButton" == event.target.id and event.phase == "ended"  then
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
    elseif  "productButton" == event.target.id  and event.phase == "ended" then
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
        composer.gotoScene( "scripts.scenes.directorio", options )       
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

    local background = display.newRect( _W*0.5, _H*0.5, _W, _H )  
    background:setFillColor(0.85882353)

    logo = display.newImageRect( "images/init/economia.png", _W*0.5, _H*0.1)
    logo.x = _W*0.5
    logo.y = _H*0.17

    local titleTxt = display.newText( "Búsqueda por:", _W*0.5, _H*0.25, "Quicksand-Light", 13 )
    titleTxt:setFillColor(0,0,0)

    normButton = widget.newButton
    {
        id = "normButton",
        defaultFile = "images/init/nom.png",
        overFile = "images/init/nom_push.png",
        onRelease = handleButtonEvent,
        width = _W*0.25,
        height = _W*0.32
    }
    normButton.x = _W*0.25
    normButton.y = _H*0.15 +_W*0.3

    norm = display.newImageRect( "images/init/nom_push.png", _W*0.25, _W*0.32)
    norm.x = normButton.x
    norm.y = normButton.y
    if composer.data.normIsActive then
        norm.alpha = 1
    else
        norm.alpha = 0
    end

    normMXButton = widget.newButton
    {
        id = "normMXButton",
        defaultFile = "images/init/nmx.png",
        overFile = "images/init/nmx_push.png",
        onRelease = handleButtonEvent,
        width = _W*0.25,
        height = _W*0.32
    }
    normMXButton.x = _W*0.75
    normMXButton.y = _H*0.15+_W*0.3

    normMX = display.newImageRect( "images/init/nmx_push.png", _W*0.25, _W*0.32)
    normMX.x = normMXButton.x
    normMX.y = normMXButton.y

    if composer.data.normMXIsActive then
        normMX.alpha = 1
    else
        normMX.alpha = 0
    end

    normMX.alpha = 0

    
    backBut = display.newImageRect( "images/init/rueda.png", _W*0.53, _W*0.53)
    backBut.x = _W*0.5
    backBut.y = _H*0.63

    backBut_avanzado = display.newImageRect( "images/init/rueda_avanzado.png", _W*0.53, _W*0.53)
    backBut_avanzado.x = _W*0.5
    backBut_avanzado.y = _H*0.63
    backBut_avanzado.alpha = 0

    backBut_dependencia = display.newImageRect( "images/init/rueda_dependencia.png", _W*0.53, _W*0.53)
    backBut_dependencia.x = _W*0.5
    backBut_dependencia.y = _H*0.63
    backBut_dependencia.alpha = 0

    backBut_producto = display.newImageRect( "images/init/rueda_producto.png", _W*0.53, _W*0.53)
    backBut_producto.x = _W*0.5
    backBut_producto.y = _H*0.63
    backBut_producto.alpha = 0

    productButton = widget.newButton
    {
        id = "productButton",
        defaultFile = "images/init/producto_icon.png",
        overFile = "images/init/producto_icon.png",
        onEvent = handleButtonEvent,
        width = _W*0.21,
        height = _W*0.16
    }
    productButton.anchorX = 1
    productButton.x = backBut.x *0.95
    productButton.y = _H*0.58

    advancedButton = widget.newButton
    {
        id = "advancedButton",
        defaultFile = "images/init/avanzado_icon.png",
        overFile = "images/init/avanzado_icon.png",
        onEvent = handleButtonEvent,
        width = _W*0.21,
        height = _W*0.16
    }
    advancedButton.x = backBut.x *1.25
    advancedButton.y =_H*0.58
   -- advancedButton:setFillColor(1,0,0)


    dependenceButton = widget.newButton
    {
        id = "dependenceButton",
       defaultFile = "images/init/dependencia_icon.png",
        overFile = "images/init/dependencia_icon.png",
        onEvent = handleButtonEvent,
        width = _W*0.28,
        height = _W*0.14
    }
    dependenceButton.x = _W*0.5
    dependenceButton.y = _H*0.7


    directoryButton = widget.newButton
    {
        id = "directoryButton",
        onRelease = handleButtonEvent,
        defaultFile = "images/init/directorio.png",
        overFile = "images/init/directorio.png",
        width = _W*0.75,
        height = _W*0.15
    }
    directoryButton.x = _W*0.5
    directoryButton.y = _H*0.9

    sceneGroup:insert(background)
    sceneGroup:insert(logo)
    sceneGroup:insert(titleTxt)  
    sceneGroup:insert(backBut)  
    sceneGroup:insert(backBut_avanzado)
    sceneGroup:insert(backBut_dependencia)
    sceneGroup:insert(backBut_producto)
    
    sceneGroup:insert(normButton)
    sceneGroup:insert(norm)
    sceneGroup:insert(normMXButton)
    sceneGroup:insert(normMX)
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
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then 
        print("show will init.lua")
        addLayer(sceneGroup) 
        slide_menu.create(sceneGroup)
        actionbar.create(sceneGroup)
        Runtime:addEventListener( "key", onKeyEvent )
    elseif phase == "did" then
        print("show did init.lua")
    end 
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    
    if event.phase == "will" then
        print("hide will init.lua")
        Runtime:removeEventListener( "key", onKeyEvent )    
    elseif phase == "did" then
        print("hide did init.lua")
    end 
end

function scene:destroy( event )
    local sceneGroup = self.view
    print("destroy init.lua")
    Runtime:removeEventListener( "key", onKeyEvent )    

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