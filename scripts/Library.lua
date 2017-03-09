-- Library 1.0.0
-- Licensed under MIT © 2017 Arthur Corenzan
-- More on https://github.com/haggen/openeuo
--

function printf(format, ...)
    print(string.format(format, unpack(arg)))
end

function table.find(t, value)
    for i, v in ipairs(t) do
        if v == value then
            return true
        end
    end
end

local IGNORED = {}

function Find(query)
    local time = getticks()

    local match
    if type(query) == "number" then
        match = function(item) return item.id == query or item.type == query end
    elseif type(query) == "table" then
        match = function(item) return table.find(query, item.id) or table.find(query, item.type) end
    elseif type(query) == "string" then
        match = function(item) return dostring(query) end
    elseif type(query) == "function" then
        match = query
    else
        match = function() return true end
    end

    local n = UO.ScanItems(false)
    for i = 0, n - 1 do
        local item = {}
        item.id,
        item.type,
        item.kind,
        item.containerID,
        item.x,
        item.y,
        item.z,
        item.stack,
        item.rep,
        item.color = UO.GetItem(i)
        if not table.find(IGNORED, item.id) and match(item) then
            return item
        end
    end
    printf("Find: took %dms", getticks() - time)
end

function Ignore(id)
    table.insert(IGNORED, id)
end

function WaitFor(query, timeout)
    timeout = getticks() + timeout
    while dostring("return "..query) == false do
        wait(100)
        if getticks() >= timeout then
            printf("WaitFor: '%s' timed out (%d)", query, timeout)
            return true
        end
    end
end

function WaitForTargCurs(timeout)
    WaitFor("UO.TargCurs", timeout or 5000)
end

function WaitForTarget(timeout)
    WaitFor("not UO.TargCurs", timeout or 10000)
end

function Target(id, kind)
    WaitForTargCurs()
    UO.LTargetID = id
    UO.LTargetKind = kind or 1
    UO.Macro(22, 0)
    wait(1000)
end

function Distance(query)
    local item = Find(query)
    if item == nil then
        print("Distance: query result is empty")
    else
        return math.max(math.abs(UO.CharPosX - item.x), math.abs(UO.CharPosY - item.y))
    end
end

function MoveTo(query, tolerance, timeout)
    local item = Find(query)
    if item == nil then
        print("MoveTo: query result is empty")
    else
        UO.Move(item.x, item.y, tolerance or 1, timeout or 5000)
    end
end

function ReleasePet(id)
    UO.RenamePet(id, "pet")
    UO.Macro(1, 0, "pet release")
    WaitFor("UO.ContSizeX == 270 and UO.ContSizeY == 120", 1000)
    UO.Click(UO.ContPosX + 30, UO.ContPosY + 90, true, true, true, false)
end