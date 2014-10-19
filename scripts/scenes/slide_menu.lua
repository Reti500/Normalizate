local slide_menu = {}
local composer = require( "composer" )
local widget = require( "widget" )

local _W = display.contentWidth
local _H = display.contentHeight
local halfW = display.contentCenterX
local halfH = display.contentCenterY
local backgroundMenu 
local touchX = {}
local i = 1
local dir = false ---izquierda
local range = _W*0.10
local posInit = _W*0.75 -- _W*1.25
local isOpen = false
 local group = display.newGroup()
------------Functions.-----------------------------------------------------------------------
local listener1 = function( obj )
   --print( "Cerro")
end

local function moveListener1(event)
   if event.phase == "moved" then
      
        local dx = math.abs( event.x - event.xStart ) 

        i = i + 1
        touchX[1] = event.xStart
        touchX[i] = event.x

        if touchX[i-1] < touchX[i] then            
            print("----->derecha") 
            dir = true
           -- backgroundMenu.x  = backgroundMenu.x+4.5
            group.x  = group.x+4.5
            
        elseif touchX[i-1] > touchX[i] then            
            print("<-----izquierda")
            dir = false
            if backgroundMenu.x < _W*0.75 then
            else
                --backgroundMenu.x  = backgroundMenu.x-4.5
                print("putos.."..group.x)
                group.x  = group.x-4.5
            end          
        end
        
    elseif event.phase == "ended" then
        i = 1
        if math.abs(event.xStart-event.x) > range and dir then
            print("cerrar")
            listenersButtons(true)
            isOpen = false
            slide_menu.close()
        elseif math.abs(event.xStart-event.x) > range and  dir == false then
            print("abrir")
            listenersButtons(false)
            isOpen = true
            slide_menu.open()
        else 
            print("normal")
            if backgroundMenu.x > _W then--cerrar
                isOpen = false   
                slide_menu.close()
            -- elseif (event.xStart == event.x and event.target.id == "close") and isOpen then
            --     print("puto")
            --     isOpen = false
            --     slide_menu.close()
            elseif backgroundMenu.x < _W  then
                isOpen = true 
                slide_menu.open()
            end
        end        
    end
end
local function moveListener(event)
   if event.phase == "moved" then
      
        local dx = math.abs( event.x - event.xStart ) 

        i = i + 1
        touchX[1] = event.xStart
        touchX[i] = event.x

        if touchX[i-1] < touchX[i] then            
            print("----->derecha") 
            dir = true
           -- backgroundMenu.x  = backgroundMenu.x+4.5
            group.x  = group.x+4.5
            
        elseif touchX[i-1] > touchX[i] then            
            print("<-----izquierda")
            dir = false
            print(group.x,_W*0.5)
            if group.x <= 0 then

            else
                --backgroundMenu.x  = backgroundMenu.x-4.5
                print("putos.."..group.x)
                group.x  = group.x-4.5
            end          
        end
        
    elseif event.phase == "ended" then
        i = 1
        if math.abs(event.xStart-event.x) > range and dir then
            print("cerrar")
            listenersButtons(true)
            isOpen = false
            slide_menu.close()
        elseif math.abs(event.xStart-event.x) > range and  dir == false then
            print("abrir")
            listenersButtons(false)
            isOpen = true
            slide_menu.open()
        else 
            print("normal")
            if group.x > _W*0.25 then--cerrar
                isOpen = false   
                slide_menu.close()
            -- elseif (event.xStart == event.x and event.target.id == "close") and isOpen then
            --     print("puto")
            --     isOpen = false
            --     slide_menu.close()
            elseif group.x > 0  then
                isOpen = true 
                slide_menu.open()
            end
        end        
    end
end

slide_menu.create = function (sceneGroup)
   
    
    local myRectangle = display.newRect( _W*0.5, _H*0.5, _W, _H )  
    myRectangle:setFillColor( 0.5 )
    myRectangle.alpha = 0.01  

    -- local close = display.newRect( _W*0.25, _H*0.5, _W*0.5, _H )  
    -- close:setFillColor( 0.5 )
    -- close.alpha = 1 
    -- close.id = "close"
    -- close:addEventListener( "touch", moveListener )   

    backgroundMenu = display.newImageRect( "images/slide_menu/background@2x.png", _W*0.5, _H)
    backgroundMenu.x = posInit
    backgroundMenu.y = _H*0.6 
    backgroundMenu.anchorX = 0.5
    backgroundMenu:toFront()
    myRectangle:addEventListener( "touch", moveListener )

    chatButton = widget.newButton
    {
        id = "chatButton",
        label = "Chat",
        onEvent = handleButtonEvent,
        width = _W*0.35,
        height = _W*0.15
    }
    chatButton.x = posInit
    chatButton.y = _H*0.4   
    
    group:insert( backgroundMenu )
    group:insert( chatButton )

    sceneGroup:insert(group)
end
slide_menu.open = function()
   -- transition.to( backgroundMenu, { time=200, x=_W*0.75, onComplete=listener1 } )
    transition.to( group, { time=200, x=0, onComplete=listener1 } )
end

slide_menu.close = function()
   -- transition.to( backgroundMenu, { time=200, x=_W*1.3, onComplete=listener1 } )
    transition.to( group, { time=200, x=_W*0.5, onComplete=listener1 } )
end
--------------------------------End Functions-------------------------------------------------------------------



--------------------------------------------------------------------------------
return slide_menu