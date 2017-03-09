local list = {}
local index = -1
local count = 0
local iname = 0

local tc,tm
local initscript = "UO.CliNr=1"

----------------------------------------

local function GetVarText()

	--NOTE: The following uses the GUI's UO table, not the script's!
	--      That means it won't be synced to the client selected
	--      in case the user has multiple clients open!

	local t = {

	  "Character Info:",
	    "CharPosX",
	    "CharPosY",
	    "CharPosZ",
	    "CharDir",
	    "CharID",
	    "CharType",
	    "CharStatus",
	    "BackpackID",

	  "Status Info:",
	    "CharName",
	    "Sex",
	    "Str",
	    "Dex",
	    "Int",
	    "Hits",
	    "MaxHits",
	    "Stamina",
	    "MaxStam",
	    "Mana",
	    "MaxMana",
	    "MaxStats",
	    "Luck",
	    "Weight",
	    "MaxWeight",
	    "MinDmg",
	    "MaxDmg",
	    "Gold",
	    "MaxFol",
	    "Followers",
	    "AR",
	    "FR",
	    "CR",
	    "PR",
	    "ER",
	    "TP",

	  "Container Info:",
	    "ContID",
	    "ContType",
	    "ContKind",
	    "ContName",
	    "ContPosX",
	    "ContPosY",
	    "ContSizeX",
	    "ContSizeY",
	    "NextCPosX",
	    "NextCPosY",

	  "Client Info:",
	    "CliNr",
	    "CliCnt",
	    "CliLang",
	    "CliVer",
	    "CliLogged",
	    "CliLeft",
	    "CliTop",
	    "CliXRes",
	    "CliYRes",
	    "CliTitle",

	  "Last Action:",
	    "LObjectID",
	    "LObjectType",
	    "LTargetID",
	    "LTargetKind",
	    "LTargetTile",
	    "LTargetX",
	    "LTargetY",
	    "LTargetZ",
	    "LLiftedID",
	    "LLiftedKind",
	    "LLiftedType",
	    "LSkill",
	    "LSpell",

	  "Miscellaneous:",
	    "EnemyHits",
	    "EnemyID",
	    "RHandID",
	    "LHandID",
	    "CursorX",
	    "CursorY",
	    "CursKind",
	    "TargCurs",
	    "Shard",
	    "LShard",
	    "SysMsg",

	}

	local s = ""
	for i = 1,#t do
		local u = t[i]
		if u:sub(#u)==":" then
			s = s.."\r\n"..u.."\r\n"
		else
			s = s.."    "..u.." = "..tostring(UO[u]).."\r\n"
		end
	end

	UO.CliNr = 1
	return s:sub(3,#s)
end

----------------------------------------

local function ELocked(i)
	s = Ctrl.GetOutput(i)
	if s~="" then
		list[i+1].o.Lines.Add(s)
	end

	Ctrl.Unlock(i)
end

----------------------------------------

local function ELockTimer(sender)
	Ctrl.Lock(sender.Tag)
end

----------------------------------------

local function ETabChange()
	local i = tc.TabIndex
	if i>=0 and i<count then
		index = i
		list[i+1].o.BringToFront()
		list[i+1].v.BringToFront()
		local s = list[i+1].s
		s.BringToFront()
		s.SetFocus()
	end
end

----------------------------------------

local states = {"Stopped","Running...","Paused","Stepping...","Stepping...","Stepping..."}
local oldline = 0
local unselect = false
local function EStatusTimer()
	if count>0 then
		local s = Inst.ScriptMemo()
		local i = Ctrl.GetState(index)
		s.ReadOnly = i~=0

		local x = s.CaretX
		local y = s.CaretY
		local z = ""
		if i==2 then
			local a = Ctrl.GetLine(index)
			local b = Ctrl.GetLocation(index)
			local m = Ctrl.GetPrefix(index) .. Ctrl.GetName(index)
			z = " in " .. b .. " at line " .. a
			if oldline~=a and b==m then
				oldline = a
				s.CaretY = a
				s.CaretX = 0
			end
			unselect = true
		elseif i<2 then
			if unselect then
				oldline = 0
				s.SelLength = 0
				unselect = false
			end
		end

		---

		local v  = Inst.VarPanel()
		local v1 = Inst.VarLabel()
		local v2 = Inst.VarScrollBar()

		v1.Caption = GetVarText()

		v2.Max = v1.Height
		v2.PageSize = v.Height
		v2.LargeChange = v.Height

		---

		StatusPanel0.Text = y .. "," .. x
		StatusPanel1.Text = " " .. states[i+1] .. z
	else
		StatusPanel0.Text = ""
		StatusPanel1.Text = ""
	end
end

----------------------------------------

local function EScrollBar()
		local v1 = Inst.VarLabel()
		local v2 = Inst.VarScrollBar()

		v1.Top = -v2.Position
end

----------------------------------------

function CreateInst(tabctrl)
	tc = tabctrl
	tc.OnChange = ETabChange
	Ctrl.SetHandler(ELocked)
	Inst.New()

	tm = Obj.Create("TTimer")
	tm.OnTimer = EStatusTimer
	tm.Interval = 200
	tm.Enabled = true
end

----------------------------------------

function FreeInst()
	Obj.Free(tm)
	Inst.CloseAll(true)
end

----------------------------------------
----------------------------------------
----------------------------------------

Inst = {}

function Inst.New()
	local s = Obj.Create("TSynMemo")
	s.ActiveLineColor = 15395562
	s.WantTabs = true
	s.WordWrap = false
	s.ScrollBars = C.ssBoth
	s.Align = C.alClient
	s.PopupMenu = EditPopup --global!
	s.Parent = ScriptPanel

	local o = Obj.Create("TMemo")
	o.WantTabs = true
	o.WordWrap = false
	o.ScrollBars = C.ssVertical
	o.Align = C.alClient
	o.PopupMenu = EditPopup --global!
	o.Parent = OutputPanel

	---

	local v = Obj.Create("TPanel")
	v.BevelInner = C.bvNone
	v.BevelOuter = C.bvNone
	v.BorderStyle = C.bsSingle
	v.Color = C.clWindow
	v.Align = C.alClient
	v.Parent = VarPanel

	local v2 = Obj.Create("TScrollBar")
	v2.Kind = C.sbVertical
	v2.Align = C.alRight
	v2.SmallChange = 14
	v2.TabStop = false
	v2.OnChange = EScrollBar
	v2.Parent = v

	local v1 = Obj.Create("TLabel")
	v1.Left = 2
	v1.Parent = v

	---

	local t = Obj.Create("TTimer")
	t.Tag = count
	t.OnTimer = ELockTimer
	t.Interval = 100
	t.Enabled = true

	index = count
	count = count + 1
	table.insert(list,{s=s,o=o,v=v,v1=v1,v2=v2,t=t})

	iname = iname + 1
	tc.Tabs.Add("new"..iname)
	tc.TabIndex = index

	if count==1 then
		tc.Show()
	end
	s.SetFocus()

	Ctrl.Open()
	Ctrl.SetPrefix(index,"$")
	Ctrl.SetName(index,"new"..iname)

	---

	EStatusTimer()
end

----------------------------------------

local function ChangeName(s)
	Ctrl.SetPrefix(index,"!")
	Ctrl.SetName(index,s)
	tc.Tabs.SetString(index,GetShortName(s))
end

----------------------------------------

function Inst.Open()
	if OpenDialog.Execute() then
		if count<1 then
			Inst.New()
		elseif Inst.ScriptMemo().Modified or
		Inst.ScriptMemo().Lines.Count>0 then
			Inst.New()
		end
		ChangeName(OpenDialog.FileName)
		Inst.ScriptMemo().Lines.Text = LoadData(OpenDialog.FileName)
	end
end

----------------------------------------

function Inst.Save()
	if count>0 then
		if Ctrl.GetPrefix(index)=='!' then
			SaveData(Ctrl.GetName(index),Inst.ScriptMemo().Lines.Text)
		else
			Inst.SaveAs()
		end
	end
end

----------------------------------------

function Inst.SaveAs()
	if SaveDialog.Execute() then
		ChangeName(SaveDialog.FileName)
		SaveData(SaveDialog.FileName,Inst.ScriptMemo().Lines.Text)
	end
end

----------------------------------------

function Inst.Close()
	if count>0 then
		Ctrl.Close(index)
		tc.Tabs.Delete(index)
		Obj.Free(list[index+1].s)
		Obj.Free(list[index+1].o)
		Obj.Free(list[index+1].v2)
		Obj.Free(list[index+1].v1)
		Obj.Free(list[index+1].v)
		Obj.Free(list[index+1].t)
		table.remove(list,index+1)
		count = count - 1

		index = index - 1
		if index<0 and count>0 then
			index = 0
		end
		tc.TabIndex = index
		ETabChange()

		if count==0 then
			tc.Hide()
		end
	end
end

----------------------------------------

function Inst.Confirm(s)
	return ConfirmDialog.Show(s)==C.mbIdYes
end

----------------------------------------

function Inst.CloseAll(noconf)
	if count>0 and noconf~=true then
		if not Inst.Confirm("Close all tabs?") then return end
	end
	while count>0 do
		Inst.Close()
	end
end

----------------------------------------

function Inst.ScriptMemo()
	if count>0 then
		return list[index+1].s
	end
end

----------------------------------------

function Inst.OutputMemo()
	if count>0 then
		return list[index+1].o
	end
end

----------------------------------------

function Inst.VarPanel()
	if count>0 then
		return list[index+1].v
	end
end

----------------------------------------

function Inst.VarLabel()
	if count>0 then
		return list[index+1].v1
	end
end

----------------------------------------

function Inst.VarScrollBar()
	if count>0 then
		return list[index+1].v2
	end
end

----------------------------------------

local function InitFirst()
		if Ctrl.GetState(index)==0 then
			Inst.OutputMemo().Clear()
			Ctrl.SetScript(index,initscript.." "..Inst.ScriptMemo().Lines.Text)
		end
end

----------------------------------------

function Inst.Start()
	if count>0 then
		InitFirst()
		Ctrl.SetControl(index,1) --start
	end
end

----------------------------------------

function Inst.Pause()
	if count>0 then
		if Ctrl.GetState(index)~=0 then
			Ctrl.SetControl(index,2) --pause
		end
	end
end

----------------------------------------

function Inst.Stop()
	if count>0 then
		if Ctrl.GetState(index)~=0 then
			Ctrl.SetControl(index,0) --stop
		else
			Ctrl.Reset(index)
		end
	end
end

----------------------------------------

function Inst.StopAll()
	for i=0,Ctrl.GetCount()-1 do
		if Ctrl.GetState(i)~=0 then
			Ctrl.SetControl(i,0) --stop
		else
			Ctrl.Reset(i)
		end
	end
end

----------------------------------------

function Inst.StepInto()
	if count>0 then
		InitFirst()
		Ctrl.SetControl(index,3) --step into
	end
end

----------------------------------------

function Inst.StepOver()
	if count>0 then
		InitFirst()
		Ctrl.SetControl(index,4) --step over
	end
end

----------------------------------------

function Inst.StepOut()
	if count>0 then
		if Ctrl.GetState(index)>0 then --script must already have been started
			Ctrl.SetControl(index,5) --step out
		end
	end
end

----------------------------------------

local function GetActiveMemo()
	if list[index+1].o.Focused then
		return list[index+1].o
	end
	return list[index+1].s
end
function Inst.Cut()
	if count>0 then
		GetActiveMemo().CutToClipboard()
	end
end
function Inst.Copy()
	if count>0 then
		GetActiveMemo().CopyToClipboard()
	end
end
function Inst.Paste()
	if count>0 then
		GetActiveMemo().PasteFromClipboard()
	end
end
function Inst.Delete()
	if count>0 then
		GetActiveMemo().ClearSelection()
	end
end
function Inst.SelectAll()
	if count>0 then
		GetActiveMemo().SelectAll()
	end
end
function Inst.Undo()
	if count>0 then
		GetActiveMemo().Undo()
	end
end

----------------------------------------
