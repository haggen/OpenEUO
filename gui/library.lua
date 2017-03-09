----------------------------------------
-- Code Library ------------------------
----------------------------------------

-- The code library contains general
-- independent helper functions.

----------------------------------------
----------------------------------------
----------------------------------------

function LoadData(fn)
	local f,e = openfile(fn,"rb")
	if f then
		local s = f:read("*a")
		f:close()
		return s
	end
	return ""
end

----------------------------------------

function SaveData(fn,s)
	local f,e = openfile(fn,"w+b")
	if f then
		f:write(s)
		f:close()
	end
end

----------------------------------------

function GetShortName(s)
	return (s:gsub(".*[\\/]",""))
end

----------------------------------------
----------------------------------------
----------------------------------------

local function ValToData(value,notable,spc)
	local t = type(value)
	if t=="number" or t=="boolean" or t=="nil" then
		return tostring(value)
	end
	if t=="string" then
		return string.format("%q",value):gsub("\\\n","\\n"):gsub("\r","\\r")
	end
	if t=="table" then
		if notable then
			error("No tables allowed here!",2)
		end
		local s = "{\r\n"
		for k,v in pairs(value) do
			s = s..spc..
			"  ["..
			ValToData(k,true)..
			"] = "..
			ValToData(v,false,spc.."  ")..
			",\r\n"
		end
		return s..spc.."}"
	end
	error("Cannot convert "..t.." to string!",2)
end

----------------------------------------

function VarToData(svar)
	return svar.." = "..ValToData(
		dostring("return "..svar)
	).."\r\n"
end

----------------------------------------
----------------------------------------
----------------------------------------

local lookup = {
	["-"] = "nil",
	["b"] = "boolean",
	["n"] = "number",
	["s"] = "string",
	["t"] = "table"
}

----------------------------------------

function CheckType(s,...)
	local t = {...}
	s = s:lower()
	for i=1,s:len() do
		if type(t[i])~=lookup[s:sub(i,i)] then
			return false
		end
	end
	return true
end

----------------------------------------
----------------------------------------
----------------------------------------
