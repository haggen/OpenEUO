---------------------------------------- 
-- Menu Code --------------------------- 
----------------------------------------  
--
-- This is where the main menu and the
-- toolbar are built.
--
----------------------------------------
--
-- table  MenuItem
-- object EditPopup
-- object ClosePopup
--
-- function CreateMenu()
-- function FreeMenu()
--
----------------------------------------  
----------------------------------------  
----------------------------------------  

local Main = {
	{ "File"       ,00             ,00                },
	{ "Edit"       ,00             ,00                },
	{ "Control"    ,00             ,00                },
	{ "Help"       ,00             ,00                },
}

local File = {
	{ "New"        ,00             ,11 ,"new.ico"     },
	{ "Open..."    ,00             ,12 ,"open.ico"    },
	{ "Save"       ,00             ,13 ,"save.ico"    },
	{ "Save As..." ,00             ,14                },
	{ "-"          ,00             ,00                },
	{ "Close"      ,00             ,15 ,"close.ico"   },	
	{ "Close All"  ,00             ,16                },	
	{ "Exit"       ,00             ,17                },
}

local Edit = {
	{ "Cut"        ,C.scCtrl+C.scX ,21 ,"cut.ico"     },
	{ "Copy"       ,C.scCtrl+C.scC ,22 ,"copy.ico"    },
	{ "Paste"      ,C.scCtrl+C.scV ,23 ,"paste.ico"   },
	{ "Delete"     ,00             ,24                },
	{ "Select All" ,C.scCtrl+C.scA ,25                },
	{ "-"          ,00             ,00                },
	{ "Undo"       ,C.scCtrl+C.scZ ,26                },
}

local Ctrl = {
	{ "Start"      ,C.scF9         ,31 ,"start.ico"   },
	{ "Pause"      ,00             ,32 ,"pause.ico"   },
	{ "Stop"       ,00             ,33 ,"stop.ico"    },
	{ "Stop All"   ,C.scF12        ,34 ,"stopall.ico" },
	{ "-"          ,00             ,00                },
	{ "Step Into"  ,C.scF7         ,35                },
	{ "Step Over"  ,C.scF8         ,36                },
	{ "Step Out"   ,00             ,37                },
}

local Help = {
	{ "Website..." ,00             ,41 ,"home.ico"    },
	{ "About..."   ,00             ,42 ,              },
}

----------------------------------------

local Close = {
	{ "Close"      ,00             ,15 ,"close.ico"   },	
}

----------------------------------------

local ToolBar = {
	{11, "New"     },
	{12, "Open"    },
	{13, "Save"    },
	{15, "Close"   },
	{00,           },
	{21, "Cut"     },
	{22, "Copy"    },
	{23, "Paste"   },
	{00,           },
	{31, "Start"   },
	{32, "Pause"   },
	{33, "Stop"    },
	{34, "Stop All"},
	{00,           },
	{41, "Website" },
}

----------------------------------------
----------------------------------------
----------------------------------------

local Icon
local ImageList
local MenuObj
local MainMenu
local ToolObj

MenuItem  = {}
EditPopup = nil

----------------------------------------

local function BuildMenu(parent,t)
	for k,v in pairs(t) do
		local m = Obj.Create("TMenuItem")
		m.Caption  = v[1]
		m.ShortCut = v[2]
		if v[3]>0 then
			m.OnClick = MenuHandler[v[3]]
			MenuItem[v[3]] = m
		end
		if v[4] then
			m.ImageIndex = ImageList.Count
			Icon.Data = LoadData("icons/"..v[4])
			ImageList.Insert(ImageList.Count,Icon)
		end
		parent.Add(m)
	end
end

----------------------------------------

local function DestroyMenu(parent)
	while parent.Count>0 do
		local child = parent.GetItem(0)
		DestroyMenu(child)
		parent.Delete(0)
		Obj.Free(child)
	end
end

----------------------------------------

local function BuildTool()
	for i = #ToolBar,1,-1 do
		local t = ToolBar[i]
		local b = Obj.Create("TToolButton")
		if t[1]==0 then
			b.Style = C.tbsSeparator
			b.Width = 8
		else
			b.MenuItem = MenuItem[t[1]]
			b.Hint = t[2]
			b.ShowHint = true
		end
		b.Parent = ToolObj
	end
end

----------------------------------------

local function DestroyTool()
	while ToolObj.ButtonCount>0 do
		Obj.Free(ToolObj.GetButton(0))
	end
end

----------------------------------------

function CreateMenu()
	Icon = Obj.Create("TIcon")
	ImageList = Obj.Create("TImageList")
	MenuObj = Obj.Create("TMainMenu")
	MenuObj.Images = ImageList

	MainMenu = MenuObj.Items
	BuildMenu(MainMenu           ,Main)
	BuildMenu(MainMenu.GetItem(0),File)
	BuildMenu(MainMenu.GetItem(1),Edit)
	BuildMenu(MainMenu.GetItem(2),Ctrl)
	BuildMenu(MainMenu.GetItem(3),Help)
	MainForm.Menu = MenuObj

	EditPopup = Obj.Create("TPopupMenu")
	EditPopup.Images = ImageList
	BuildMenu(EditPopup.Items,Edit)

	ClosePopup = Obj.Create("TPopupMenu")
	ClosePopup.Images = ImageList
	BuildMenu(ClosePopup.Items,Close)
	ProjectTabCtrl.PopupMenu = ClosePopup

	ToolObj = Obj.Create("TToolBar")
	ToolObj.Align = C.alTop
	ToolObj.Parent = MainForm
	ToolObj.Flat = true
	ToolObj.ButtonWidth = 25
	ToolObj.ButtonHeight = 25
	ToolObj.Images = ImageList
	BuildTool()
end

----------------------------------------

function FreeMenu()
	DestroyTool()
	Obj.Free(ToolObj)
	DestroyMenu(EditPopup.Items)
	Obj.Free(ClosePopup)
	Obj.Free(EditPopup)
	DestroyMenu(MainMenu)
	Obj.Free(MenuObj)
	Obj.Free(ImageList)
	Obj.Free(Icon)
end
