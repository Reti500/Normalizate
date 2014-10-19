local json = require "json"
local jsonStorage = require "scripts.libs.jsonStorage"

local db = {}

local pathNOM = system.pathForFile( "data/catanom.json", system.ResourceDocument )
local pathNMX = system.pathForFile( "data/catanmx.json", system.ResourceDocument )

local jsonNMX = nil
local jsonNOM = nil

local default_document = "NMX"

local function findInArray( array, search )
	for i=1, #array do
		if array[i] == search then
			return true
		end
	end

	return false
end

db.init = function()
	local fileNMX = io.open( pathNMX, "r" )
	local fileNOM = io.open( pathNOM, "r" )

	jsonNMX = json.decode( fileNMX:read( "*a" ) )
	jsonNOM = json.decode( fileNOM:read( "*a" ) )
end

db.find_by = function( document, key, search, exact, limit )
	local _json = nil
	local results = {}

	if document and document == "NOM" then
		_json = jsonNOM
	elseif document and document == "NMX" then
		_json = jsonNMX
	end

	for i=1, #_json do
		local item = _json[i]

		if limit and #results > limit then
			break
		end
		
		if exact then
			if type(key) == "table" then
				local exists = false

				for j=1, #key do
					if item[key[j]] == search then
						exists = true
						results[#results+1] = item
					end
				end

				if exists then
					results[#results+1] = item
				end
			else
				if item[key] == search then
					results[#results+1] = item
				end
			end
		else
			if type(key) == "table" then
				local exists = false

				for j=1, #key do
					if string.find( item[key[j]], search ) then
						exists = true
						results[#results+1] = item
					end
				end

				if exists then
					results[#results+1] = item
				end
			else
				if string.find( tostring( item[key] ), search ) or tostring( item[key] ) == search then
					results[#results+1] = item
				end
			end
		end
	end

	return results
end

db.get_all = function( document, key, limit )
	local _json = nil
	local results = {}

	if document and document == "NOM" then
		_json = jsonNOM
	elseif document and document == "NMX" then
		_json = jsonNMX
	end

	for i=1, #_json do
		local item = _json[i]

		if limit and #results > limit then
			break
		end

		for j=1, #key do
			if findInArray(results, item[key]) then
				--print("repetido")
			else
				results[#results+1] = item[key]
			end
		end
	end

	return results
end

return db