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
		
		local torso = player.Character.Torso
		local neck = torso.Neck
		local olShoulder = torso["Left Shoulder"]
		local orShoulder = torso["Right Shoulder"]
		olShoulder.Parent = nil
		orShoulder.Parent = nil
		
		local newlShoulder = Instance.new("Motor6D", torso)
		newlShoulder.Part0 = torso
		newlShoulder.Part1 = player.Character["Left Arm"]
		newlShoulder.MaxVelocity = 0.07
		newlShoulder.DesiredAngle = -math.pi/2
		newlShoulder.C0 = CFrame.new(-1.5, 0.5, 0) * CFrame.fromEulerAnglesXYZ(0, math.rad(-90), 0)
		newlShoulder.C1 = CFrame.new(0, 0.5, 0) * CFrame.fromEulerAnglesXYZ(0, math.rad(-90), 0)
		local newrShoulder = Instance.new("Motor6D", torso)
		newrShoulder.Part0 = torso
		newrShoulder.Part1 = player.Character["Right Arm"]
		newrShoulder.MaxVelocity = 0.07
		newrShoulder.DesiredAngle = math.pi/2
		newrShoulder.C0 = CFrame.new(1.5, 0.5, 0) * CFrame.fromEulerAnglesXYZ(0, math.rad(90), 0)
		newrShoulder.C1 = CFrame.new(0, 0.5, 0) * CFrame.fromEulerAnglesXYZ(0, math.rad(90), 0)
		neck.C0 = CFrame.new(Vector3.new(0,0,0), target - player.Character.Head.Position) + Vector3.new(0,1.5,0)
		neck.C1 = CFrame.new()
		
		for i = 0.2, 5, 0.2 do
			wait()
			pillar.Size = Vector3.new(1,i,1)
			pillar.CFrame = CFrame.new(target) + Vector3.new(0,i/2,0)
			neck.C0 = CFrame.new(Vector3.new(0,0,0), pillar.CFrame.p - player.Character.Head.Position) + Vector3.new(0,1.5,0)
		end
		
		newlShoulder:Destroy()
		newrShoulder:Destroy()
		olShoulder.Parent = torso
		orShoulder.Parent = torso
		neck.C0 = CFrame.new(0,2,0)
		neck.C1 = CFrame.new(0,0.5,0)
		game:GetService("Debris"):AddItem(pillar, 15)
		_G.pillar = false
	end;
};
kp:Fire(bind)