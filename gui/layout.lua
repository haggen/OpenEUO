---------------------------------------- 
-- Layout Code ------------------------- 
----------------------------------------  
--
-- In here, all the window elements are
-- created and positioned. This code is
-- pretty much standalone and should not
-- include any complicated handlers or
-- dependencies. It simply draws a window!
--
----------------------------------------
--
-- MainForm       : main form
-- StatusPanel0   : statusbar entry 0
-- StatusPanel1   : statusbar entry 1
-- ProjectTabCtrl : project tabs
-- ThreadTabCtrl  : thread tabs
-- StackTabCtrl   : stack tabs
-- ScriptPanel    : script area
-- OutputPanel    : output area
-- VarPanel       : variable area
-- OpenDialog     : open dialog
-- SaveDialog     : save dialog
-- ConfirmDialog  : confirm dialog
-- AboutDialog    : about dialog
--
-- function CreateLayout()
-- function FreeLayout()
--
----------------------------------------
----------------------------------------
----------------------------------------

local StatusBar
local PanelB
local PanelC
local SplitA
local PanelD
local PanelE
local SplitB

----------------------------------------

function CreateLayout()

	MainForm = Obj.Create("TForm")
	MainForm.Left = 320
	MainForm.Top = 320
	MainForm.Width = 700
	MainForm.Height = 420
	MainForm.Font.Name = "Arial"
	MainForm.Font.Size = 8
	MainForm.Caption = Version
	MainForm.OnClose = ExitHandler

	local Icon = Obj.Create("TIcon")
	Icon.Data = LoadData("icons/openeuo.ico")
	MainForm.Icon = Icon
	Obj.Free(Icon)

	do -- MainForm's children:

		StatusPanel0 = Obj.Create("TStatusPanel")
		StatusPanel0.Alignment = C.taCenter
		StatusPanel0.Width = 60

		StatusPanel1 = Obj.Create("TStatusPanel")

		StatusBar = Obj.Create("TStatusBar")
		StatusBar.Parent = MainForm
		StatusBar.Insert(0,StatusPanel0)
		StatusBar.Insert(1,StatusPanel1)

		ProjectTabCtrl = Obj.Create("TTabControl")
		ProjectTabCtrl.Align = C.alClient
		ProjectTabCtrl.HotTrack = true
		ProjectTabCtrl.Parent = MainForm

		ThreadTabCtrl = Obj.Create("TTabControl")
		ThreadTabCtrl.Align = C.alClient
		ThreadTabCtrl.HotTrack = true
		ThreadTabCtrl.TabPosition = C.tpBottom
		ThreadTabCtrl.Parent = ProjectTabCtrl
		ThreadTabCtrl.Tabs.Add('Thread 1')

		do -- ThreadTabControl's children:
		
			PanelB = Obj.Create("TPanel")
			PanelB.Height = 3
			PanelB.BevelOuter = C.bvNone
			PanelB.Align = C.alBottom
			PanelB.Parent = ThreadTabCtrl

			PanelC = Obj.Create("TPanel")
			PanelC.BevelOuter = C.bvNone
			PanelC.Align = C.alClient
			PanelC.Parent = ThreadTabCtrl

			do -- PanelC's children:

				VarPanel = Obj.Create("TPanel")
				VarPanel.Width = 150
				VarPanel.BevelOuter = C.bvNone
				VarPanel.Align = C.alRight
				VarPanel.Parent = PanelC

				SplitA = Obj.Create("TSplitter")
				SplitA.Align = C.alRight
				SplitA.AutoSnap = false
				SplitA.Parent = PanelC

				PanelD = Obj.Create("TPanel")
				PanelD.BevelOuter = C.bvNone
				PanelD.Align = C.alClient
				PanelD.Parent = PanelC

				do -- PanelD's children:

					PanelE = Obj.Create("TPanel")
					PanelE.Height = 95
					PanelE.BevelOuter = C.bvNone
					PanelE.Align = C.alBottom
					PanelE.Parent = PanelD

					do -- PanelE's children:

						StackTabCtrl = Obj.Create("TTabControl")
						StackTabCtrl.Align = C.alTop
						StackTabCtrl.Style = C.tsButtons
						StackTabCtrl.Height = 21
						StackTabCtrl.Parent = PanelE
						StackTabCtrl.TabHeight = 19
						StackTabCtrl.Tabs.Add('StackLvl 1')

						OutputPanel = Obj.Create("TPanel")
						OutputPanel.Height = 72
						OutputPanel.BevelOuter = C.bvNone
						OutputPanel.Align = C.alClient
						OutputPanel.Font.Name = "Courier New"
						OutputPanel.Font.Size = 10
						OutputPanel.Parent = PanelE
					end

					SplitB = Obj.Create("TSplitter")
					SplitB.Align = C.alBottom
					SplitB.AutoSnap = false
					SplitB.Parent = PanelD

					ScriptPanel = Obj.Create("TPanel")
					ScriptPanel.BevelOuter = C.bvNone
					ScriptPanel.Align = C.alClient
					ScriptPanel.Font.Name = "Courier New"
					ScriptPanel.Font.Size = 10
					ScriptPanel.Parent = PanelD
				end
			end
		end
	end

	local filter  = "Lua Files (*.lua)|*.lua|Text Files (*.txt)|*.txt|All Files (*.*)|*.*"

	OpenDialog = Obj.Create("TOpenDialog")
	OpenDialog.DefaultExt = "lua"
	OpenDialog.Filter = filter
	OpenDialog.InitialDir = getinstalldir()
	OpenDialog.Options = C.ofFileMustExist

	SaveDialog = Obj.Create("TSaveDialog")
	SaveDialog.DefaultExt = "lua"
	SaveDialog.Filter = filter
	SaveDialog.InitialDir = getinstalldir()
	SaveDialog.Options = C.ofPathMustExist+C.ofOverwritePrompt

	ConfirmDialog = Obj.Create("TMessageBox")
	ConfirmDialog.Handle = MainForm.Handle
	ConfirmDialog.Title = "Confirm"
	ConfirmDialog.Button = C.mbYesNo
	ConfirmDialog.Icon = C.mbIconQuestion
	ConfirmDialog.Default = C.mbDefButton2

	AboutDialog = Obj.Create("TMessageBox")
	AboutDialog.Handle = MainForm.Handle
	AboutDialog.Title = "About"
	AboutDialog.Icon = C.mbIconInformation

	dofile("wndpos.cfg",false)
end

----------------------------------------

function FreeLayout()
	if MainForm.WindowState<2 then
		SaveData("wndpos.cfg",
			VarToData("MainForm.Left")..
			VarToData("MainForm.Top")..
			VarToData("MainForm.Width")..
			VarToData("MainForm.Height")..
			VarToData("OutputPanel.Height")..
			VarToData("VarPanel.Width"))
	end

	Obj.Free(AboutDialog)
	Obj.Free(ConfirmDialog)
	Obj.Free(SaveDialog)
	Obj.Free(OpenDialog)

	Obj.Free(StackTabCtrl)
	Obj.Free(OutputPanel)

	Obj.Free(ScriptPanel)
	Obj.Free(SplitB)
	Obj.Free(PanelE)

	Obj.Free(PanelD)
	Obj.Free(SplitA)
	Obj.Free(VarPanel)

	Obj.Free(PanelC)
	Obj.Free(PanelB)

        Obj.Free(ThreadTabCtrl)
	Obj.Free(ProjectTabCtrl)

	Obj.Free(StatusPanel1)
	Obj.Free(StatusPanel0)
	Obj.Free(StatusBar)

	Obj.Free(MainForm)
end
