--[==[
-- CAM - 06-06-2018 - Uploaded to github
-- CAM - 12-27-2013 - Uploaded to pastebin
]==]--

script.Parent = nil
local player = game.Players.LocalPlayer
local m = player:GetMouse()
local camera = game.Workspace.CurrentCamera
local oc = oc or (function(x) return x end)

local function show(pos, ...)
	local toshow = {...}
	for _, t in pairs(toshow) do
		t["text"] = t["text"] or t[1]
		t["func"] = t["func"] or t[2]
	end
	
	local open = true
	local parts = {}
	for _, t in pairs(toshow) do
		local p = Instance.new("Part", camera)
			p.CanCollide = false
			p.FormFactor = "Custom"
			p.Size = Vector3.new(2,0.5,2)
			p.BrickColor = BrickColor.new("Really red")
			p.Anchored = true
		local gui = Instance.new("BillboardGui", p)
			gui.StudsOffset = Vector3.new(0,2,0)
			gui.Size = UDim2.new(10,0,1,0)
		local txt = Instance.new("TextLabel", gui)
			txt.Size = UDim2.new(1,0,1,0)
			txt.TextScaled = true
			txt.Text = t.text
			txt.BackgroundTransparency = 1
			txt.TextColor3 = Color3.new(1,1,1)
			txt.TextStrokeColor3 = Color3.new(0,0,0)
			txt.TextStrokeTransparency = 0.5
		local cd = Instance.new("ClickDetector", p)
			getfenv(t.func)["this"] = p
			getfenv(t.func)["close"] = function()
				for _, a in pairs(parts) do pcall(a.Destroy, a) end
				parts = {}
			end
			cd.MouseClick:connect(t.func)
		
		table.insert(parts, p)
	end
		
	local mouseHit = pos
	while #parts > 0 do
		wait()
		for i = 1, #parts do
			local rot = math.rad((tick()%360)*20 + (360*(i/#parts)))
			parts[i].CFrame = CFrame.new(0,3,0) * CFrame.new(mouseHit, camera.CoordinateFrame.p) * CFrame.Angles(-math.pi/2,0,0) * (CFrame.Angles(0,rot,0) * CFrame.new(0,0,5))
		end
	end
end

local open = false
local button1down, button2down = false, false
local lastbutton1, lastbutton2 = 0, 0
m.Button1Down:connect(oc(function()
	button1down = true
	if tick() - lastbutton1 > 0.2 then lastbutton1 = tick() return end
	lastbutton1 = tick()
	if open then return end
	open = true
	
	local pos = m.Hit.p
	show(pos, {"Kill", function()
		close()
		local tabs = {}
		for _, p in pairs(game.Players:GetPlayers()) do
			table.insert(tabs, {p.Name, function() pcall(function() p.Character:BreakJoints() end) close() open=false end})
		end
		table.insert(tabs, {"Cancel", function() close() open=false end})
		show(pos, unpack(tabs))
	end}, {"Kick", function()
		close()
		local tabs = {}
		for _, p in pairs(game.Players:GetPlayers()) do
			table.insert(tabs, {p.Name, function() pcall(function() p:Destroy() end) close() open=false end})
		end
		table.insert(tabs, {"Cancel", function() close() open=false end})
		show(pos, unpack(tabs))
	end}, {"Close", function() close() open=false end})
end))
m.Button1Up:connect(function() button1down = false end)