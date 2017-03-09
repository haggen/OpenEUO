----------------------------------------
-- Cheffe's File Access Functions ------
----------------------------------------

function LoadData(fn)
  local f,e = openfile(fn,"rb")         --r means read-only (default)
  if f then                             --anything other than nil/false evaluates to true
    local s = f:read("*a")              --*a means read all
    f:close()
    return s
  else                                  --if openfile fails it returns nil plus an error message
    error(e,2)                          --stack level 2, error should be reported
  end                                   --from where LoadData() was called!
end

----------------------------------------

function SaveData(fn,s)
  local f,e = openfile(fn,"w+b")        --w+ means overwrite
  if f then
    f:write(s)
    f:close()
  else
    error(e,2)
  end
end

----------------------------------------
-- Cheffe's Table Converter Functions --
----------------------------------------

local function ToStr(value,func,spc)
  local t = type(value)                 --get type of value
  if t=="string" then
    return string.format("%q",value):gsub("\\\n","\\n"):gsub("\r","\\r")
  end
  if t=="table" then
    if func then
      return func(value,spc.."  ")
    else
      error("Tables not allowed as keys!",2)
    end
  end
  if t=="number" or t=="boolean" or t=="nil" then
    return tostring(value)
  end
  error("Cannot convert unknown type to string!",2)
end

----------------------------------------

local function TblToStr(t,spc)
  local s = "{\r\n"
  for k,v in pairs(t) do
    s = s..spc.."  ["..ToStr(k).."] = "..ToStr(v,TblToStr,spc)..",\r\n"
  end
  return s..spc.."}"
end

----------------------------------------

function TableToString(table)
  return TblToStr(table,"")
end

----------------------------------------
----------------------------------------
----------------------------------------

config = {
  width   = 320,
  heigth  = 240,
  caption = "test",
  active  = true,
  data    = {0,nil,1337,nil,0}
}

----------------------------------------

function Main()
        fn = "config.txt"

        --save config to file
        SaveData(fn,"return "..TableToString(config))

        --erase config from memory
        config = nil

        --load config from file
        s = LoadData(fn)
        print(s)
        config = dostring(s)
	print("\r\nThis is "..config.data[3].."!")
end

----------------------------------------

Main() --run program!
