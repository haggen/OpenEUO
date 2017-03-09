-- Looter 1.0.0
-- Licensed under MIT © 2017 Arthur Corenzan
-- More on https://github.com/haggen/openeuo
--

dofile(".\\Library.lua")

local CORPSE = 8198

local LOOT = {
    3821, -- Gold
    7154, -- Ingot
    3974, -- Mandrake Root
    3976, -- Nightshade
    3859, -- Ruby
    3878, -- Diamond
    3885, -- Tourmaline
    3856, -- Emerald
    3851, -- Refresh Potion
}

local Looter = {
    isLooting = false,
    corpse = nil,
    journalRef = nil,
}

function Looter:Update()
    if self.state ~= nil then
        self:state()
    end
end

function Looter:Set(state)
    self.state = state
end

function Looter:Start()
    self:Set(self.Survey)
    while true do
        wait(250)
        self:Update()
    end
end

function Looter:Restart()
    self.isLooting = false
    self.corpse = nil
    self:Set(self.Survey)
end

function Looter:Survey()
    Announce("Looking for corpses nearby...", 5000)

    self.corpse = Find("type == %d and distance <= 2", CORPSE)

    if self.corpse ~= nil then
        UO.ExMsg(self.corpse.id, 0, 38, "Corpse")
        self:Set(self.OpenCorpse)
    end
end

function Looter:OpenCorpse()
    UO.NextCPosX = 50
    UO.NextCPosY = 50
    self.journalRef = UO.ScanJournal(0)
    Use(self.corpse.id)
    wait(500)
    self:Set(self.CheckResult)
end

function Looter:Ignore()
    Ignore(self.corpse.id)
    self:Set(self.Restart)
end

function Looter:CheckResult()
    local journal = ""
    local j, n = UO.ScanJournal(self.journalRef)
    for i = 0, n - 1 do
        local line, color = UO.GetJournal(i)
        journal = journal.."\n"..line
    end
    if string.find(journal, "too far away", 1, true) then
        UO.SysMessage("Corpse is out of reach.")
        self:Set(self.Restart)
    elseif string.find(journal, "am dead", 1, true) then
        UO.SysMessage("You are dead.")
        self:Set(self.Restart)
    elseif string.find(journal, "wait to perform", 1, true) then
        self:Set(self.OpenCorpse)
    elseif string.find(journal, "criminal act", 1, true) then
        UO.SysMessage("Not such a good idea.")
        self:Set(self.Ignore)
    else
        self:Set(self.Loot)
    end
end

function Looter:Loot()
    local loot = Find(function(item)
        return item.containerID == self.corpse.id and table.find(LOOT, item.type)
    end)
    if loot == nil then
        UO.ExMsg(self.corpse.id, 0, 68, "Done")
        self:Set(self.Ignore)
    else
        UO.Drag(loot.id, loot.stack)
        wait(500)
        UO.DropC(UO.BackpackID)
        wait(500)
    end
end

Looter:Start()