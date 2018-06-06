local kp = game.Players.LocalPlayer:WaitForChild("AddKeyBind")
local bind = {
	["name"] = "test";
	["is_folder"] = true;
	["enabled"] = true;
	["bind"] = {
		{
			["name"] = "1";
			["key"] = 32;
			["on_down"] = true;
			["errors"] = {};
			["bind"] = function() print("down") end;
		};
		{
			["name"] = "2";
			["key"] = 32;
			["on_down"] = false;
			["errors"] = {};
			["bind"] = function() print("up" .. tostring(player)) end;
		};
	};
}
kp:Fire(bind)