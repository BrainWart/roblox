local kp = game.Players.LocalPlayer:WaitForChild("AddKeyBind")
local bind = {
	["name"] = "5 exploders";
	["key"] = string.byte("v");
	["on_down"] = false;
	["errors"] = {};
	["bind"] = function()
_G.positions = _G.positions or {}
if #_G.positions < 5 then
	local p = Instance.new("Part", Workspace)
	p.Anchored = true
	p.FormFactor = "Custom"
	p.Size = Vector3.new(1.5,0.2,1.5)
	Instance.new("CylinderMesh", p)
	p.BrickColor = BrickColor.new("Really black")
	p.CFrame = CFrame.new(mouse.Hit.p)
	table.insert(_G.positions, p)
else
	for _, p in pairs(_G.positions) do
		Instance.new("Explosion", Workspace).Position = p.Position
		pcall(p.Destroy, p)
	end
	_G.positions = {}
end
	end;
};
kp:Fire(bind)