----------------------------------------
-- Main Code ---------------------------
----------------------------------------

-- This is where the other GUI files are
-- loaded and everything is tied together.

----------------------------------------
----------------------------------------
----------------------------------------

Version = "OpenEUO 0.91"

dofile("const.lua")
dofile("library.lua")
dofile("layout.lua")
dofile("menu.lua")
dofile("instances.lua")

----------------------------------------

function ExitHandler()
	if Inst.Confirm("Exit OpenEUO?") then
		MainForm.Hide()
		Obj.Exit()
	end
end

----------------------------------------

MenuHandler = {
	[11] = Inst.New,
	[12] = Inst.Open,
	[13] = Inst.Save,
	[14] = Inst.SaveAs,
	[15] = Inst.Close,
	[16] = Inst.CloseAll,
	[17] = ExitHandler,

	[21] = Inst.Cut,
	[22] = Inst.Copy,
	[23] = Inst.Paste,
	[24] = Inst.Delete,
	[25] = Inst.SelectAll,
	[26] = Inst.Undo,

	[31] = Inst.Start,
	[32] = Inst.Pause,
	[33] = Inst.Stop,
	[34] = Inst.StopAll,
	[35] = Inst.StepInto,
	[36] = Inst.StepOver,
	[37] = Inst.StepOut,

	[41] = function()
		Ctrl.Execute("http://www.easyuo.com/forum/viewforum.php?f=37")
	end,
	[42] = function()
		AboutDialog.Show(Version.."\r\nby Cheffe")
	end,
}

----------------------------------------

local function Main()
	CreateLayout()
	CreateMenu()
	MainForm.Show()
	CreateInst(ProjectTabCtrl)
	Obj.Loop()
	FreeInst()
	FreeMenu()
	FreeLayout()
end

----------------------------------------

Main()
