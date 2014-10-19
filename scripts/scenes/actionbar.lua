local composer = require( "composer" )
local widget = require( "widget" )

local actionbar = {}
local objects = {}

local _W = display.contentWidth
local _H = display.contentHeight
local halfW = display.contentCenterX
local halfH = display.contentCenterY
local path = "images/action_bar/"
local backgroundMenu = nil
local actionbarGroup = nil
local max_tam = _H*0.08

local background = nil
local backButton = nil
local searchField = nil
local searchButton = nil
local notificationButton = nil
local menuButton = nil

actionbar.getHeight = function()
    return max_tam
end

local function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
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

local function createBackGround( group )
    background = display.newImageRect( path.."barra.png", _W, max_tam )
    background.x = background.width*0.5
    background.y = background.height*0.5
    objects[#objects+1] = background
end

local function createBackButton( group )
   backButton = widget.newButton
    {
        id = "backButton",
        -- label = "<-",
        onEvent = handleButtonEvent,
        defaultFile = path.."casa.png"
        -- width = _W*0.1,
        -- height = max_tam-_H*0.2
    }

    backButton.width = _W*0.1
    backButton.height = max_tam - (_H*0.03)
    backButton.x = (_W*0.02) + backButton.width*0.5
    backButton.y = backButton.height*0.5 + _H*0.01

    objects[#objects+1] = backButton
end

local function createFindField( group )
    searchField = native.newTextField( _W*0.14, _H*0.01, _W*0.5, max_tam - (_H*0.03) )
    searchField.x = searchField.x + searchField.width*0.5
    searchField.y = searchField.y + searchField.height*0.5
    searchField:addEventListener( "userInput", textListener )
    searchField.placeholder = "Buscar"
    searchField:setReturnKey("search")

    objects[#objects+1] = searchField
end

local function createFindButton( group )
    searchButton = widget.newButton
    {
        id = "searchButton",
        -- label = "B",
        defaultFile = path.."lupa.png",
        onEvent = handleButtonEvent,
        width = _W*0.1,
        height = max_tam - (_H*0.02)
    }

    searchButton.width = _W*0.1
    searchButton.height = max_tam - (_H*0.03)
    searchButton.x = (_W*0.64) + searchButton.width*0.5
    searchButton.y = _H*0.01 + searchButton.height*0.5

    objects[#objects+1] = searchButton
end

local function createNotificationButton( group )
   notificationButton = widget.newButton
    {
        id = "notifications",
        -- label = "N",
        onEvent = handleButtonEvent,
        defaultFile = path.."bandera.png"
        -- width = _W*0.1,
        -- height = max_tam-_H*0.2
    }

    notificationButton.width = _W*0.08
    notificationButton.height = max_tam - (_H*0.03)
    notificationButton.x = (_W*0.77) + notificationButton.width*0.5
    notificationButton.y = notificationButton.height*0.2

    objects[#objects+1] = notificationButton
end

local function createMenuButton( group )
   menuButton = widget.newButton
    {
        id = "manuButton",
        -- label = "~",
        onEvent = handleButtonEvent,
        defaultFile = path.."menu.png",
        width = _W*0.1,
        height = max_tam - (_H*0.02)
    }

    menuButton.width = _W*0.04
    menuButton.height = _H*0.02 --max_tam - (_H*0.04)
    menuButton.x = (_W*0.9) + menuButton.width*0.5
    menuButton.y = menuButton.height*0.5

    objects[#objects+1] = menuButton
end

actionbar.create = function (group, components)
    actionbarGroup = display.newGroup()
    local buttons = {
        [1] = createBackButton, 
        [2] = createFindField,
        [3] = createFindButton,
        [4] = createNotificationButton,
        [5] = createMenuButton
    }

    components = components or {true, true, true, true, true}

    createBackGround( actionbarGroup )

    for i=1, #components do
        if components[i] == true then
            buttons[i]()
        end
    end

    for i=1, #objects do
        actionbarGroup:insert( objects[i] )
    end

    -- actionbarGroup.x, actionbarGroup.y = 0, 0

    -- actionbarGroup:toBack()

    group:insert( actionbarGroup )
end
--------------------------------End Functions-------------------------------------------------------------------



--------------------------------------------------------------------------------
return actionbar