-- TameTame 1.0.0
-- Licensed under MIT © 2017 Arthur Corenzan
-- More on https://github.com/haggen/openeuo
--
-- Roadmap:
-- * Target closest animals first.
-- * Complete tamables table.
-- * Select tamables for character's skill level.
-- * Handle world saves.
-- * Handle attackers.
--

dofile(".\\Library.lua")

local TAMABLES = {
    213, -- Polar Bear
    233, -- Bull
    034, -- White Wolf
    221, -- Walrus
    065, -- Snow Leopard
}

local TameTame = {
    isTaming = false,
    target = nil,
    attempts = 0,
    maxAttempts = 5,
    journalRef = nil,
}

function TameTame:Update()
    if self.state ~= nil then
        self:state()
    end
end

function TameTame:Set(state)
    self.state = state
end

function TameTame:Start()
    self:Set(self.Survey)
    while true do
        wait(250)
        self:Update()
    end
end

function TameTame:Survey()
    UO.SysMessage("Looking for tamables...")

    self.target = Find(TAMABLES)

    if self.target == nil then
        wait(1250)
    else
        UO.ExMsg(self.target.id, 0, 68, "Target")
        self:Set(self.Follow)
    end
end

function TameTame:Follow()
    MoveTo(self.target.id)

    if self.isTaming then
        self:Set(self.CheckResult)
    else
        self:Set(self.Tame)
    end
end

function TameTame:Restart()
    self.isTaming = false
    self.target = nil
    self.attempts = 0
    self:Set(self.Survey)
end

function TameTame:Tame()
    if self.attempts == self.maxAttempts then
        UO.SysMessage("Failed too many times.")
        self:Set(self.Restart)
    else
        self.attempts = self.attempts + 1
        self.isTaming = true
        UO.SysMessage(string.format("Taming. Attempt %d/%d.", self.attempts, self.maxAttempts))
        self.journalRef = UO.ScanJournal(0)
        UO.Macro(13, 35) -- Use Animal Taming.
        Target(self.target.id, self.target.kind)
        self:Set(self.Follow)
    end
end

function TameTame:Retry()
    self.isTaming = false
    self:Set(self.Follow)
end

function TameTame:Release()
    wait(250)
    UO.RenamePet(self.target.id, "pet")
    wait(250)
    UO.Macro(1, 0, "pet release")
    WaitFor("UO.ContSizeX == 270 and UO.ContSizeY == 120", 1000)
    UO.Click(UO.ContPosX + 30, UO.ContPosY + 90, true, true, true, false)
    self:Set(self.Ignore)
end

function TameTame:Ignore()
    Ignore(self.target.id)
    self:Set(self.Restart)
end

function TameTame:CheckResult()
    local journal = ""
    local j, n = UO.ScanJournal(self.journalRef)
    for i = 0, n - 1 do
        local line, color = UO.GetJournal(i)
        journal = journal.."\n"..line
    end
    if string.find(journal, "accept you as master", 1, true) then
        UO.SysMessage("Tamed.")
        self:Set(self.Release)
    elseif string.find(journal, "animal is too angry", 1, true) then
        UO.SysMessage("Beware! You might be being attacked. You have 10 seconds to sort it out.")
        wait(10000)
        self:Set(self.Ignore)
    elseif string.find(journal, "can't tame that", 1, true) then
        UO.SysMessage("Invalid target.")
        self:Set(self.Ignore)
    elseif string.find(journal, "clear path to the animal", 1, true) then
        UO.SysMessage("No line of sight to the target.")
        self:Set(self.Retry)
    elseif string.find(journal, "even challenging", 1, true) then
        UO.SysMessage("Taming the same animal more then once doesn't yield skill points.")
        self:Set(self.Release)
    elseif string.find(journal, "is already taming", 1, true) then
        self:Set(self.Ignore)
    elseif string.find(journal, "looks tame already", 1, true) then
        self:Set(self.Ignore)
    elseif string.find(journal, "Target cannot be seen", 1, true) then
        UO.SysMessage("No line of sight to the target.")
        self:Set(self.Retry)
    elseif string.find(journal, "That is too far", 1, true) then
        UO.SysMessage("Target is out of reach.")
        self:Set(self.Retry)
    elseif string.find(journal, "too many followers", 1, true) then
        UO.SysMessage("You have too many followers. You have 10 seconds to release some of your pets.")
        wait(10000)
        self:Set(self.Retry)
    elseif string.find(journal, "too many owners", 1, true) then
        self:Set(self.Ignore)
    elseif string.find(journal, "You fail to tame", 1, true) then
        self:Set(self.Retry)
    elseif string.find(journal, "You have no chance", 1, true) then
        UO.SysMessage("Target is above your skill.")
        self:Set(self.Ignore)
    else
        self:Set(self.Follow)
    end
end

TameTame:Start()