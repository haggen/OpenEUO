----------------------------------------
-- Triangle Demo by Cheffe -------------
----------------------------------------

-----------------------------
-- set speed appropriately --
-----------------------------
--    2 = normal
--    4 = fast
--   10 = very fast
--  100 = insane (check CPU!)
-- >100 = ...
-----------------------------

speed       = 2
alwaysontop = true

--You can quit the script by pressing Alt-F4!!!

----------------------------------------
-- DO NOT EDIT BELOW THIS LINE ---------
----------------------------------------

MainForm = Obj.Create("TForm")
MainForm._ = {
	BorderStyle = 0,
	WindowState = 2,
	Color = 0,
	TransparentColor = true,
	TransparentColorValue = 0,
	OnClose = function() Obj.Exit() end,
}
if alwaysontop then
	MainForm.FormStyle = 3
else
	MainForm.FormStyle = 0
end
MainForm.Visible = true

----------------------------------------

Canvas	= MainForm.Canvas
Pen	= Canvas.Pen
w	= MainForm.Width
h	= MainForm.Height
p1	= {w/2,h/2,1,1}
p2	= {w/2,h/2,2,1}
p3	= {w/2,h/2,3,1}
math.randomseed(select(4,gettime()))

----------------------------------------

function changedir(p)
	p[3] = math.random(4)
end

function isgrid(c,t)
	for i=1,#t do
		if c==t[i] then
			return true
		end
	end
	return false
end

function calc(p)
	if p[3]==1 then
		if p[1]<w-1 then p[1] = p[1] + 1
		else changedir(p) end
	end
	if p[3]==2 then
		if p[1]>0 then p[1] = p[1] - 1
		else changedir(p) end
	end
	if p[3]==3 then
		if p[2]<h-1 then p[2] = p[2] + 1
		else changedir(p) end
	end
	if p[3]==4 then
		if p[2]>0 then p[2] = p[2] - 1
		else changedir(p) end
	end

	tw = {0, w/2, w-1}
	th = {0, h/2, h-1}
	if isgrid(p[1],tw) and isgrid(p[2],th) then
		changedir(p)
	end

	p[4] = p[4]+p[3]
	if p[4]>255 then
		p[4] = p[4]-254
	end
end

function paint()
	for i=1,4 do
		calc(p1)
		calc(p2)
		calc(p3)
	end
	Pen.Color = p1[4]
	Canvas.Line(p1[1], p1[2], p2[1], p2[2])
	Pen.Color = Bit.Shl(p2[4],8)
	Canvas.Line(p2[1], p2[2], p3[1], p3[2])
	Pen.Color = Bit.Shl(p3[4],16)
	Canvas.Line(p3[1], p3[2], p1[1], p1[2])
end

----------------------------------------

Timer = Obj.Create("TTimer")
Timer.OnTimer = function()
	for i=1,speed do
		paint()
	end
end
Timer.Interval = 20
Timer.Enabled = true

----------------------------------------

print("Drawing triangles with speed = "..speed.."...")
Obj.Loop()
print("Done!")
Obj.Free(Timer)
Obj.Free(MainForm)
