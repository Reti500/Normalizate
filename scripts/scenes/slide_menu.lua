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
local range = _W*0.07
local posInit = _W*1.25 -- _W*1.25
local isOpen = false
local group = display.newGroup()
local offset = _W *0.15
local myRectangle = nil
local back
slide_menu.move = true
------------Functions.-----------------------------------------------------------------------
local listener = function( obj )
   --print( "Cerro")
   transition.to( back, { time=200, alpha = 0.43 } )
end

local listener1 = function( obj )
   --print( "Cerro")
   transition.to( back, { time=200, alpha = 0 } )
end

local function openMenu( event )
    if isOpen then
        listenersButtons(true)
        isOpen = false
        slide_menu.close()
    else
        listenersButtons(false)
        isOpen = true
        slide_menu.open()
    end
end

local function moveListener(event)
   if slide_menu.move then
       if event.phase == "moved" then
          
            local dx = math.abs( event.x - event.xStart ) 

            i = i + 1
            touchX[1] = event.xStart
            touchX[i] = event.x

            if touchX[i-1] < touchX[i] then            
                print("----->derecha") 
                dir = true         
                group.x  = group.x+4.5
                
            elseif touchX[i-1] > touchX[i] then            
                print("<-----izquierda")
                dir = false
                print(group.x,_W*0.5)
                if group.x <= -_W*0.5 then

                else
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
                if group.x > -_W*0.25 then--cerrar
                    isOpen = false   
                    slide_menu.close()
                elseif (event.xStart == event.x and event.target.id == "close") and isOpen then
                    print("puto")
                    isOpen = false
                    slide_menu.close()
                elseif group.x > -_W*0.5  then
                    isOpen = true 
                    slide_menu.open()
                end
            end        
        end
    end
end

slide_menu.create = function (sceneGroup)
    

    myRectangle = display.newRect( _W*0.5, _H*0.5, _W, _H )  
    myRectangle:setFillColor( 0.5 )
    myRectangle.alpha = 0.01  
    myRectangle:addEventListener("touch",moveListener)

    -- local close = display.newRect( _W*0.75, _H*0.5, _W*0.5, _H )  
    -- close:setFillColor( 0.5 )
    -- close.alpha = 1 
    -- close.id = "close"
   -- close:addEventListener( "touch", moveListener )  

    back = display.newRect( _W*0.75, _H*0.5, _W*2, _H )  
    back:setFillColor( 0.2 )
    back.alpha = 0
    
    backgroundMenu = display.newRect( posInit,_H*0.6, _W*0.5, _H)
    backgroundMenu:setFillColor(0.85882353)

    local line = display.newLine( _W, 0, _W, _H  )
    line:setStrokeColor(0.7019, 0.101, 0.3450)
    line.strokeWidth = 4
    --backgroundMenu.anchorX = 0.5
    --backgroundMenu:toFront()    

    -- tab = widget.newButton
    -- {
    --     id = "tab",
    --     label = "TAB",
    --     onRelease = openMenu,
    --     width = _W*0.35,
    --     height = _W*0.15
    -- }
    -- tab.x = _W*0.95
    -- tab.y = _H*0.95

    imageProfile = display.newImageRect( "Icon@2x.png", backgroundMenu.width, _H*0.27)
    imageProfile.x = posInit
    imageProfile.y = _H*0.23 
    imageProfile.anchorX = 0.5
    imageProfile:toFront()

    chatButton = widget.newButton
    {
        id = "chatButton",
        onEvent = handleButtonEvent,
        emboss = false,
        shape="rect",
        width = backgroundMenu.width-2.5,
        height =  _W*0.13,
        fillColor = { default={ 0.85882353,0.85882353,0.85882353, 0.5 }, over={ 0.85882353,0.85882353,0.85882353, 0.5 } },
        strokeColor = { default={ 0.7019, 0.101, 0.3450, 1 }, over={ 0.8, 0.8, 1, 1 } },
        strokeWidth = 2.5
    }
    chatButton.x = posInit
    chatButton.y = _H*0.4 

    chatIcon = display.newImageRect( "images/slide_menu/chat.png", _W*0.1, _W*0.08)
    chatIcon.x = posInit - offset
    chatIcon.y =  chatButton.y

    foroButton = widget.newButton
    {
        id = "foroButton",
       onEvent = handleButtonEvent,
        emboss = false,
        shape="rect",
        width = backgroundMenu.width-2.5,
        height =  _W*0.13,
        fillColor = { default={ 0.85882353,0.85882353,0.85882353, 0.5 }, over={ 0.85882353,0.85882353,0.85882353, 0.5 } },
        strokeColor = { default={ 0.7019, 0.101, 0.3450, 1 }, over={ 0.8, 0.8, 1, 1 } },
        strokeWidth = 2.5
    }
    foroButton.x = posInit
    foroButton.y = chatButton.y + foroButton.height 


    foroIcon = display.newImageRect( "images/slide_menu/foro.png", _W*0.1, _W*0.08)
    foroIcon.x = posInit - offset
    foroIcon.y = foroButton.y

    favoritesButton = widget.newButton
    {
        id = "favoritesButton",
       onEvent = handleButtonEvent,
        emboss = false,
        shape="rect",
        width = backgroundMenu.width-2.5,
        height =  _W*0.13,
        fillColor = { default={ 0.85882353,0.85882353,0.85882353, 0.5 }, over={ 0.85882353,0.85882353,0.85882353, 0.5 } },
        strokeColor = { default={ 0.7019, 0.101, 0.3450, 1 }, over={ 0.8, 0.8, 1, 1 } },
        strokeWidth = 2.5
    }
    favoritesButton.x = posInit 
    favoritesButton.y = foroButton.y + favoritesButton.height


    favoriteIcon = display.newImageRect( "images/slide_menu/favorito.png", _W*0.08, _W*0.08)
    favoriteIcon.x = posInit - offset
    favoriteIcon.y = favoritesButton.y


    
    agendaButton = widget.newButton
    {
        id = "agendaButton",
       onEvent = handleButtonEvent,
        emboss = false,
        shape="rect",
        width = backgroundMenu.width-2.5,
        height =  _W*0.13,
        fillColor = { default={ 0.85882353,0.85882353,0.85882353, 0.5 }, over={ 0.85882353,0.85882353,0.85882353, 0.5 } },
        strokeColor = { default={ 0.7019, 0.101, 0.3450, 1 }, over={ 0.8, 0.8, 1, 1 } },
        strokeWidth = 2.5
    }
    agendaButton.x = posInit
    agendaButton.y = favoritesButton.y + agendaButton.height  

    agendaIcon = display.newImageRect( "images/slide_menu/agenda.png", _W*0.1, _W*0.08)
    agendaIcon.x = posInit - offset
    agendaIcon.y = agendaButton.y  


    settingsButton = widget.newButton
    {
        id = "settingsButton",
       onEvent = handleButtonEvent,
        emboss = false,
        shape="rect",
        width = backgroundMenu.width-2.5,
        height =  _W*0.13,
        fillColor = { default={ 0.85882353,0.85882353,0.85882353, 0.5 }, over={ 0.85882353,0.85882353,0.85882353, 0.5 } },
        strokeColor = { default={ 0.7019, 0.101, 0.3450, 1 }, over={ 0.8, 0.8, 1, 1 } },
        strokeWidth = 2.5
    }
    settingsButton.x = posInit
    settingsButton.y = _H - (settingsButton.height*0.5)

    settingsIcon = display.newImageRect( "images/slide_menu/ajustes.png", _W*0.08, _W*0.08)
    settingsIcon.x = posInit - offset
    settingsIcon.y = settingsButton.y

    local chatTxt = display.newText( "Chat", chatButton.x  - (offset*0.5) ,chatButton.y, "Quicksand-Regular", 18 )
    chatTxt.anchorX = 0
    chatTxt:setFillColor(0,0,0)

    local foroTxt = display.newText( "Foros", foroButton.x  - (offset*0.5),foroButton.y, "Quicksand-Regular", 18 )
    foroTxt.anchorX = 0
    foroTxt:setFillColor(0,0,0)  

    local favoritesTxt = display.newText( "Favoritos", favoritesButton.x - (offset*0.5) ,favoritesButton.y, "Quicksand-Regular", 18 )
    favoritesTxt.anchorX = 0
    favoritesTxt:setFillColor(0,0,0)  
    
    local agendaTxt = display.newText( "Agenda", agendaButton.x - (offset*0.5) ,agendaButton.y, "Quicksand-Regular", 18 )
    agendaTxt.anchorX = 0
    agendaTxt:setFillColor(0,0,0) 

    local settingsTxt = display.newText( "Ajustes", settingsButton.x - (offset*0.5) ,settingsButton.y, "Quicksand-Regular", 18 )
    settingsTxt.anchorX = 0
    settingsTxt:setFillColor(0,0,0)  
    
    group:insert( back )    
    group:insert( backgroundMenu )   
    --group:insert( tab )   
    --group:insert( close )
    group:insert( imageProfile )
   
    group:insert( chatButton )
    group:insert( chatIcon )    
    group:insert( foroButton )
    group:insert( foroIcon )
    group:insert( favoritesButton )
    group:insert( favoriteIcon )
    group:insert( agendaButton )
    group:insert( agendaIcon )
    group:insert( settingsButton )
    group:insert( settingsIcon )
    group:insert(chatTxt)
    group:insert(foroTxt)
    group:insert(favoritesTxt)
    group:insert(agendaTxt)
    group:insert(settingsTxt)
     group:insert( line )

    --sceneGroup:insert(group)
end
slide_menu.open = function()
   -- transition.to( backgroundMenu, { time=200, x=_W*0.75, onComplete=listener1 } )
    transition.to( group, { time=200, x=-_W*0.5, onComplete=listener } )
end

slide_menu.close = function()
   -- transition.to( backgroundMenu, { time=200, x=_W*1.3, onComplete=listener1 } )
    transition.to( group, { time=200, x=0, onComplete=listener1 } )
end

--------------------------------End Functions-------------------------------------------------------------------



--------------------------------------------------------------------------------
return slide_menu