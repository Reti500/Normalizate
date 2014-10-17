local facebook = require( "facebook" )
local json = require( "json" )
local widget = require( "widget" )
local composer = require( "composer" )
local _jsonStorage = require("scripts.libs.jsonStorage")
local _KEY = require("scripts.keys")
local analytics = require "analytics"
--analytics.init( _KEY.FLURRY_API_KEY )
	
local _facebook = {}
_facebook.fbCommand = nil
_facebook.GET_USER_INFO = "getInfo" 

local function doFacebookLogin()
 
  local function facebookListener( event )

    if event.type == "session" then 

		if event.phase == "login" then   
        
			composer.userData.sessionToken = event.token
			composer.userData.sessionExpiry = event.expiration 
			_jsonStorage.saveData(composer.userData.sessionToken,"sessionToken")
			_jsonStorage.saveData(composer.userData.sessionExpiry,"sessionExpiry")

			if composer.userData.sessionToken then
				facebook.request( "me" )
			end
		end

		if _facebook.fbCommand == _facebook.GET_USER_INFO then
			facebook.request( "me")
			print("Pidiendo informacion")		
		end

    elseif event.type == "request" then

		if not event.isError then
			local response = json.decode( event.response )          
			local response2 = json.encode( response )  --solo visualizacion
			print("json encode",response2)

			if response.id then
				_jsonStorage.saveData(event.response,"userdata")
				composer.userData.name = _jsonStorage.openData("first_name","userdata")
				composer.userData.lastName  = _jsonStorage.openData("last_name","userdata")
				composer.userData.id =  _jsonStorage.openData("id","userdata")
				if var == "login" then
					composer.userData.email = _jsonStorage.openData("email","userdata")
				end
				print("userId: "..composer.userData.id.." , ".."name: "..composer.userData.name.." , ".."email: "..composer.userData.email)		
				-----------------------------------------------------------------------------------------------------------Flurry FBAuthGranted
				--analytics.logEvent("FBAuthGranted")
			end
			
			local function networkListener( event )
				if event.isError then
					native.showAlert( "Network Error", "Download of profile picture failed, please check your network connection", { "OK" } )
				else
					print( "Profile picture downloaded successfully" )
				end
			  	print("is Done Face")
				composer.isFacebook = true
			end

			-- Bajar imagen de perfil
			local path = system.pathForFile( composer.userData.name .. composer.userData.lastName .. composer.userData.id  .. ".png", system.DocumentsDirectory )
			local picDownloaded = io.open( path )

			if not picDownloaded then
				network.download( "http://graph.facebook.com/" .. composer.userData.id  .. "/picture", "GET", networkListener, composer.userData.name .. composer.userData.lastName .. composer.userData.id  .. ".png", system.DocumentsDirectory )
			else			
			    print("is Done Face")
				composer.isFacebook = true
			end
		else
		  print("error",event.isError)
		end
    end
  end 
  if var == "login" then
  	facebook.login(_KEY.FACEBOOK_ID,facebookListener, { "publish_actions, email" })
  elseif var == "getInfo" then
  	facebook.login(_KEY.FACEBOOK_ID,facebookListener) 
  end
end

_facebook.loginUser = function(event)
	facebook.fbCommand = _facebook.GET_USER_INFO
	var = "login"
	doFacebookLogin()
end

_facebook.getUser = function(event)
	facebook.fbCommand = _facebook.GET_USER_INFO
	var = "userInfo"
	doFacebookLogin()
end

return _facebook