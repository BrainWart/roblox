local kp = game.Players.LocalPlayer:WaitForChild("AddKeyBind")
local bind = {
	["name"] = "mine";
	["key"] = string.byte("m");
	["on_down"] = false;
	["errors"] = {};
	["bind"] = function()
local m = Instance.new("Model", Workspace)
	m.Name = "Mine"
local mine = Instance.new("Part", m)
	mine.FormFactor = "Custom"
	mine.BrickColor = BrickColor.new("Really black")
	mine.Size = Vector3.new(1,.5,1)
	mine.Anchored = true
	mine.CFrame = CFrame.new(mouse.Hit.p)
Instance.new("CylinderMesh", mine)
local button = Instance.new("Part", m)
	button.FormFactor = "Custom"
	button.BrickColor = BrickColor.new("Really red")
	button.Size = Vector3.new(.4,.2,0.4)
	button.CanCollide = false
	button.CFrame = mine.CFrame + Vector3.new(0,0.165,0)
	button.Anchored = true
Instance.new("CylinderMesh", button)
mine.Touched:connect(function() Instance.new("Explosion", Workspace).Position = mine.Position; m:Destroy() end)
	end;
};
kp:Fire(bind)