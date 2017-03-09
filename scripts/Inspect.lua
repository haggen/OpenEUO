-- Inspect 1.0.0
-- Licensed under MIT © 2017 Arthur Corenzan
-- More on https://github.com/haggen/openeuo
--

dofile(".\\Library.lua")

PromptTarget()
local item = Find(UO.LTargetID)
if item ~= nil then
    print(
        "id:          "..item.id,
        "type:        "..item.type,
        "kind:        "..item.kind,
        "containerID: "..item.containerID,
        "x:           "..item.x,
        "y:           "..item.y,
        "z:           "..item.z,
        "stack:       "..item.stack,
        "rep:         "..item.rep,
        "color:       "..item.color
    )
end


