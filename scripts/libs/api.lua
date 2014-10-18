local _jsonStorage = require "scripts.libs.jsonStorage" 
local composer = require "composer" 
local JSON = require("json")
local _KEY = require "scripts.keys"
local crypto = require "crypto"

local API = {}

API.URL = _KEY.API_URL

API.ACTION 	= ""
API.LOGIN 	= "LOGIN" 
API.LOGOUT 	= "LOGOUT"

API.isLogin = false
API.isLogout = nil

local LOGIN = "/login"
local LOGOUT = "/logout"

local newUrl = ""

local mapKeys = {}
local mapVals = {}
local json = ""
---------------------------------------------------------------------------------------------
local function networkListener( event )

	if ( event.isError ) then
    	print( "Network error!----API")

  	elseif ( event.phase == "ended" ) then   	
  
  		json = event.response 
  
  		if json == '"null"' then
			print("Error ---API")
			local destDir = system.DocumentsDirectory
			local resutls, reason = os.remove(system.pathForFile("userdata.txt",destDir))

			if resutls then
				print("userdata removed-----API")
				composer.isFacebook = false
				destDir = system.DocumentsDirectory
				resutls, reason = os.remove(system.pathForFile("token.txt",destDir))

				if resutls then
					print("token removed---API")
				else
					print("does no exist ----API",reason)
				end
			else
				print("does not exist ----API",reason)
			end
			composer.removeScene ("loading")
			composer.gotoScene("scripts.wildcard")    
    	else
	  		jsonTable = JSON.decode(json) 
----------------------LOGIN-------------------------------------------------
			if API.ACTION == API.LOGIN then

				print("Login end ----API")		
				_jsonStorage.saveData(event.response,"user")
				_jsonStorage.saveData(event.response,"token")
				composer.userData.idAPI = tonumber(_jsonStorage.openData("id","user"))
				composer.lives = jsonTable["lives"]	
				composer.userData.token = _jsonStorage.openData("token","token")
				API.isLogin = true
----------------------GET USER-------------------------------------------------
			end
    	end  
  	end
end

local function paramsPOST(keys,vals)
	local post_data = ""

	for i=1,#keys do
		post_data = post_data..keys[i].."="..vals[i].."&"
	end
    return post_data
end

local function insertKeysAndVals(request)
	mapKeys = {}
	mapVals = {}

	if request == "LOGIN" then
		local isToken = _jsonStorage.doesFileExist( "token.txt", system.DocumentsDirectory )

		if isToken then
			print("Si token ----API", isToken)
			table.insert(mapKeys,"token")
			table.insert(mapVals,_jsonStorage.openData("token","token"))
		else			
			print("No token ----API", isToken)
			table.insert(mapKeys,"auth_query")
			table.insert(mapKeys,"facebook_id")
			table.insert(mapKeys,"email")
			table.insert(mapKeys,"name")

			table.insert(mapVals,_jsonStorage.openData2("sessionToken"))
			table.insert(mapVals,_jsonStorage.openData("id","userdata"))
			table.insert(mapVals,_jsonStorage.openData("email","userdata"))
			table.insert(mapVals,_jsonStorage.openData("first_name","userdata").." ".. _jsonStorage.openData("last_name","userdata"))
		end
	end
end

API.requestPOST = function(request)
	if request == "LOGIN" then
		newUrl = API.URL..LOGIN
		API.ACTION = API.LOGIN    
		insertKeysAndVals(request)	
		params.body = paramsPOST(mapKeys,mapVals)
	end

  local json = network.request( newUrl , "POST", networkListener,params )  
end

API.requestGET = function(request)

  if request == "GET_CAMPAIGN" then
    newUrl = API.URL..	GET_CAMPAIGN
	API.ACTION = API.GET_CAMPAIGN    
  end

  local json = network.request( newUrl , "GET", networkListener) 
end
---------------------------------------------------------------------------------------------
return API
