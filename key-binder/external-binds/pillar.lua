local kp = game.Players.LocalPlayer:WaitForChild("AddKeyBind")
local bind = {
	["name"] = "pillar";
	["key"] = string.byte("p");
	["on_down"] = true;
	["errors"] = {};
	["bind"] = function()
		if _G.pillar == true then return end
		_G.pillar = true
		
		local target = mouse.Hit.p
		local pillar = Instance.new("Part", Workspace)
		pillar.Anchored = true
		pillar.FormFactor = "Custom"
		pillar.Size = Vector3.new(1,0.2,1)
		pillar.CFrame = CFrame.new(target)
		
		for i = 0.2, 5, 0.2 do
			wait()
			pillar.Size = Vector3.new(1,i,1)
			pillar.CFrame = CFrame.new(target) + Vector3.new(0,i/2,0)
		end
		
		game:GetService("Debris"):AddItem(pillar, 15)
		_G.pillar = false
	end;
};
kp:Fire(bind)