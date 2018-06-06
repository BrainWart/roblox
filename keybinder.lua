--[==[
-- CAM - 06-06-2018 - Uploaded to github
-- CAM - 06-06-2018 - Remove loadstring calls
-- CAM - 11-06-2015 - Uploaded to pastebin
]==]--

assert(script.className == "LocalScript", "Script must be local!")
script.Parent = nil

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local bindings

local connections = {}
local current_gui

local safeGlobal = {
	["_VERSION"] = "2.2";
	["crash__"] = function()
		for _, con in pairs(connections) do
			if con.connected then
				con:disconnect()
			end
		end
		
		if current_gui then
			current_gui:Destroy()
		end
	end;
}

function runSnippet(f)
	local fenv = getfenv(f)
	fenv._G = safeGlobal
	fenv.player = player
	fenv.mouse = mouse
	fenv.new = Instance.new
	
	return ypcall(f)
end

local sizes = {
	['Arial'] = {
		['Size14'] = {["a"] = {['x'] = 7, ['y'] = 14};["b"] = {['x'] = 7.49, ['y'] = 14};["c"] = {['x'] = 7, ['y'] = 14};["d"] = {['x'] = 7.5, ['y'] = 14};["e"] = {['x'] = 7, ['y'] = 14};["f"] = {['x'] = 4, ['y'] = 14};["g"] = {['x'] = 7.5, ['y'] = 14};["h"] = {['x'] = 6.99, ['y'] = 14};["i"] = {['x'] = 3, ['y'] = 14};["j"] = {['x'] = 3, ['y'] = 14};["k"] = {['x'] = 6.5, ['y'] = 14};["l"] = {['x'] = 2.99, ['y'] = 14};["m"] = {['x'] = 11, ['y'] = 14};["n"] = {['x'] = 7, ['y'] = 14};["o"] = {['x'] = 7.5, ['y'] = 14};["p"] = {['x'] = 7.5, ['y'] = 14};["q"] = {['x'] = 7.5, ['y'] = 14};["r"] = {['x'] = 4.49, ['y'] = 14};["s"] = {['x'] = 6.5, ['y'] = 14};["t"] = {['x'] = 4, ['y'] = 14};["u"] = {['x'] = 7, ['y'] = 14};["p"] = {['x'] = 7.5, ['y'] = 14};["q"] = {['x'] = 7.5, ['y'] = 14};["x"] = {['x'] = 6.5, ['y'] = 14};["y"] = {['x'] = 6.5, ['y'] = 14};["z"] = {['x'] = 6, ['y'] = 14};["A"] = {['x'] = 8, ['y'] = 14};["B"] = {['x'] = 8.49, ['y'] = 14};["C"] = {['x'] = 9, ['y'] = 14};["D"] = {['x'] = 8.99, ['y'] = 14};["E"] = {['x'] = 8, ['y'] = 14};["F"] = {['x'] = 7.5, ['y'] = 14};["G"] = {['x'] = 9.5, ['y'] = 14};["H"] = {['x'] = 9, ['y'] = 14};["I"] = {['x'] = 3.5, ['y'] = 14};["J"] = {['x'] = 6.49, ['y'] = 14};["K"] = {['x'] = 8.5, ['y'] = 14};["L"] = {['x'] = 7, ['y'] = 14};["M"] = {['x'] = 11, ['y'] = 14};["N"] = {['x'] = 8.99, ['y'] = 14};["O"] = {['x'] = 9.5, ['y'] = 14};["P"] = {['x'] = 8, ['y'] = 14};["Q"] = {['x'] = 9.5, ['y'] = 14};["R"] = {['x'] = 8.5, ['y'] = 14};["S"] = {['x'] = 8, ['y'] = 14};["T"] = {['x'] = 7.49, ['y'] = 14};["U"] = {['x'] = 9, ['y'] = 14};["P"] = {['x'] = 8, ['y'] = 14};["Q"] = {['x'] = 9.5, ['y'] = 14};["X"] = {['x'] = 8, ['y'] = 14};["Y"] = {['x'] = 8, ['y'] = 14};["Z"] = {['x'] = 8, ['y'] = 14};[" "] = {['x'] = 3.5, ['y'] = 14};["`"] = {['x'] = 3, ['y'] = 14};["~"] = {['x'] = 7.5, ['y'] = 14};["1"] = {['x'] = 6.99, ['y'] = 14};["!"] = {['x'] = 3.5, ['y'] = 14};["2"] = {['x'] = 7, ['y'] = 14};["@"] = {['x'] = 10, ['y'] = 14};["3"] = {['x'] = 6.99, ['y'] = 14};["#"] = {['x'] = 7, ['y'] = 14};["4"] = {['x'] = 6.99, ['y'] = 14};["$"] = {['x'] = 7, ['y'] = 14};["5"] = {['x'] = 6.99, ['y'] = 14};["%"] = {['x'] = 12.5, ['y'] = 14};["6"] = {['x'] = 6.99, ['y'] = 14};["^"] = {['x'] = 7.49, ['y'] = 14};["7"] = {['x'] = 7, ['y'] = 14};["&"] = {['x'] = 8, ['y'] = 14};["8"] = {['x'] = 7, ['y'] = 14};["*"] = {['x'] = 4.5, ['y'] = 14};["9"] = {['x'] = 6.99, ['y'] = 14};["("] = {['x'] = 3.5, ['y'] = 14};["0"] = {['x'] = 6.99, ['y'] = 14};[")"] = {['x'] = 3.5, ['y'] = 14};["-"] = {['x'] = 5, ['y'] = 14};["_"] = {['x'] = 6.5, ['y'] = 14};["="] = {['x'] = 7.5, ['y'] = 14};["+"] = {['x'] = 7.5, ['y'] = 14};["\\"] = {['x'] = 4.5, ['y'] = 14};["|"] = {['x'] = 2.99, ['y'] = 14};["]"] = {['x'] = 3.5, ['y'] = 14};["}"] = {['x'] = 4.5, ['y'] = 14};["["] = {['x'] = 3.5, ['y'] = 14};["{"] = {['x'] = 4.49, ['y'] = 14};[";"] = {['x'] = 3.49, ['y'] = 14};[":"] = {['x'] = 3.49, ['y'] = 14};["'"] = {['x'] = 3.5, ['y'] = 14};["\""] = {['x'] = 5.49, ['y'] = 14};[","] = {['x'] = 3.49, ['y'] = 14};["<"] = {['x'] = 7.49, ['y'] = 14};["."] = {['x'] = 3.5, ['y'] = 14};[">"] = {['x'] = 7.5, ['y'] = 14};["/"] = {['x'] = 4.49, ['y'] = 14};["?"] = {['x'] = 6.99, ['y'] = 14};};
		['Size18'] = {["a"] = {['x'] = 9, ['y'] = 18};["b"] = {['x'] = 9.64, ['y'] = 18};["c"] = {['x'] = 9, ['y'] = 18};["d"] = {['x'] = 9.64, ['y'] = 18};["e"] = {['x'] = 9, ['y'] = 18};["f"] = {['x'] = 5.14, ['y'] = 18};["g"] = {['x'] = 9.64, ['y'] = 18};["h"] = {['x'] = 8.99, ['y'] = 18};["i"] = {['x'] = 3.85, ['y'] = 18};["j"] = {['x'] = 3.85, ['y'] = 18};["k"] = {['x'] = 8.35, ['y'] = 18};["l"] = {['x'] = 3.85, ['y'] = 18};["m"] = {['x'] = 14.14, ['y'] = 18};["n"] = {['x'] = 9, ['y'] = 18};["o"] = {['x'] = 9.64, ['y'] = 18};["p"] = {['x'] = 9.64, ['y'] = 18};["q"] = {['x'] = 9.64, ['y'] = 18};["r"] = {['x'] = 5.78, ['y'] = 18};["s"] = {['x'] = 8.35, ['y'] = 18};["t"] = {['x'] = 5.14, ['y'] = 18};["u"] = {['x'] = 9, ['y'] = 18};["p"] = {['x'] = 9.64, ['y'] = 18};["q"] = {['x'] = 9.64, ['y'] = 18};["x"] = {['x'] = 8.35, ['y'] = 18};["y"] = {['x'] = 8.35, ['y'] = 18};["z"] = {['x'] = 7.71, ['y'] = 18};["A"] = {['x'] = 10.28, ['y'] = 18};["B"] = {['x'] = 10.92, ['y'] = 18};["C"] = {['x'] = 11.57, ['y'] = 18};["D"] = {['x'] = 11.57, ['y'] = 18};["E"] = {['x'] = 10.28, ['y'] = 18};["F"] = {['x'] = 9.64, ['y'] = 18};["G"] = {['x'] = 12.21, ['y'] = 18};["H"] = {['x'] = 11.57, ['y'] = 18};["I"] = {['x'] = 4.5, ['y'] = 18};["J"] = {['x'] = 8.35, ['y'] = 18};["K"] = {['x'] = 10.92, ['y'] = 18};["L"] = {['x'] = 9, ['y'] = 18};["M"] = {['x'] = 14.14, ['y'] = 18};["N"] = {['x'] = 11.57, ['y'] = 18};["O"] = {['x'] = 12.21, ['y'] = 18};["P"] = {['x'] = 10.28, ['y'] = 18};["Q"] = {['x'] = 12.21, ['y'] = 18};["R"] = {['x'] = 10.92, ['y'] = 18};["S"] = {['x'] = 10.28, ['y'] = 18};["T"] = {['x'] = 9.64, ['y'] = 18};["U"] = {['x'] = 11.57, ['y'] = 18};["P"] = {['x'] = 10.28, ['y'] = 18};["Q"] = {['x'] = 12.21, ['y'] = 18};["X"] = {['x'] = 10.28, ['y'] = 18};["Y"] = {['x'] = 10.28, ['y'] = 18};["Z"] = {['x'] = 10.28, ['y'] = 18};[" "] = {['x'] = 4.5, ['y'] = 18};["`"] = {['x'] = 3.85, ['y'] = 18};["~"] = {['x'] = 9.64, ['y'] = 18};["1"] = {['x'] = 8.99, ['y'] = 18};["!"] = {['x'] = 4.5, ['y'] = 18};["2"] = {['x'] = 9, ['y'] = 18};["@"] = {['x'] = 12.85, ['y'] = 18};["3"] = {['x'] = 8.99, ['y'] = 18};["#"] = {['x'] = 9, ['y'] = 18};["4"] = {['x'] = 8.99, ['y'] = 18};["$"] = {['x'] = 9, ['y'] = 18};["5"] = {['x'] = 8.99, ['y'] = 18};["%"] = {['x'] = 16.07, ['y'] = 18};["6"] = {['x'] = 8.99, ['y'] = 18};["^"] = {['x'] = 9.64, ['y'] = 18};["7"] = {['x'] = 9, ['y'] = 18};["&"] = {['x'] = 10.28, ['y'] = 18};["8"] = {['x'] = 9, ['y'] = 18};["*"] = {['x'] = 5.78, ['y'] = 18};["9"] = {['x'] = 8.99, ['y'] = 18};["("] = {['x'] = 4.5, ['y'] = 18};["0"] = {['x'] = 8.99, ['y'] = 18};[")"] = {['x'] = 4.5, ['y'] = 18};["-"] = {['x'] = 6.42, ['y'] = 18};["_"] = {['x'] = 8.35, ['y'] = 18};["="] = {['x'] = 9.64, ['y'] = 18};["+"] = {['x'] = 9.64, ['y'] = 18};["\\"] = {['x'] = 5.78, ['y'] = 18};["|"] = {['x'] = 3.85, ['y'] = 18};["]"] = {['x'] = 4.5, ['y'] = 18};["}"] = {['x'] = 5.78, ['y'] = 18};["["] = {['x'] = 4.5, ['y'] = 18};["{"] = {['x'] = 5.78, ['y'] = 18};[";"] = {['x'] = 4.49, ['y'] = 18};[":"] = {['x'] = 4.49, ['y'] = 18};["'"] = {['x'] = 4.5, ['y'] = 18};["\""] = {['x'] = 7.07, ['y'] = 18};[","] = {['x'] = 4.49, ['y'] = 18};["<"] = {['x'] = 9.64, ['y'] = 18};["."] = {['x'] = 4.5, ['y'] = 18};[">"] = {['x'] = 9.64, ['y'] = 18};["/"] = {['x'] = 5.78, ['y'] = 18};["?"] = {['x'] = 8.99, ['y'] = 18};};
	};
	['ArialBold'] = {
		['Size14'] = {["a"] = {['x'] = 7.24, ['y'] = 14};["b"] = {['x'] = 7.72, ['y'] = 14};["c"] = {['x'] = 7.24, ['y'] = 14};["d"] = {['x'] = 7.72, ['y'] = 14};["e"] = {['x'] = 7.72, ['y'] = 14};["f"] = {['x'] = 4.82, ['y'] = 14};["g"] = {['x'] = 7.72, ['y'] = 14};["h"] = {['x'] = 7.72, ['y'] = 14};["i"] = {['x'] = 3.86, ['y'] = 14};["j"] = {['x'] = 3.86, ['y'] = 14};["k"] = {['x'] = 7.24, ['y'] = 14};["l"] = {['x'] = 3.86, ['y'] = 14};["m"] = {['x'] = 11.1, ['y'] = 14};["n"] = {['x'] = 7.72, ['y'] = 14};["o"] = {['x'] = 7.72, ['y'] = 14};["p"] = {['x'] = 7.72, ['y'] = 14};["q"] = {['x'] = 7.72, ['y'] = 14};["r"] = {['x'] = 5.31, ['y'] = 14};["s"] = {['x'] = 6.75, ['y'] = 14};["t"] = {['x'] = 4.82, ['y'] = 14};["u"] = {['x'] = 7.72, ['y'] = 14};["p"] = {['x'] = 7.72, ['y'] = 14};["q"] = {['x'] = 7.72, ['y'] = 14};["x"] = {['x'] = 6.75, ['y'] = 14};["y"] = {['x'] = 6.75, ['y'] = 14};["z"] = {['x'] = 6.75, ['y'] = 14};["A"] = {['x'] = 8.68, ['y'] = 14};["B"] = {['x'] = 8.68, ['y'] = 14};["C"] = {['x'] = 9.17, ['y'] = 14};["D"] = {['x'] = 9.17, ['y'] = 14};["E"] = {['x'] = 8.2, ['y'] = 14};["F"] = {['x'] = 7.72, ['y'] = 14};["G"] = {['x'] = 9.65, ['y'] = 14};["H"] = {['x'] = 9.17, ['y'] = 14};["I"] = {['x'] = 3.86, ['y'] = 14};["J"] = {['x'] = 7.24, ['y'] = 14};["K"] = {['x'] = 9.17, ['y'] = 14};["L"] = {['x'] = 7.72, ['y'] = 14};["M"] = {['x'] = 11.1, ['y'] = 14};["N"] = {['x'] = 9.17, ['y'] = 14};["O"] = {['x'] = 9.65, ['y'] = 14};["P"] = {['x'] = 8.2, ['y'] = 14};["Q"] = {['x'] = 9.65, ['y'] = 14};["R"] = {['x'] = 8.68, ['y'] = 14};["S"] = {['x'] = 8.2, ['y'] = 14};["T"] = {['x'] = 7.72, ['y'] = 14};["U"] = {['x'] = 9.17, ['y'] = 14};["P"] = {['x'] = 8.2, ['y'] = 14};["Q"] = {['x'] = 9.65, ['y'] = 14};["X"] = {['x'] = 8.68, ['y'] = 14};["Y"] = {['x'] = 8.2, ['y'] = 14};["Z"] = {['x'] = 8.2, ['y'] = 14};[" "] = {['x'] = 3.86, ['y'] = 14};["`"] = {['x'] = 3.86, ['y'] = 14};["~"] = {['x'] = 7.24, ['y'] = 14};["1"] = {['x'] = 7.72, ['y'] = 14};["!"] = {['x'] = 3.86, ['y'] = 14};["2"] = {['x'] = 7.72, ['y'] = 14};["@"] = {['x'] = 9.65, ['y'] = 14};["3"] = {['x'] = 7.72, ['y'] = 14};["#"] = {['x'] = 7.72, ['y'] = 14};["4"] = {['x'] = 7.72, ['y'] = 14};["$"] = {['x'] = 7.72, ['y'] = 14};["5"] = {['x'] = 7.72, ['y'] = 14};["%"] = {['x'] = 12.55, ['y'] = 14};["6"] = {['x'] = 7.72, ['y'] = 14};["^"] = {['x'] = 7.24, ['y'] = 14};["7"] = {['x'] = 7.72, ['y'] = 14};["&"] = {['x'] = 8.68, ['y'] = 14};["8"] = {['x'] = 7.72, ['y'] = 14};["*"] = {['x'] = 5.31, ['y'] = 14};["9"] = {['x'] = 7.72, ['y'] = 14};["("] = {['x'] = 3.86, ['y'] = 14};["0"] = {['x'] = 7.72, ['y'] = 14};[")"] = {['x'] = 3.86, ['y'] = 14};["-"] = {['x'] = 5.31, ['y'] = 14};["_"] = {['x'] = 6.27, ['y'] = 14};["="] = {['x'] = 7.24, ['y'] = 14};["+"] = {['x'] = 7.24, ['y'] = 14};["\\"] = {['x'] = 5.31, ['y'] = 14};["|"] = {['x'] = 2.89, ['y'] = 14};["]"] = {['x'] = 4.82, ['y'] = 14};["}"] = {['x'] = 4.82, ['y'] = 14};["["] = {['x'] = 4.82, ['y'] = 14};["{"] = {['x'] = 4.82, ['y'] = 14};[";"] = {['x'] = 3.86, ['y'] = 14};[":"] = {['x'] = 3.86, ['y'] = 14};["'"] = {['x'] = 3.86, ['y'] = 14};["\""] = {['x'] = 6.27, ['y'] = 14};[","] = {['x'] = 3.86, ['y'] = 14};["<"] = {['x'] = 7.24, ['y'] = 14};["."] = {['x'] = 3.86, ['y'] = 14};[">"] = {['x'] = 7.24, ['y'] = 14};["/"] = {['x'] = 5.31, ['y'] = 14};["?"] = {['x'] = 7.24, ['y'] = 14};};
		['Size18'] = {["a"] = {['x'] = 9.31, ['y'] = 18};["b"] = {['x'] = 9.93, ['y'] = 18};["c"] = {['x'] = 9.31, ['y'] = 18};["d"] = {['x'] = 9.93, ['y'] = 18};["e"] = {['x'] = 9.93, ['y'] = 18};["f"] = {['x'] = 6.2, ['y'] = 18};["g"] = {['x'] = 9.93, ['y'] = 18};["h"] = {['x'] = 9.93, ['y'] = 18};["i"] = {['x'] = 4.96, ['y'] = 18};["j"] = {['x'] = 4.96, ['y'] = 18};["k"] = {['x'] = 9.31, ['y'] = 18};["l"] = {['x'] = 4.96, ['y'] = 18};["m"] = {['x'] = 14.27, ['y'] = 18};["n"] = {['x'] = 9.93, ['y'] = 18};["o"] = {['x'] = 9.93, ['y'] = 18};["p"] = {['x'] = 9.93, ['y'] = 18};["q"] = {['x'] = 9.93, ['y'] = 18};["r"] = {['x'] = 6.82, ['y'] = 18};["s"] = {['x'] = 8.68, ['y'] = 18};["t"] = {['x'] = 6.2, ['y'] = 18};["u"] = {['x'] = 9.93, ['y'] = 18};["p"] = {['x'] = 9.93, ['y'] = 18};["q"] = {['x'] = 9.93, ['y'] = 18};["x"] = {['x'] = 8.68, ['y'] = 18};["y"] = {['x'] = 8.68, ['y'] = 18};["z"] = {['x'] = 8.68, ['y'] = 18};["A"] = {['x'] = 11.17, ['y'] = 18};["B"] = {['x'] = 11.17, ['y'] = 18};["C"] = {['x'] = 11.79, ['y'] = 18};["D"] = {['x'] = 11.79, ['y'] = 18};["E"] = {['x'] = 10.55, ['y'] = 18};["F"] = {['x'] = 9.93, ['y'] = 18};["G"] = {['x'] = 12.41, ['y'] = 18};["H"] = {['x'] = 11.79, ['y'] = 18};["I"] = {['x'] = 4.96, ['y'] = 18};["J"] = {['x'] = 9.31, ['y'] = 18};["K"] = {['x'] = 11.79, ['y'] = 18};["L"] = {['x'] = 9.93, ['y'] = 18};["M"] = {['x'] = 14.27, ['y'] = 18};["N"] = {['x'] = 11.79, ['y'] = 18};["O"] = {['x'] = 12.41, ['y'] = 18};["P"] = {['x'] = 10.55, ['y'] = 18};["Q"] = {['x'] = 12.41, ['y'] = 18};["R"] = {['x'] = 11.17, ['y'] = 18};["S"] = {['x'] = 10.55, ['y'] = 18};["T"] = {['x'] = 9.93, ['y'] = 18};["U"] = {['x'] = 11.79, ['y'] = 18};["P"] = {['x'] = 10.55, ['y'] = 18};["Q"] = {['x'] = 12.41, ['y'] = 18};["X"] = {['x'] = 11.17, ['y'] = 18};["Y"] = {['x'] = 10.55, ['y'] = 18};["Z"] = {['x'] = 10.55, ['y'] = 18};[" "] = {['x'] = 4.96, ['y'] = 18};["`"] = {['x'] = 4.96, ['y'] = 18};["~"] = {['x'] = 9.31, ['y'] = 18};["1"] = {['x'] = 9.93, ['y'] = 18};["!"] = {['x'] = 4.96, ['y'] = 18};["2"] = {['x'] = 9.93, ['y'] = 18};["@"] = {['x'] = 12.41, ['y'] = 18};["3"] = {['x'] = 9.93, ['y'] = 18};["#"] = {['x'] = 9.93, ['y'] = 18};["4"] = {['x'] = 9.93, ['y'] = 18};["$"] = {['x'] = 9.93, ['y'] = 18};["5"] = {['x'] = 9.93, ['y'] = 18};["%"] = {['x'] = 16.13, ['y'] = 18};["6"] = {['x'] = 9.93, ['y'] = 18};["^"] = {['x'] = 9.31, ['y'] = 18};["7"] = {['x'] = 9.93, ['y'] = 18};["&"] = {['x'] = 11.17, ['y'] = 18};["8"] = {['x'] = 9.93, ['y'] = 18};["*"] = {['x'] = 6.82, ['y'] = 18};["9"] = {['x'] = 9.93, ['y'] = 18};["("] = {['x'] = 4.96, ['y'] = 18};["0"] = {['x'] = 9.93, ['y'] = 18};[")"] = {['x'] = 4.96, ['y'] = 18};["-"] = {['x'] = 6.82, ['y'] = 18};["_"] = {['x'] = 8.06, ['y'] = 18};["="] = {['x'] = 9.31, ['y'] = 18};["+"] = {['x'] = 9.31, ['y'] = 18};["\\"] = {['x'] = 6.82, ['y'] = 18};["|"] = {['x'] = 3.72, ['y'] = 18};["]"] = {['x'] = 6.2, ['y'] = 18};["}"] = {['x'] = 6.2, ['y'] = 18};["["] = {['x'] = 6.2, ['y'] = 18};["{"] = {['x'] = 6.2, ['y'] = 18};[";"] = {['x'] = 4.96, ['y'] = 18};[":"] = {['x'] = 4.96, ['y'] = 18};["'"] = {['x'] = 4.96, ['y'] = 18};["\""] = {['x'] = 8.06, ['y'] = 18};[","] = {['x'] = 4.96, ['y'] = 18};["<"] = {['x'] = 9.31, ['y'] = 18};["."] = {['x'] = 4.96, ['y'] = 18};[">"] = {['x'] = 9.31, ['y'] = 18};["/"] = {['x'] = 6.82, ['y'] = 18};["?"] = {['x'] = 9.31, ['y'] = 18};};
	};
}

function GetSize(font, size, str)
	if sizes[font] then
		if sizes[font][size] then
			local x = 0
			local y = 0
			for char in string.gmatch(str, "(.)") do
				if sizes[font][size][char] then
					x = x + sizes[font][size][char].x
					y = sizes[font][size][char].y
				end
			end
			return setmetatable({['x'] = x, ['y'] = y}, {__tostring = function(tab) return ("{"..tab.x..","..tab.y.."}") end})
		else
			error("Invalid size")
		end
	else
		error("Invalid font")
	end
end

function NeededHeight(font, size, str, max_width)
	if str == "" then return 0 end
	
	local words = {}
	local height = 0
	for word in str:gmatch("([^%s]+%s*)") do
		table.insert(words, GetSize(font, size, word))
	end
	
	local needed_height = words[1].y
	
	local clength = 0
	for i = 1, #words do
		clength = clength + words[i].x
		
		if clength > max_width then
			needed_height = needed_height + words[i].y
			clength = words[i].x
		end
	end
	return needed_height
end

DisableKeyEvents = nil
do -- Mouse connections
	bindings = {
		{
			["name"] = "zoom";
			["is_folder"] = true;
			["enabled"] = true;
			["bind"] = {
				{
					["name"] = "zoom out";
					["key"] = 50;
					["on_down"] = false;
					["errors"] = {};
					["bind"] = function() Workspace.CurrentCamera.FieldOfView = 70 end;
				};
				{
					["name"] = "zoom in";
					["key"] = 50;
					["on_down"] = true;
					["errors"] = {};
					["bind"] = function() Workspace.CurrentCamera.FieldOfView = 20 end;
				};
			};
		};
		{
			["name"] = "run";
			["is_folder"] = true;
			["enabled"] = true;
			["bind"] = {
				{
					["name"] = "run";
					["key"] = 48;
					["on_down"] = true;
					["errors"] = {};
					["bind"] = function() player.Character.Humanoid.WalkSpeed = 32 end;
				};
				{
					["name"] = "walk";
					["key"] = 48;
					["on_down"] = false;
					["errors"] = {};
					["bind"] = function() player.Character.Humanoid.WalkSpeed = 16 end;
				};
			};
		};
		{
			["name"] = "hover";
			["key"] = string.byte("h");
			["on_down"] = false;
			["errors"] = {};
			["bind"] = function()
if player.Character == nil or not (player.Character:FindFirstChild("Torso") or player.Character:FindFirstChild("HumanoidRootPart")) then return end
local bp = (player.Character:FindFirstChild("Torso") or player.Character:FindFirstChild("HumanoidRootPart")):FindFirstChild("BodyPosition")
if bp then
	bp:Destroy()
else
	local bp = Instance.new("BodyPosition", player.Character.Torso)
	bp.maxForce = Vector3.new(0,1e100,0)
	bp.position = player.Character.Torso.Position
end
			end;
		};
		{
			["name"] = "teleport";
			["key"] = string.byte("t");
			["on_down"] = true;
			["errors"] = {};
			["bind"] = function()
if (player.Character:GetModelCFrame().p - mouse.Hit.p).magnitude < 750 then
	player.Character:MoveTo(mouse.Hit.p)
end
			end;
		};
		{
			["name"] = "explode";
			["key"] = string.byte("x");
			["on_down"] = true;
			["errors"] = {};
			["bind"] = function()
Instance.new("Explosion", Workspace).Position = mouse.Hit.p
			end;
		};
		{
			["name"] = "remove";
			["key"] = 0;
			["on_down"] = true;
			["errors"] = {};
			["bind"] = function()
_G.crash__()
			end;
		};
	}

	local AddBindEvent = Instance.new("BindableEvent", game.Players.LocalPlayer)
	AddBindEvent.Name = "AddKeyBind"
	AddBindEvent.Event:connect(function(bind)
		table.insert(bindings, bind)
	end)

	local disabled = false
	DisableKeyEvents = function(bool)
		disabled = bool
	end
	
	table.insert(connections, mouse.KeyUp:connect(function(key)
		if disabled then return end
		local key = string.byte(key)
		
		local function check_bindings(bindings_table)
			for i = 1, #bindings_table do
				local tab = bindings_table[i]
				
				if tab.is_folder and tab.enabled then
					check_bindings(tab.bind)
				elseif tab.key == key and not tab.on_down then
					local ran, err = runSnippet(tab.bind)
					if not ran then
						table.insert(tab.errors, err)
					end
				end
			end
		end
		check_bindings(bindings)
	end))

	table.insert(connections, mouse.KeyDown:connect(function(key)
		if disabled then return end
		local key = string.byte(key)
		
		local function check_bindings(bindings_table)
			for i = 1, #bindings_table do
				local tab = bindings_table[i]
				
				if tab.is_folder and tab.enabled then
					check_bindings(tab.bind)
				elseif tab.key == key and tab.on_down then
					local ran, err = runSnippet(tab.bind)
					if not ran then
						table.insert(tab.errors, err)
					end
				end
			end
		end
		check_bindings(bindings)
	end))
end

local GetGui
do
	local gui = Instance.new("ScreenGui")
		gui.Name = "Key Binding Gui"
	do -- main
		local frame = Instance.new("Frame", gui)
			frame.Name = "Main"
			frame.Position = UDim2.new(1,-175,0.5,-100)
			frame.Size = UDim2.new(0,150,0,30)
			frame.BackgroundColor3 = Color3.new(0.5,0.5,0.5)
			frame.BackgroundTransparency = 0.4
			frame.BorderColor3 = Color3.new(0.1,0.1,0.1)
			frame.Active = true
			frame.Draggable = true
		
		local transparencyHandler = Instance.new("Frame", frame)
			transparencyHandler.Name = "Transparency_Handler"
			transparencyHandler.BackgroundTransparency = 1
			transparencyHandler.Size = UDim2.new(0,160,0,60)
			transparencyHandler.Position = UDim2.new(0,-5,0,-5)
		
		local title = Instance.new("TextLabel", frame)
			title.Name = "Title"
			title.Text = "Key Bindings"
			title.Font = "ArialBold"
			title.FontSize = 6
			title.Position = UDim2.new(0.5,0,0.5,0)
			title.TextColor3 = Color3.new(0.1,0.1,0.1)
			title.TextTransparency = 0.4
			title.BorderSizePixel = 0
			
		local newButton = Instance.new("TextButton", frame)
			newButton.Name = "NewButton"
			newButton.Size = UDim2.new(0,100,0,15)
			newButton.Font = "Arial"
			newButton.FontSize = 5
			newButton.Text = "New Bind"
			newButton.TextYAlignment = "Top"
			newButton.TextColor3 = Color3.new(0.1,0.1,0.1)
			newButton.TextTransparency = 0.4
			newButton.Position = UDim2.new(0,25,0,35)
			newButton.BackgroundColor3 = Color3.new(0.5,0.5,0.5)
			newButton.BackgroundTransparency = 0.4
			newButton.BorderColor3 = Color3.new(0.1,0.1,0.1)
	end
	
	do -- Edit
		local frame = Instance.new("Frame", gui)
			frame.Name = "Edit"
			frame.Position = UDim2.new(0.5,-100,0.5,-75)
			frame.Size = UDim2.new(0,200,0,87)
			frame.BackgroundColor3 = Color3.new(0.5,0.5,0.5)
			frame.BackgroundTransparency = 0.4
			frame.BorderColor3 = Color3.new(0.1,0.1,0.1)
			frame.Active = false
			frame.Draggable = true
			frame.Visible = false
		
		local transparencyHandler = Instance.new("Frame", frame)
			transparencyHandler.Name = "Transparency_Handler"
			transparencyHandler.BackgroundTransparency = 1
			transparencyHandler.Size = UDim2.new(1,10,1,10)
			transparencyHandler.Position = UDim2.new(0,-5,0,-5)
			
		local title = Instance.new("TextLabel", frame)
			title.Name = "Title"
			title.Text = "Edit Binding"
			title.Font = "ArialBold"
			title.FontSize = 6
			title.Position = UDim2.new(0.5,0,0,12)
			title.TextColor3 = Color3.new(0.1,0.1,0.1)
			title.TextTransparency = 0.4
		
		local label1 = Instance.new("TextLabel", frame)
			label1.Name = "label1"
			label1.Text = "Name:"
			label1.Font = "Arial"
			label1.BorderSizePixel = 0
			label1.FontSize = 5
			label1.Position = UDim2.new(0,5,0,33)
			label1.TextXAlignment = "Left"
			label1.TextColor3 = Color3.new(0.1,0.1,0.1)
			label1.TextTransparency = 0.4
		
		local textbox1 = Instance.new("TextBox", frame)
			textbox1.Name = "textbox1"
			textbox1.Text = ""
			textbox1.Font = "Arial"
			textbox1.FontSize = 5
			textbox1.Position = UDim2.new(0,45,0,27)
			textbox1.Size = UDim2.new(0,150,0,15)
			textbox1.BackgroundColor3 = Color3.new(0.5,0.5,0.5)
			textbox1.BackgroundTransparency = 0.4
			textbox1.TextColor3 = Color3.new(0.1,0.1,0.1)
			textbox1.TextTransparency = 0.4
			
		local textbutton1 = Instance.new("TextButton", frame)
			textbutton1.Name = "textbutton1"
			textbutton1.Text = "Key Down"
			textbutton1.Font = "Arial"
			textbutton1.FontSize = 5
			textbutton1.Position = UDim2.new(0,5,0,47)
			textbutton1.Size = UDim2.new(0,92,0,15)
			textbutton1.BackgroundColor3 = Color3.new(0.5,0.5,0.5)
			textbutton1.BackgroundTransparency = 0.4
			textbutton1.TextColor3 = Color3.new(0.1,0.1,0.1)
			textbutton1.TextTransparency = 0.4
		
		local textbutton2 = Instance.new("TextButton", frame)
			textbutton2.Name = "textbutton2"
			textbutton2.Text = "Select Key"
			textbutton2.Font = "Arial"
			textbutton2.FontSize = 5
			textbutton2.Position = UDim2.new(1,-97,0,47)
			textbutton2.Size = UDim2.new(0,92,0,15)
			textbutton2.BackgroundColor3 = Color3.new(0.5,0.5,0.5)
			textbutton2.BackgroundTransparency = 0.4
			textbutton2.TextColor3 = Color3.new(0.1,0.1,0.1)
			textbutton2.TextTransparency = 0.4
		
		local textbutton3 = Instance.new("TextButton", frame)
			textbutton3.Name = "textbutton3"
			textbutton3.Text = "Done"
			textbutton3.Font = "Arial"
			textbutton3.FontSize = 5
			textbutton3.Position = UDim2.new(0,135,1,-20)
			textbutton3.Size = UDim2.new(0,60,0,15)
			textbutton3.BackgroundColor3 = Color3.new(0.5,0.5,0.5)
			textbutton3.BackgroundTransparency = 0.4
			textbutton3.TextColor3 = Color3.new(0.1,0.1,0.1)
			textbutton3.TextTransparency = 0.4
		
		local textbutton4 = Instance.new("TextButton", frame)
			textbutton4.Name = "textbutton4"
			textbutton4.Text = "Cancel"
			textbutton4.Font = "Arial"
			textbutton4.FontSize = 5
			textbutton4.Position = UDim2.new(0,70,1,-20)
			textbutton4.Size = UDim2.new(0,60,0,15)
			textbutton4.BackgroundColor3 = Color3.new(0.5,0.5,0.5)
			textbutton4.BackgroundTransparency = 0.4
			textbutton4.TextColor3 = Color3.new(0.1,0.1,0.1)
			textbutton4.TextTransparency = 0.4
		
		local textbutton5 = Instance.new("TextButton", frame)
			textbutton5.Name = "textbutton5"
			textbutton5.Text = "Remove"
			textbutton5.Font = "Arial"
			textbutton5.FontSize = 5
			textbutton5.Position = UDim2.new(0,5,1,-20)
			textbutton5.Size = UDim2.new(0,60,0,15)
			textbutton5.BackgroundColor3 = Color3.new(0.5,0.5,0.5)
			textbutton5.BackgroundTransparency = 0.4
			textbutton5.TextColor3 = Color3.new(0.1,0.1,0.1)
			textbutton5.TextTransparency = 0.4
	end
	
	local bindButton = Instance.new("TextButton")
		bindButton.Size = UDim2.new(0,140,0,15)
		bindButton.Font = "Arial"
		bindButton.FontSize = 5
		bindButton.TextWrapped = true
		bindButton.Text = "Name [key]"
		bindButton.TextYAlignment = "Top"
		bindButton.TextColor3 = Color3.new(0.1,0.1,0.1)
		bindButton.TextTransparency = 0.4
		bindButton.Position = UDim2.new(0,0,0,0)
		bindButton.BackgroundColor3 = Color3.new(0.5,0.5,0.5)
		bindButton.BackgroundTransparency = 0.4
		bindButton.BorderColor3 = Color3.new(0.1,0.1,0.1)
	
	function GetGui()
		local g = gui:Clone()
		
		local current_bind
		
		local refresh
		local editing_folder = false
		local edit_frame = g.Edit
		local edit_transparencyHandler = edit_frame.Transparency_Handler
		local edit_title = edit_frame.Title
		local name_area = edit_frame.textbox1
		local onkeydown = edit_frame.textbutton1
		local done_button = edit_frame.textbutton3
		local cancel_button = edit_frame.textbutton4
		local remove_button = edit_frame.textbutton5
		local select_key = edit_frame.textbutton2
		local text = {edit_title, edit_frame.label1, edit_frame.textbox1,
			edit_frame.textbutton1, edit_frame.textbutton2, done_button, remove_button, cancel_button}
		local bg = {edit_frame, edit_frame.textbox1, edit_frame.textbutton1, edit_frame.textbutton2,
			done_button, remove_button, cancel_button}
		
		edit_frame.DragStopped:connect(function() gui.Edit.Position = edit_frame.Position end)
		done_button.MouseButton1Click:connect(function()
			current_bind.name = name_area.Text
			current_bind.errors = {}
			current_bind = nil
			
			refresh()
			
			edit_frame.Active = false
			edit_frame.Visible = false
			DisableKeyEvents(false)
		end)
		cancel_button.MouseButton1Click:connect(function()
			current_bind = nil
			edit_frame.Active = false
			edit_frame.Visible = false
			DisableKeyEvents(false)
		end)
		remove_button.MouseButton1Click:connect(function()
			for _, t in pairs(bindings) do
				if t == current_bind then
					table.remove(bindings, _)
					break
				end
			end
			
			current_bind = nil
			edit_frame.Active = false
			edit_frame.Visible = false
			
			refresh()
			DisableKeyEvents(false)
		end)
		onkeydown.MouseButton1Click:connect(function()
			if current_bind then
				if onkeydown.Text == "Folder" then
					current_bind.is_folder = false
					
					current_bind.on_down = true
					onkeydown.Text = "Key Down"
				elseif onkeydown.Text == "Key Down" then
					current_bind.on_down = false
					onkeydown.Text = "Key Up"
				else
					current_bind.is_folder = true
					
					onkeydown.Text = "Folder"
				end
			end
		end)
		local key_connection
		select_key.MouseButton1Click:connect(function()
			if not editing_folder then
				if current_bind then
					if key_connection then
						current_bind.key = 0
						select_key.Text = "Current: none"
						key_connection:disconnect()
						key_connection = nil
						return
					end
				
					select_key.Text = "Press Key"
					
					key_connection = mouse.KeyDown:connect(function(key)
						local key_code = string.byte(key)
						
						current_bind.key = key_code
						select_key.Text = ("Current: %s"):format(key:match("%a") and ("'%s'"):format(key) or key_code)
						key_connection:disconnect()
						key_connection = nil
					end)
				end
			else
				current_bind.enabled = not current_bind.enabled
				select_key.Text = "Enabled: " .. tostring(current_bind.enabled)
			end
		end)
		
		edit_transparencyHandler.MouseEnter:connect(function()
			for _, o in pairs(text) do
				o.TextTransparency = 0.1
			end
			for _, o in pairs(bg) do
				o.BackgroundTransparency = 0.1
			end
		end)
		edit_transparencyHandler.MouseLeave:connect(function()
			for _, o in pairs(text) do
				o.TextTransparency = 0.4
			end
			for _, o in pairs(bg) do
				o.BackgroundTransparency = 0.4
			end
		end)
		
		function edit(tab)
			edit_frame.Active = true
			edit_frame.Visible = true
			
			current_bind = tab
			
			name_area.Text = current_bind.name
			if tab.is_folder then
			else
				local key_char = string.char(tab.key)
				local key_text = tostring(key_char:match("%a") and ("'%s'"):format(key_char) or tab.key)
				if key_text == "0" then key_text = "none" end
				
				select_key.Text = ("Current: %s"):format(key_text)
				onkeydown.Text = current_bind.on_down and "Key Down" or "Key Up"
			end
		end
		
		local frame = g.Main
		local newButton = frame.NewButton
		local title = frame.Title
		local transparencyHandler = frame.Transparency_Handler
		local button_frame = nil
		
		frame.DragStopped:connect(function() gui.Main.Position = frame.Position end)
		newButton.MouseButton1Click:connect(function()
			local tab = {
				["name"] = "none";
				["key"] = 0;
				["on_down"] = true;
				["errors"] = {};
				["bind"] = "";
			}
			edit(tab)
			
			table.insert(bindings, tab)
		end)
		
		transparencyHandler.MouseEnter:connect(function()
			frame.BackgroundTransparency = 0.1
			newButton.BackgroundTransparency = 0.1
			newButton.TextTransparency = 0.1
			title.TextTransparency = 0.1
			
			if button_frame then
				button_frame.SetTransparency(0.1)
			end
		end)
		transparencyHandler.MouseLeave:connect(function()
			frame.BackgroundTransparency = 0.4
			newButton.BackgroundTransparency = 0.4
			newButton.TextTransparency = 0.4
			title.TextTransparency = 0.4
			
			if button_frame then
				button_frame.SetTransparency(0.4)
			end
		end)
		
		refresh = function()
			if button_frame then
				button_frame:Destroy()
				button_frame = nil
			end
			
			local function make_bind_button(tab)
				local key_char = string.char(tab.key)
				local key_text = tostring(key_char:match("%a") and ("'%s'"):format(key_char) or tab.key)
				if key_text == "0" then key_text = "none" end
				
				local button = bindButton:Clone()
					button.Text = ("%s [%s]"):format(tab.name, key_text)
				
				button.MouseButton1Click:connect(function()
					local ran, err = runSnippet(tab.bind)
					if not ran then
						table.insert(tab.errors, err)
					end
				end)
				button.MouseButton2Click:connect(function()
					edit(tab)
					DisableKeyEvents(true)
				end)
				
				return button
			end
			
			local function make_buttons(binding_table)
				local buttons = {}
				local move_down = nil
				
				local frame = Instance.new("Frame")
					frame.BackgroundTransparency = 1
				
				local height = 0
				for i = 1, #binding_table do
					local tab = binding_table[i]
					
					if tab.is_folder then
						local folder_frame = make_buttons(tab.bind)
							folder_frame.Visible = false
						
						local button = bindButton:Clone()
							button.Text = tab.name
							button.Font = "ArialBold"
							button.Size = UDim2.new(0,140,0,NeededHeight("ArialBold", "Size14", button.Text, 140) + 1)
							button.Position = UDim2.new(0,0,0,height)
						
						height = height + button.Size.Y.Offset + 5
						
						folder_frame.Position = UDim2.new(0,10,0,button.Size.Y.Offset + 5)
						folder_frame.Parent = button
						
						local function move_below(down)
							if down then
								for b = (i+1), #buttons do
									local but = buttons[b]
									but.Position = UDim2.new(0,but.Position.X.Offset,0,but.Position.Y.Offset + (folder_frame.Size.Y.Offset + 5))
								end
							else
								for b = (i+1), #buttons do
									local but = buttons[b]
									but.Position = UDim2.new(0,but.Position.X.Offset,0,but.Position.Y.Offset - (folder_frame.Size.Y.Offset + 5))
								end
							end
							if move_down then move_down(down) end
						end
						folder_frame.MoveDown = move_below
						local open = false
						
						button.MouseButton1Click:connect(function()
							open = not open
							if open then
								button.Position = UDim2.new(0,-5,0,button.Position.Y.Offset)
								
								move_below(true)
								
								transparencyHandler.Size = UDim2.new(0,160,0,transparencyHandler.Size.Y.Offset + (folder_frame.Size.Y.Offset + 5))
								newButton.Position = UDim2.new(0,newButton.Position.X.Offset,0,newButton.Position.Y.Offset + (folder_frame.Size.Y.Offset + 5))
								folder_frame.Visible = true
							else
								button.Position = UDim2.new(0,0,0,button.Position.Y.Offset)
								
								move_below(false)
								
								transparencyHandler.Size = UDim2.new(0,160,0,transparencyHandler.Size.Y.Offset - (folder_frame.Size.Y.Offset + 5))
								newButton.Position = UDim2.new(0,newButton.Position.X.Offset,0,newButton.Position.Y.Offset - (folder_frame.Size.Y.Offset + 5))
								folder_frame.Visible = false
							end
						end)
						button.MouseButton2Click:connect(function()
							edit(tab)
						end)
						
						button.Parent = frame
						
						local cObj = newproxy(true)
						local meta = getmetatable(cObj)
						meta.__metatable = "This metatable is locked"
						meta.__index = function(tab, ind)
							return button[ind]
						end
						meta.__newindex = function(tab, ind, val)
							if ind == "BackgroundTransparency" then
								folder_frame.BackgroundTransparency = val
							elseif ind == "TextTransparency" then
								folder_frame.TextTransparency = val
							end
							button[ind] = val
						end
						
						table.insert(buttons, cObj)
					else
						local button = make_bind_button(tab)
							button.Size = UDim2.new(0,140,0,NeededHeight("Arial", "Size14", button.Text, 140) + 1)
							button.Position = UDim2.new(0,0,0,height)
						
						height = height + button.Size.Y.Offset + 5
						
						button.Parent = frame
						table.insert(buttons, button)
					end
				end
				
				frame.Size = UDim2.new(0,140,0,height - 5)
				
				local cObj = newproxy(true)
				local meta = getmetatable(cObj)
				meta.__metatable = "This metatable is locked"
				meta.__index = function(tab, ind)
					if ind == "SetTransparency" then
						return function(val)
							for _, b in pairs(buttons) do
								b.BackgroundTransparency = val
								b.TextTransparency = val
							end
						end
					elseif type(frame[ind]) == "function" then
						return function(...) frame[ind](frame, ...) end
					end
					return frame[ind]
				end
				meta.__newindex = function(tab, ind, val)
					if ind == "BackgroundTransparency" then
						for _, b in pairs(buttons) do
							b.BackgroundTransparency = val
						end
						return
					elseif ind == "TextTransparency" then
						for _, b in pairs(buttons) do
							b.TextTransparency = val
						end
						return
					elseif ind == "MoveDown" then
						move_down = val
						return
					end
					frame[ind] = val
				end
				
				return cObj
			end
			
			button_frame = make_buttons(bindings)
			button_frame.Parent = frame
			button_frame.Position = UDim2.new(0,5,0,35)
			transparencyHandler.Size = UDim2.new(0,160,0,button_frame.Size.Y.Offset + transparencyHandler.Size.Y.Offset + 5)
			newButton.Position = UDim2.new(0,25,0,button_frame.Size.Y.Offset + 40)
		end
		
		refresh()
		
		local cObj = newproxy(true)
		local meta = getmetatable(cObj)
		meta.metatable = "This metatable is locked"
		meta.__index = function(tab, ind)
			if ind:lower() == "refresh" then
				return refresh
			elseif type(g[ind]) == "function" then
				return function(...) g[ind](g, ...) end
			end
			
			return g[ind]
		end
		meta.__newindex = function(tab, ind, val)
			g[ind] = val
		end
		
		return cObj
	end
end

current_gui = GetGui()
current_gui.Parent = game.Players.LocalPlayer.PlayerGui
table.insert(connections, player.CharacterAdded:connect(function(c)
	repeat wait() until c:FindFirstChild("Humanoid")
	
	current_gui = GetGui()
	current_gui.Parent = game.Players.LocalPlayer.PlayerGui
end))