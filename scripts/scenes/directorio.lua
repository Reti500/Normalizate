local composer = require( "composer" )
local widget = require( "widget" )
local actionbar = require ("scripts.scenes.actionbar")
local scene = composer.newScene()

local _W = display.contentWidth
local _H = display.contentHeight
local halfW = display.contentCenterX
local halfH = display.contentCenterY

local _bg =  nil
local body = nil
local body_bg = nil

local actions = {}
local names = {}
local emails = {}
local departament = {}

local contacts = nil

local font_size = 10
local ref = actionbar.getHeight() + (_H * 0.05)
local people_width = _W * 0.9

local people = {
    [1] = {
        Accion = "Consultas especificas",
        Nombre = "Lourdes M. de Cosio Gonzalez",
        Email = "lourdes.decosio@economia.gob.mx",
        Direccion = "Direccion de normalizacion interna"
    },
    [2] = {
        Accion = "Consultas sobre tramites y servicios",
        Nombre = "Lic. Rebeca Rodriguez",
        Email = "Rebeca.rodriguez@economia.gob.mx",
        Direccion = "Direccion de mejora de procesos y promocion"
    },
    [3] = {
        Accion = "Consultas oficiales (por documento o correo)",
        Nombre = "Lic. Alberto Ulises Esteban Marina",
        Email = "alberto.esteban@economia.gob.mx",
        Direccion = "Direccion general de normas"
    }
}
------------Functions.-----------------------------------------------------------------------

local function handleButtonEvent( ... )
    print("touch")
end

local function init( group )
    contacts = display.newGroup()

    text_actions_1 = display.newText( people[1]['Accion'], _W * 0.05, ref, native.systemFont, font_size )
    text_actions_1.x = text_actions_1.x + (text_actions_1.width * 0.5)
    text_actions_1.y = ref
    text_actions_2 = display.newText( people[1]['Nombre'], _W * 0.05, ref, native.systemFont, font_size )
    text_actions_2.x = text_actions_2.x + (text_actions_2.width * 0.5)
    text_actions_2.y = (text_actions_1.y + text_actions_1.height)
    text_actions_3 = display.newText( people[1]['Email'], _W * 0.05, ref, native.systemFont, font_size )
    text_actions_3.x = text_actions_3.x + (text_actions_3.width * 0.5)
    text_actions_3.y = (text_actions_2.y + text_actions_2.height)
    text_actions_4 = display.newText( people[1]['Direccion'], _W * 0.05, ref, native.systemFont, font_size )
    text_actions_4.x = text_actions_4.x + (text_actions_4.width * 0.5)
    text_actions_4.y = (text_actions_3.y + text_actions_3.height)

    local line_1 = display.newRect( contacts, _W * 0.05, (text_actions_4.y + text_actions_4.height), _W * 0.9, _H * 0.003 )
    line_1:setFillColor( 0.76862745098, 0.71764705882, 0.41960784313 )
    line_1.x = line_1.x + line_1.width*0.5
    -- line_1.y = (text_actions_4.y + text_actions_4.height)

    text_name_1 = display.newText( people[2]['Accion'], _W * 0.05, ref, native.systemFont, font_size )
    text_name_1.x = text_name_1.x + (text_name_1.width * 0.5)
    text_name_1.y = (line_1.y + text_actions_3.height)
    text_name_2 = display.newText( people[2]['Nombre'], _W * 0.05, ref, native.systemFont, font_size )
    text_name_2.x = text_name_2.x + (text_name_2.width * 0.5)
    text_name_2.y = (text_name_1.y + text_name_1.height)
    text_name_3 = display.newText( people[2]['Email'], _W * 0.05, ref, native.systemFont, font_size )
    text_name_3.x = text_name_3.x + (text_name_3.width * 0.5)
    text_name_3.y = (text_name_2.y + text_name_2.height)
    text_name_4 = display.newText( people[2]['Direccion'], _W * 0.05, ref, native.systemFont, font_size )
    text_name_4.x = text_name_4.x + (text_name_4.width * 0.5)
    text_name_4.y = (text_name_3.y + text_name_3.height)

    local line_2 = display.newRect( contacts, _W * 0.05, (text_name_4.y + text_name_4.height), _W * 0.9, _H * 0.003 )
    line_2:setFillColor( 0.76862745098, 0.71764705882, 0.41960784313 )
    line_2.x = line_2.x + line_2.width*0.5

    text_email_1 = display.newText( people[3]['Accion'], _W * 0.05, ref, native.systemFont, font_size )
    text_email_1.x = text_email_1.x + (text_email_1.width * 0.5)
    text_email_1.y = (line_2.y + text_name_4.height)
    text_email_2 = display.newText( people[3]['Nombre'], _W * 0.05, ref, native.systemFont, font_size )
    text_email_2.x = text_email_2.x + (text_email_2.width * 0.5)
    text_email_2.y = (text_email_1.y + text_email_1.height)
    text_email_3 = display.newText( people[3]['Email'], _W * 0.05, ref, native.systemFont, font_size )
    text_email_3.x = text_email_3.x + (text_email_3.width * 0.5)
    text_email_3.y = (text_email_2.y + text_email_2.height)
    text_email_4 = display.newText( people[3]['Direccion'], _W * 0.05, ref, native.systemFont, font_size )
    text_email_4.x = text_email_4.x + (text_email_4.width * 0.5)
    text_email_4.y = (text_email_3.y + text_email_3.height)

    local line_3 = display.newRect( contacts, _W * 0.05, (text_email_4.y + text_email_4.height), _W * 0.9, _H * 0.003 )
    line_3:setFillColor( 0.76862745098, 0.71764705882, 0.41960784313 )
    line_3.x = line_3.x + line_3.width*0.5

    local mail1 = widget.newButton
    {
        id = "Mail1",
        -- label = "~",
        onEvent = handleButtonEvent,
        defaultFile = "images/directorio/mensaje.png",
        width = _W*0.1,
        height = _W*0.1
    }
    mail1.x = _W*0.82
    mail1.y = ref + _H*0.02

    local mail2 = widget.newButton
    {
        id = "Mail2",
        -- label = "~",
        onEvent = handleButtonEvent,
        defaultFile = "images/directorio/mensaje.png",
        width = _W*0.1,
        height = _W*0.1
    }
    mail2.x = _W*0.82
    mail2.y = ref + _H*0.13

    local mail3 = widget.newButton
    {
        id = "Mail3",
        -- label = "~",
        onEvent = handleButtonEvent,
        defaultFile = "images/directorio/mensaje.png",
        width = _W*0.1,
        height = _W*0.1
    }
    mail3.x = _W*0.82
    mail3.y = ref + _H*0.24

    contacts:insert(text_actions_1)
    contacts:insert(text_actions_2)
    contacts:insert(text_actions_3)
    contacts:insert(text_actions_4)

    contacts:insert(text_name_1)
    contacts:insert(text_name_2)
    contacts:insert(text_name_3)
    contacts:insert(text_name_4)

    contacts:insert(text_email_1)
    contacts:insert(text_email_2)
    contacts:insert(text_email_3)
    contacts:insert(text_email_4)

    group:insert( contacts )
end

--------------------------------End Functions-------------------------------------------------------------------

-----------------------------------Scenes Functions---------------------------------
function scene:create( event )
    local sceneGroup = self.view

    body = display.newGroup()
    actionbar.create(sceneGroup)
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
        _bg = display.newRect( sceneGroup, _W*0.5, _H*0.5, _W, _H )
        _bg:setFillColor( 0.85882353 )
        _bg:toBack()
        body_bg = display.newRect( body, _W*0.5, _H*0.5, _W, _H )
        body_bg:setFillColor( 0.26666667 )
        body.y = actionbar.getHeight()

        sceneGroup:insert( body )

        init( sceneGroup )
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