--[==[
-- CAM - 06-06-2018 - Uploaded to github
-- CAM - 11-05-2015 - Uploaded to pastebin
]==]--

local users = {
	["BrainWart"] = {
		["level"] = math.huge;
		["description"] = "The creator of this tablet admin";
		["colors"] = {
			["primary"] = Color3.new(1,1,1);
			["secondary"] = Color3.new(0.5,0.5,0.5);
		};
		["seperators"] = {
			["arg"] = "/";
			["start"] = "-";
		}
	};
}

local connections = {}
do -- connection manager
	function connections:disconnectAll()
		local function dAll(tab)
			for _, v in pairs(tab) do
				if type(v) == "table" then
					dAll(v)
				elseif type(v) == "userdata" then
					pcall(function() v.disconnect() end)
				end
			end
		end
		dAll(connections)
	end
	function connections:add(con)
		table.insert(connections, con)
	end
end

local tablet = {}
do -- tablet functions
	local function makeTablet(text, parent)
		local tab = Instance.new("Part", parent)
			tab.Name = text
			tab.CanCollide = false
			tab.FormFactor = "Custom"
			tab.Size = Vector3.new(1.4,2,0.2)
		local m = Instance.new("SpecialMesh", p)
			m.MeshId = "rbxassetid://9756362"
			m.TextureId = "rbxassetid://36527089"
			Vector3.new(0,0,0)
		local cd = Instance.new("ClickDetector", tab)
			cd.MaxActivationDistance = 20
		local bbGui = Instance.new("BillboardGui", tab)
			bbGui.StudsOffset = Vector3.new(0,3,0)
			bbGui.Size = UDim2.new(4,0,1,0)
		local tl = Instance.new("TextLabel", bbGui)
			tl.Size = UDim2.new(1,0,1,0)
			tl.BorderSizePixel = 0
			tl.Font = "ArialBold"
			tl.TextScaled = true
			tl.BackgroundTransparency = 1
			tl.TextColor3 = Color3.new(1,1,1)
			tl.TextStrokeTransparency = 0.6
			tl.TextStrokeColor3 = Color3.new(0,0,0)
			tl.Text = text
		local bp = Instance.new("BodyPosition", tab)
		local bg = Instance.new("BodyGyro", tab)
			bg.maxTorque = Vector3.new(1e7,1e7,1e7)
		return tab, cd, function(cframe)
			bp.position = cframe.p
			bg.cframe = CFrame.Angles(cframe:toEulerAnglesXYZ())
		end, function(color1, color2)
			m.VertexColor = Vector3.new(color1.r,color1.g,color1.b)
			tl.TextColor3 = Color3.new(1,1,1)
			tl.TextStrokeColor3 = Color3.new(0,0,0)
		end
	end

	function tablet:display(player, ...)
		local tabs = {}
		local active = true
		for _, v in pairs({...}) do
			local tab, cd, repos, recolor = makeTablet(v, Workspace)
			cd.MouseClick:connect(function(p)
				if p == player then
					for _, v in pairs(tabs) do
						pcall(function() v.tablet:Destroy() end)
					end
					active = false
				end
			end)
			table.insert(tabs, {
				["tablet"] = tab;
				["clickdetector"] = cd;
				["reposition"] = repos;
				["recolor"] = recolor;
			})
		end
		
		local colors = users[player.Name].colors
		local rot = 0
		repeat
			wait()
			for i = 1, #tabs do -- for i, tab in pairs(tabs) do
				local tab = tabs[i]
				local x, y, z = math.sin(math.rad(i/#tabs*360) + rot), 0, math.cos(math.rad(i/#tabs*360) + rot)
				tab.reposition(CFrame.new(Vector3.new(x*5,y,z*5) + player.Character.Torso.Position, Vector3.new(0,1,0) + player.Character.Torso.Position))
				tab.recolor(colors.primary, colors.secondary)
			end
			rot = (rot + math.pi/250) % (math.pi*2)
		until not active
	end
end

tablet:display(game.Players.BrainWart, "test1", "test2", "test3")