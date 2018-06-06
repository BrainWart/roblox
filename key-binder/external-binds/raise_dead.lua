local kp = game.Players.LocalPlayer:WaitForChild("AddKeyBind")
local bind = {
	["name"] = "raise dead";
	["key"] = string.byte("r");
	["on_down"] = true;
	["errors"] = {};
	["bind"] = function()
local char = player.Character
local tor = char.Torso
local ls = tor["Left Shoulder"]
local rs = tor["Right Shoulder"]
ls.Parent = nil
rs.Parent = nil

local nls = Instance.new("Weld", tor)
nls.Part0 = char["Left Arm"]
nls.Part1 = tor
nls.C0 = CFrame.new(1.5,0,0)
local nrs = Instance.new("Weld", tor)
nrs.Part0 = char["Right Arm"]
nrs.Part1 = tor
nrs.C0 = CFrame.new(-1.5,0,0)

for i = 1, 50 do
	wait(1/30)
	local y = (math.sin(math.rad((i/50*90)+(45*4))) * 0.5) + 0.25
	local z = (math.cos(math.rad((i/50*90)+(45*4))) * 0.5) + 0.5
	nls.C1 = CFrame.Angles(math.rad(i/50*90), math.rad(-15), 0) + Vector3.new(0.05,-y,-z)
	nrs.C1 = CFrame.Angles(math.rad(i/50*90), math.rad(15), 0) + Vector3.new(-0.05,-y,-z)
end

ls.Parent = tor
rs.Parent = tor
	end;
};
kp:Fire(bind)