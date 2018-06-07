--[==[
-- CAM - 06-06-2018 - Uploaded to github
-- CAM - 06-07-2013 - Uploaded to pastebin
-- CAM - 05-30-2013 - getSize
-- CAM - 05-30-2013 - _G.printErrors
-- CAM - 05-30-2013 - Character button for characters : [[[PlayerCharacterButton]]]
-- CAM - 05-27-2013 - Add scroll wheel support : [[[ScrollWheel]]]
]==]--

local errorCatcher = {}
do
	function _G.getErrors()
		return errorCatcher.errors
	end
	
	function _G.printErrors()
		if #errorCatcher.errors > 0 then
			table.foreach(errorCatcher.errors, print)
		else
			print("no logged errors")
		end
	end
	
	errorCatcher.errors = {}
	function errorCatcher.checker(func, name)
		return function(...)
			local r, e = ypcall(func, ...)
			if not r then table.insert(errorCatcher.errors, ("ERROR(%s): %s"):format(name or "noref", e)) end
		end
	end
end

local sizes={
	['Arial']={
		['Size12']={["y"]=12,["x"]={["a"]=6;["b"]=6.42;["c"]=6;["d"]=6.42;["e"]=6;["f"]=3.42;["g"]=6.42;["h"]=5.99;["i"]=2.57;["j"]=2.57;["k"]=5.57;["l"]=2.57;["m"]=9.42;["n"]=6;["o"]=6.42;["p"]=6.42;["q"]=6.42;["r"]=3.85;["s"]=5.57;["t"]=3.42;["u"]=6;["p"]=6.42;["q"]=6.42;["x"]=5.57;["y"]=5.57;["z"]=5.14;["A"]=6.85;["B"]=7.28;["C"]=7.71;["D"]=7.71;["E"]=6.85;["F"]=6.42;["G"]=8.14;["H"]=7.71;["I"]=3;["J"]=5.57;["K"]=7.28;["L"]=6;["M"]=9.42;["N"]=7.71;["O"]=8.14;["P"]=6.85;["Q"]=8.14;["R"]=7.28;["S"]=6.85;["T"]=6.42;["U"]=7.71;["P"]=6.85;["Q"]=8.14;["X"]=6.85;["Y"]=6.85;["Z"]=6.85;[" "]=3;["`"]=2.57;["~"]=6.42;["1"]=5.99;["!"]=3;["2"]=6;["@"]=8.57;["3"]=5.99;["#"]=6;["4"]=5.99;["$"]=6;["5"]=5.99;["%"]=10.71;["6"]=5.99;["^"]=6.42;["7"]=6;["&"]=6.85;["8"]=6;["*"]=3.85;["9"]=5.99;["("]=3;["0"]=5.99;[")"]=3;["-"]=4.28;["_"]=5.57;["="]=6.42;["+"]=6.42;[string.char(92)]=3.85;["|"]=2.57;["]"]=3;["}"]=3.85;["["]=3;["{"]=3.85;[";"]=2.99;[":"]=2.99;["'"]=3;[string.char(34)]=4.71;[","]=2.99;["<"]=6.42;["."]=3;[">"]=6.42;["/"]=3.85;["?"]=5.99;}};
	};
}
function getSize(font, size, str)
	if sizes[font] then
		if sizes[font][size] then
			local x=0
			local y=sizes[font][size].y
			for char in string.gmatch(str, "(.)") do
				if sizes[font][size]['x'][char] then
					x=x+sizes[font][size]['x'][char]
				end
			end
			return setmetatable({['x']=x,['y']=y}, {__tostring=function(tab) return ("{"..tab.x..","..tab.y.."}") end})
		else
			error("Invalid size")
		end
	else
		error("Invalid font")
	end
end

function neededTextLines(font, size, str, width)
	local lines = 1
	for line in string.gmatch(str, "(.+)" .. string.char(10)) do
		lines = lines + math.ceil(getSize(font, size, line).x / width)
	end
	return lines
end

local GameEditor = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
	GameEditor.Name = "GameEditor"

pcall(function()
	GameEditor.Parent = game.CoreGui
	script.Parent = nil
	print(game.Players.LocalPlayer.Name .. " has a higher context!")
end)

local pretty = Instance.new("Frame", GameEditor)
	pretty.Name = "prettifier"
	pretty.Position = UDim2.new(0.5,-100,0.5,-150)
	pretty.Size = UDim2.new(0,200,0,300)
	pretty.Style = Enum.FrameStyle.RobloxRound
	pretty.Active = true
	pretty.Draggable = true

local editor = Instance.new("Frame", pretty)
	editor.Size = UDim2.new(1,0,1,20)
	editor.BorderSizePixel = 0
	editor.BackgroundTransparency = 1
	editor.ClipsDescendants = true

-- explorer
function genExplorerFrame()
	local main = Instance.new("Frame")
		main.Name = "main"
		main.Position = UDim2.new(0,0,0,25)
		main.Size = UDim2.new(1,0,1,-45)
		main.BackgroundColor3 = Color3.new(0,0,0)
		main.BorderColor3 = Color3.new(0,0,0)
		main.BackgroundTransparency = 0.7
		main.BorderSizePixel = 0

	local mainTitle = Instance.new("Frame", main)
		mainTitle.Name = "mainTitle"
		mainTitle.Size = UDim2.new(1,0,0,20)
		mainTitle.BackgroundColor3 = Color3.new(0,0,0)
		mainTitle.Position = UDim2.new(0,0,0,-25)
		mainTitle.BorderColor3 = Color3.new(0,0,0)
		mainTitle.BackgroundTransparency = 0.7
		mainTitle.BorderSizePixel = 0

	local mainTitleTextLabel = Instance.new("TextLabel", mainTitle)
		mainTitleTextLabel.Size = UDim2.new(1,-5,1,0)
		mainTitleTextLabel.Position = UDim2.new(0,5,0,0)
		mainTitleTextLabel.BackgroundTransparency = 1
		mainTitleTextLabel.BorderSizePixel = 0
		mainTitleTextLabel.Text = "Loading.."
		mainTitleTextLabel.Font = Enum.Font.ArialBold
		mainTitleTextLabel.FontSize = Enum.FontSize.Size14
		mainTitleTextLabel.TextStrokeTransparency = 0.7
		mainTitleTextLabel.TextXAlignment = Enum.TextXAlignment.Left
		mainTitleTextLabel.TextColor3 = Color3.new(1,1,1)
		mainTitleTextLabel.TextStrokeColor3 = Color3.new(0.35,0.35,0.35)

	local errorLabel = Instance.new("TextLabel", main)
		errorLabel.Size = UDim2.new(1,-10,0,8)
		errorLabel.Position = UDim2.new(0,5,1,0)
		errorLabel.BackgroundTransparency = 1
		errorLabel.BorderSizePixel = 0
		errorLabel.Text = ""
		errorLabel.Font = Enum.Font.ArialBold
		errorLabel.FontSize = Enum.FontSize.Size9
		errorLabel.TextStrokeTransparency = 0.7
		errorLabel.TextXAlignment = Enum.TextXAlignment.Left
		errorLabel.TextColor3 = Color3.new(1,.5,.5)
		errorLabel.TextStrokeColor3 = Color3.new(0.35,0.15,0.15)
		
	local clipper = Instance.new("Frame", main)
		clipper.Active = true
		clipper.Position = UDim2.new(0,2,0,2)
		clipper.Size = UDim2.new(1,-23,1,-4)
		clipper.BorderSizePixel = 0
		clipper.BackgroundTransparency = 1
		clipper.ClipsDescendants = true

	local positioner = Instance.new("Frame", clipper)
		positioner.Size = UDim2.new(1,0,0,0)
		positioner.BorderSizePixel = 0
		positioner.BackgroundTransparency = 1
		
	local scroll = Instance.new("Frame", main)
		scroll.Active = true
		scroll.Name = "scroll"
		scroll.Position = UDim2.new(1,-19,0,2)
		scroll.Size = UDim2.new(0,17,1,-4)
		scroll.BackgroundColor3 = Color3.new(0,0,0)
		scroll.BorderColor3 = Color3.new(0,0,0)
		scroll.BackgroundTransparency = 0.7
		scroll.BorderSizePixel = 0

	local scrollbar = Instance.new("TextButton", scroll)
		scrollbar.Name = "scrollbar"
		scrollbar.Size = UDim2.new(1,0,0.5,0)
		scrollbar.BackgroundColor3 = Color3.new(0,0,0)
		scrollbar.BorderColor3 = Color3.new(0,0,0)
		scrollbar.BackgroundTransparency = 0.67
		scrollbar.BorderSizePixel = 0
		scrollbar.Text = "-"
		scrollbar.Font = Enum.Font.Arial
		scrollbar.FontSize = Enum.FontSize.Size18
		scrollbar.TextColor3 = Color3.new(1,1,1)
	
	local function getTotalDis()
		local complete_y = -2
		for _, a in pairs(positioner:GetChildren()) do
			complete_y = complete_y + a.Size.Y.Offset + 2
		end
		return complete_y
	end
	
	do -- scroll bar events
		local mouseYOffset = 0
		local scrolling = false
		
		local function scrollf(x, y)
			if scrolling then
				local sy = scrollbar.Position.Y.Offset + (y - mouseYOffset)
				if sy < 0 then
					sy = 0
				elseif sy > (scroll.AbsoluteSize.y - scrollbar.AbsoluteSize.y) then
					sy = scroll.AbsoluteSize.y - scrollbar.AbsoluteSize.y
				end
				scrollbar.Position = UDim2.new(0,0,0,sy)
				
				local scroll_dis = scroll.AbsoluteSize.y - scrollbar.AbsoluteSize.y
				local frame_height = getTotalDis() - clipper.AbsoluteSize.y
				
				positioner.Position = UDim2.new(0,0,0,-frame_height / scroll_dis * sy)
				mouseYOffset = y
			end
		end
		
		local function wheelScroll(data) -- [[[ScrollWheel]]]
			if data.UserInputType == Enum.UserInputType.MouseWheel then
				scrolling = true
				mouseYOffset = 0
				scrollf(0, data.Position.Z * -17)
				scrolling = false
			end
		end
		
		scrollbar.MouseMoved:connect(errorCatcher.checker(scrollf))
		clipper.InputChanged:connect(errorCatcher.checker(wheelScroll))
		scroll.InputChanged:connect(errorCatcher.checker(wheelScroll))

		scrollbar.MouseButton1Up:connect(errorCatcher.checker(function(x, y)
			scrolling = false
		end))
		scrollbar.MouseLeave:connect(errorCatcher.checker(function()
			scrolling = false
		end))
		scrollbar.MouseButton1Down:connect(errorCatcher.checker(function(x, y)
			mouseYOffset = y
			scrolling = true
		end))
	end
	
	local function autosizeSB()
		repeat wait() until clipper.AbsoluteSize.Y > 0
		local derr = clipper.AbsoluteSize.Y / getTotalDis()
		if derr > 1 then derr = 1 end
		scrollbar.Size = UDim2.new(1,0,derr,0)
	end
	
	return {
		["main"] = main;
		["mainTitle"] = mainTitle;
		["mainTitleTextLabel"] = mainTitleTextLabel;
		["clipper"] = clipper;
		["positioner"] = positioner;
		["scroll"] = scroll;
		["scrollbar"] = scrollbar;
		["errorLabel"] = errorLabel;
		["autosizeScrollBar"] = function() coroutine.wrap(autosizeSB)() end;
	}
end

-- context menu
local contextmenu = Instance.new("Frame", pretty)
	contextmenu.Name = "contextmenu"
	contextmenu.Position = UDim2.new(1.1,0,0,0)
	contextmenu.Size = UDim2.new(0,75,0,97)
	contextmenu.BackgroundColor3 = Color3.new(0,0,0)
	contextmenu.BorderColor3 = Color3.new(0,0,0)
	contextmenu.BackgroundTransparency = 0.3
	contextmenu.BorderSizePixel = 0
	contextmenu.Visible = false

local cCut = Instance.new("TextButton", contextmenu)
	cCut.Name = "cut"
	cCut.Position = UDim2.new(0,0,0,2)
	cCut.Size = UDim2.new(1,0,0,17)
	cCut.BackgroundColor3 = Color3.new(0,0,0)
	cCut.BorderColor3 = Color3.new(0,0,0)
	cCut.BackgroundTransparency = 0.6
	cCut.BorderSizePixel = 0
	cCut.Text = "Cut"
	cCut.TextStrokeTransparency = 0.7
	cCut.TextColor3 = Color3.new(1, 1, 1)
	cCut.TextStrokeColor3 = Color3.new(0.57,0.57,0.57)

local cCopy = Instance.new("TextButton", contextmenu)
	cCopy.Name = "copy"
	cCopy.Position = UDim2.new(0,0,0,21)
	cCopy.Size = UDim2.new(1,0,0,17)
	cCopy.BackgroundColor3 = Color3.new(0,0,0)
	cCopy.BorderColor3 = Color3.new(0,0,0)
	cCopy.BackgroundTransparency = 0.6
	cCopy.BorderSizePixel = 0
	cCopy.Text = "Copy"
	cCopy.TextStrokeTransparency = 0.7
	cCopy.TextColor3 = Color3.new(1,1,1)
	cCopy.TextStrokeColor3 = Color3.new(0.57,0.57,0.57)

local cPaste = Instance.new("TextButton", contextmenu)
	cPaste.Name = "paste"
	cPaste.Position = UDim2.new(0,0,0,40)
	cPaste.Size = UDim2.new(1,0,0,17)
	cPaste.BackgroundColor3 = Color3.new(0,0,0)
	cPaste.BorderColor3 = Color3.new(0,0,0)
	cPaste.BackgroundTransparency = 0.6
	cPaste.BorderSizePixel = 0
	cPaste.Text = "Paste Into"
	cPaste.TextStrokeTransparency = 0.7
	cPaste.TextColor3 = Color3.new(1,1,1)
	cPaste.TextStrokeColor3 = Color3.new(0.57,0.57,0.57)

local cEdit = Instance.new("TextButton", contextmenu)
	cEdit.Name = "edit"
	cEdit.Position = UDim2.new(0,0,0,59)
	cEdit.Size = UDim2.new(1,0,0,17)
	cEdit.BackgroundColor3 = Color3.new(0,0,0)
	cEdit.BorderColor3 = Color3.new(0,0,0)
	cEdit.BackgroundTransparency = 0.6
	cEdit.BorderSizePixel = 0
	cEdit.Text = "Edit"
	cEdit.TextStrokeTransparency = 0.7
	cEdit.TextColor3 = Color3.new(1, 1, 1)
	cEdit.TextStrokeColor3 = Color3.new(0.57,0.57,0.57)

local cRemove = Instance.new("TextButton", contextmenu)
	cRemove.Name = "remove"
	cRemove.Position = UDim2.new(0,0,0,78)
	cRemove.Size = UDim2.new(1,0,0,17)
	cRemove.BackgroundColor3 = Color3.new(0,0,0)
	cRemove.BorderColor3 = Color3.new(0,0,0)
	cRemove.BackgroundTransparency = 0.6
	cRemove.BorderSizePixel = 0
	cRemove.Text = "Remove"
	cRemove.TextStrokeTransparency = 0.7
	cRemove.TextColor3 = Color3.new(1,1,1)
	cRemove.TextStrokeColor3 = Color3.new(0.57, 0.57, 0.57)

-- properties
local edit = Instance.new("Frame", editor)
	edit.Name = "edit"
	edit.Position = UDim2.new(1,0,0,25)
	edit.Size = UDim2.new(1,0,1,-45)
	edit.BackgroundColor3 = Color3.new(0,0,0)
	edit.BorderColor3 = Color3.new(0,0,0)
	edit.BackgroundTransparency = 0.7
	edit.BorderSizePixel = 0

local editTitle = Instance.new("Frame", edit)
	editTitle.Name = "editTitle"
	editTitle.Size = UDim2.new(1,0,0,20)
	editTitle.BackgroundColor3 = Color3.new(0,0,0)
	editTitle.Position = UDim2.new(0,0,0,-25)
	editTitle.BorderColor3 = Color3.new(0,0,0)
	editTitle.BackgroundTransparency = 0.7
	editTitle.BorderSizePixel = 0

local editTitleTextLabel = Instance.new("TextLabel", editTitle)
	editTitleTextLabel.Size = UDim2.new(1,-5,1,0)
	editTitleTextLabel.Position = UDim2.new(0,5,0,0)
	editTitleTextLabel.BackgroundTransparency = 1
	editTitleTextLabel.BorderSizePixel = 0
	editTitleTextLabel.Text = "Loading.."
	editTitleTextLabel.Font = Enum.Font.ArialBold
	editTitleTextLabel.FontSize = Enum.FontSize.Size14
	editTitleTextLabel.TextStrokeTransparency = 0.7
	editTitleTextLabel.TextXAlignment = Enum.TextXAlignment.Left
	editTitleTextLabel.TextColor3 = Color3.new(1,1,1)
	editTitleTextLabel.TextStrokeColor3 = Color3.new(0.35,0.35,0.35)

local propertyLabel = Instance.new("TextLabel", edit)
	propertyLabel.Name = "propertyLabel"
	propertyLabel.Position = UDim2.new(0,10,0,10)
	propertyLabel.BackgroundTransparency = 1
	propertyLabel.BorderSizePixel = 0
	propertyLabel.Text = "Property:"
	propertyLabel.Font = Enum.Font.Arial
	propertyLabel.FontSize = Enum.FontSize.Size12
	propertyLabel.TextStrokeTransparency = 0
	propertyLabel.TextXAlignment = Enum.TextXAlignment.Left
	propertyLabel.TextColor3 = Color3.new(1,1,1)
	propertyLabel.TextStrokeColor3 = Color3.new(0.17,0.17,0.17)

local propertyBox = Instance.new("TextBox", edit)
	propertyBox.Name = "propertyBox"
	propertyBox.Position = UDim2.new(0,4,0,18)
	propertyBox.Size = UDim2.new(1,-8,0,14)
	propertyBox.BackgroundColor3 = Color3.new(1,1,1)
	propertyBox.BackgroundTransparency = 0.85
	propertyBox.BorderSizePixel = 0
	propertyBox.Text = "Property"
	propertyBox.Font = Enum.Font.Arial
	propertyBox.FontSize = Enum.FontSize.Size12
	propertyBox.TextStrokeTransparency = 0.7
	propertyBox.TextColor3 = Color3.new(1,1,1)
	propertyBox.TextStrokeColor3 = Color3.new(0.46,0.46,0.46)

local valueLabel = Instance.new("TextLabel", edit)
	valueLabel.Name = "valueLabel"
	valueLabel.Position = UDim2.new(0,10,0,40)
	valueLabel.BackgroundTransparency = 1
	valueLabel.BorderSizePixel = 0
	valueLabel.Text = "Value:"
	valueLabel.Font = Enum.Font.Arial
	valueLabel.FontSize = Enum.FontSize.Size12
	valueLabel.TextStrokeTransparency = 0
	valueLabel.TextXAlignment = Enum.TextXAlignment.Left
	valueLabel.TextColor3 = Color3.new(1,1,1)
	valueLabel.TextStrokeColor3 = Color3.new(0.17,0.17,0.17)

local valueBox = Instance.new("TextBox", edit)
	valueBox.Name = "valueBox"
	valueBox.Position = UDim2.new(0,4,0,48)
	valueBox.Size = UDim2.new(1,-8,0,14)
	valueBox.BackgroundColor3 = Color3.new(1,1,1)
	valueBox.BackgroundTransparency = 0.85
	valueBox.BorderSizePixel = 0
	valueBox.Text = "Value"
	valueBox.Font = Enum.Font.Arial
	valueBox.FontSize = Enum.FontSize.Size12
	valueBox.TextStrokeTransparency = 0.7
	valueBox.TextColor3 = Color3.new(1,1,1)
	valueBox.TextStrokeColor3 = Color3.new(0.46,0.46,0.46)

local apply = Instance.new("TextButton", edit)
	apply.Name = "apply"
	apply.Position = UDim2.new(1,-115,0,70)
	apply.Size = UDim2.new(0,50,0,15)
	apply.BackgroundColor3 = Color3.new(1,1,1)
	apply.BorderColor3 = Color3.new(0,0,0)
	apply.BackgroundTransparency = 0.85
	apply.BorderSizePixel = 0
	apply.Text = "Apply"
	apply.TextStrokeTransparency = 0.7
	apply.TextColor3 = Color3.new(1,1,1)
	apply.TextStrokeColor3 = Color3.new(0.46,0.46,0.46)

local close = Instance.new("TextButton", edit)
	close.Name = "done"
	close.Position = UDim2.new(1,-60,0,70)
	close.Size = UDim2.new(0,50,0,15)
	close.BackgroundColor3 = Color3.new(1,1,1)
	close.BorderColor3 = Color3.new(0,0,0)
	close.BackgroundTransparency = 0.85
	close.BorderSizePixel = 0
	close.Text = "Done"
	close.TextStrokeTransparency = 0.7
	close.TextColor3 = Color3.new(1,1,1)
	close.TextStrokeColor3 = Color3.new(0.46,0.46,0.46)

local errors = Instance.new("TextLabel", edit)
	errors.Name = "errors"
	errors.Position = UDim2.new(0,5,0,90)
	errors.Text = ""
	errors.Size = UDim2.new(1,-10,0,100)
	errors.BackgroundColor3 = Color3.new(0,0,0)
	errors.BackgroundTransparency = 0.7
	errors.BorderSizePixel = 0
	errors.Font = Enum.Font.Arial
	errors.FontSize = Enum.FontSize.Size12
	errors.TextStrokeTransparency = 0.4
	errors.TextWrapped = true
	errors.TextXAlignment = Enum.TextXAlignment.Left
	errors.TextYAlignment = Enum.TextYAlignment.Top
	errors.TextColor3 = Color3.new(1,0,0)
	errors.TextStrokeColor3 = Color3.new(0.12,0,0)

local nameLabel = Instance.new("TextLabel", edit)
	nameLabel.Name = "nameLabel"
	nameLabel.Position = UDim2.new(0,10,0,198)
	nameLabel.BackgroundTransparency = 1
	nameLabel.BorderSizePixel = 0
	nameLabel.Text = "Display Name:"
	nameLabel.Font = Enum.Font.Arial
	nameLabel.FontSize = Enum.FontSize.Size12
	nameLabel.TextStrokeTransparency = 0
	nameLabel.TextXAlignment = Enum.TextXAlignment.Left
	nameLabel.TextColor3 = Color3.new(1,1,1)
	nameLabel.TextStrokeColor3 = Color3.new(0.17,0.17,0.17)
	
local nameBox = Instance.new("TextBox", edit)
	nameBox.Name = "nameBox"
	nameBox.Position = UDim2.new(0,4,0,206)
	nameBox.Size = UDim2.new(1,-8,0,14)
	nameBox.BackgroundColor3 = Color3.new(1,1,1)
	nameBox.BackgroundTransparency = 0.85
	nameBox.BorderSizePixel = 0
	nameBox.Text = "$(Name/className)$"
	nameBox.Font = Enum.Font.Arial
	nameBox.FontSize = Enum.FontSize.Size12
	nameBox.TextStrokeTransparency = 0.7
	nameBox.TextColor3 = Color3.new(1,1,1)
	nameBox.TextStrokeColor3 = Color3.new(0.46,0.46,0.46)
	
local button = Instance.new("TextButton")
	button.Name = "button"
	button.Position = UDim2.new(0,0,0,0)
	button.Size = UDim2.new(1,0,0,15)
	button.BackgroundColor3 = Color3.new(1,1,1)
	button.BorderColor3 = Color3.new(0,0,0)
	button.BackgroundTransparency = 0.85
	button.BorderSizePixel = 0
	button.Text = "button"
	button.TextWrapped = true
	button.Font = Enum.Font.Arial
	button.FontSize = Enum.FontSize.Size12
	button.TextStrokeTransparency = 0.7
	button.TextColor3 = Color3.new(1,1,1)
	button.TextStrokeColor3 = Color3.new(0.46,0.46,0.46)

local selections = {}
local lastSelection = nil
local contextObject = nil

function attachButtons(current)
	local currentSelection = current.obj
	local gui = current.gui
	local positioner = gui.positioner
	local clipper = gui.clipper
	local scroll, scrollbar = gui.scroll, gui.scrollbar
	
	positioner:ClearAllChildren()
	
	if currentSelection~=game then
		local up = button:Clone()
			up.Name = "up"
			up.Position = UDim2.new(0,0,0,0)
			up.Text = ".."
			up.Parent = positioner
			up.MouseButton1Down:connect(errorCatcher.checker(function()
				if not up.Active then return end
				up.Active = false
				gui.main:TweenPosition(UDim2.new(1,0,0,25),"Out","Quad",0.6,true,function()
					pcall(gui.main.Destroy,gui.main)
				end)
				selections[#selections] = nil
				local c = selections[#selections]
				local cg = c.gui
				cg.main.Visible = true
				attachButtons(c)
				local c = cg.main.Changed:connect(function(p) if p == "Visible" then cg.main.Visible = true end end)
				cg.main:TweenPosition(UDim2.new(0,0,0,25),"Out","Quad",0.6,true,function() c:disconnect() end)
			end,"up-button"))
			up.MouseButton2Down:connect(errorCatcher.checker(function(x,y)
				contextObject = selections[#selections-1].obj
				contextmenu.Visible = true
				contextmenu.Position = UDim2.new(
					0,x - editor.AbsolutePosition.X,
					0,y - editor.AbsolutePosition.Y)
			end,"up-context"))
	end
	
	local refresh = button:Clone()
		refresh.Name = "refresh"
		refresh.Position = UDim2.new(0,0,0,#positioner:GetChildren()*17)
		refresh.Text = "."
		refresh.Parent = positioner
		refresh.MouseButton1Down:connect(errorCatcher.checker(function()
			attachButtons(current)
		end,"refresh-button"))
		refresh.MouseButton2Down:connect(errorCatcher.checker(function(x,y)
			contextObject = currentSelection
			contextmenu.Visible = true
			contextmenu.Position = UDim2.new(
					0,x - editor.AbsolutePosition.X,
					0,y - editor.AbsolutePosition.Y)
		end,"refresh-context"))
	
	if currentSelection:IsA("Player") and currentSelection.Character ~= nil and #currentSelection.Character:GetChildren() > 0 then -- [[[PlayerCharacterButton]]]
		local char = button:Clone()
		char.Name = "character"
		char.Position = UDim2.new(0,0,0,#positioner:GetChildren()*17)
		char.Text = "Character"
		char.Parent = positioner
		char.MouseButton1Down:connect(errorCatcher.checker(function()
			if char.Active then
				showSelection(currentSelection.Character)
				for _, a in pairs(positioner:GetChildren()) do a.Active = false end
			end
			contextmenu.Visible = false
		end,"character-button"))
		char.MouseButton2Down:connect(errorCatcher.checker(function(x,y)
			contextObject = currentSelection.Character
			contextmenu.Visible = true
			contextmenu.Position = UDim2.new(
					0,x - editor.AbsolutePosition.X,
					0,y - editor.AbsolutePosition.Y)
		end,"character-context"))
	end
	
	local count = 0
	local pos = #positioner:GetChildren()*17
	local children = currentSelection:GetChildren()
	for _, a in pairs(children) do
		pcall(function()
			local i = #positioner:GetChildren()
			local b = button:Clone()
				b.Name = "button"..i
				b.Position = UDim2.new(0,0,0,pos)
			
			if a == currentSelection then
				b.Text = "."
			elseif a == currentSelection.Parent then
				b.Text = ".."
			elseif a == game then
				b.Text = "game"
			else
				local partialName = false
				b.Text = nameBox.Text:gsub("%$%((.-)%)%$", function(val)
					for prop in val:gmatch("([^%/]+)") do
						local r, e = pcall(function() return tostring(a[prop]) end)
						if r then
							partialName = true
							return e
						end
					end
				end):gsub(string.char(92) .. "n", string.char(10))
				if not partialName then error("No name!") end
			end
			b.Size = UDim2.new(b.Size.X.Scale,
							b.Size.X.Offset,
							b.Size.Y.Scale,
							b.Size.Y.Offset * neededTextLines("Arial", "Size12", b.Text, editor.AbsoluteSize.X - 23)) 
			b.Parent = positioner
				
			b.MouseButton1Down:connect(errorCatcher.checker(function()
				if b.Active then
					showSelection(a)
					for _, a in pairs(positioner:GetChildren()) do a.Active = false end
				end
				contextmenu.Visible = false
			end,"b-select"))
			b.MouseButton2Down:connect(errorCatcher.checker(function(x,y)
				contextObject = a
				contextmenu.Visible = true
				contextmenu.Position = UDim2.new(
					0,x - editor.AbsolutePosition.X,
					0,y - editor.AbsolutePosition.Y - 40)
			end,"b-edit"))
			
			count = count + 1
			pos = pos + b.Size.Y.Offset + 2
		end)
	end
	if count < #children then
		current.gui.errorLabel.Text = ("%d objects failed to load"):format(#children - count)
	else
		current.gui.errorLabel.Text = ""
	end
	current.gui.autosizeScrollBar()
end

function showSelection(sel, clearOld)
	local name = "NO NAME!"
	if sel == game then
		name = "game"
	elseif sel.Parent == game then
		name = "game." .. sel.Name
	elseif sel.Parent == nil then
		name = "[nil]" .. "." .. sel.Name
	else
		name = sel.Parent.Name .. "." .. sel.Name
	end
	
	if #selections==0 then
		local new = {
			["gui"] = genExplorerFrame();
			["obj"] = sel
		}
		attachButtons(new)
		table.insert(selections, new)
		
		local ngui = new.gui
		ngui.mainTitleTextLabel.Text = name
		ngui.main.Position = UDim2.new(0,0,0,25)
		ngui.main.Parent = editor
	else
		-- generate new
		local new = {
			["gui"] = genExplorerFrame();
			["obj"] = sel
		}
		attachButtons(new)
		table.insert(selections, new)
		
		local ngui = new.gui
		ngui.main.Position = UDim2.new(1,0,0,25)
		ngui.mainTitleTextLabel.Text = name
		ngui.main.Parent = editor
		ngui.main:TweenPosition(UDim2.new(0,0,0,25),"Out","Quad",0.6,true)
		local ogui = selections[#selections-1].gui
		ogui.main:TweenPosition(UDim2.new(-1,0,0,25),"Out","Quad",0.6,true,function() ogui.main.Visible = false end)
	end
	if clearOld then
		for i = 1, #selections-1 do
			selections[i].gui.main:Destroy()
		end
		selections = {selections[#selections]}
	end
end

do -- context menu events
	local lastCopy = nil
	
	contextmenu.MouseLeave:connect(errorCatcher.checker(function()
		contextmenu.Visible = false
	end,"context-leave"))
	cCut.MouseButton1Click:connect(errorCatcher.checker(function()
		pcall(function()
			lastCopy = contextObject:Clone()
			contextObject:Destroy()
			if contextObject == selections[#selections].obj then
				local gui = selections[#selections].gui
				gui.main:TweenPosition(UDim2.new(1,0,0,25),"Out","Quad",0.6,true,function()
					pcall(gui.main.Destroy,gui.main)
				end)
				selections[#selections] = nil
				local c = selections[#selections]
				local cg = c.gui
				cg.main.Visible = true
				attachButtons(c)
				local c = cg.main.Changed:connect(function(p) if p == "Visible" then cg.main.Visible = true end end)
				cg.main:TweenPosition(UDim2.new(0,0,0,25),"Out","Quad",0.6,true,function() c:disconnect() end)
			end
			attachButtons(selections[#selections])
		end)
		contextmenu.Visible = false
	end,"context-cut"))
	cCopy.MouseButton1Click:connect(errorCatcher.checker(function()
		lastCopy = contextObject:Clone()
		contextmenu.Visible = false
	end,"context-copy"))
	cPaste.MouseButton1Click:connect(errorCatcher.checker(function()
		lastCopy:Clone().Parent = contextObject
		attachButtons(selections[#selections])
		contextmenu.Visible = false
	end,"context-paste"))
	cEdit.MouseButton1Click:connect(errorCatcher.checker(function()
		contextmenu.Visible = false
		edit.Visible = true
		
		editTitleTextLabel.Text = contextObject.Name
	
		if contextObject == game then
			editTitleTextLabel.Text = "game"
		elseif contextObject.Parent == game then
			editTitleTextLabel.Text = "game." .. contextObject.Name
		else
			editTitleTextLabel.Text = contextObject.Parent.Name .. "." .. contextObject.Name
		end
		
		selections[#selections].gui.main:TweenPosition(UDim2.new(-1,0,0,25),"Out","Quad",0.6,true,function()
			selections[#selections].gui.main.Visible = false
		end)
		edit:TweenPosition(UDim2.new(0,0,0,25),"Out","Quad",0.6,true)
	end,"context-edit"))
	cRemove.MouseButton1Click:connect(errorCatcher.checker(function()
		pcall(function()
			contextObject:Destroy()
			if contextObject == selections[#selections].obj then
				local gui = selections[#selections].gui
				gui.main:TweenPosition(UDim2.new(1,0,0,25),"Out","Quad",0.6,true,function()
					pcall(gui.main.Destroy,gui.main)
				end)
				selections[#selections] = nil
				local c = selections[#selections]
				local cg = c.gui
				cg.main.Visible = true
				attachButtons(c)
				local c = cg.main.Changed:connect(function(p) if p == "Visible" then cg.main.Visible = true end end)
				cg.main:TweenPosition(UDim2.new(0,0,0,25),"Out","Quad",0.6,true,function() c:disconnect() end)
			end
			attachButtons(selections[#selections])
		end)
		contextmenu.Visible = false
	end,"context-remove"))
end

do -- property editor events
	propertyBox.FocusLost:connect(errorCatcher.checker(function(enterPressed)
		if enterPressed then
			pcall(function()
				valueBox.Text = tostring(contextObject[propertyBox.Text])
			end)
		end
	end,"property-focuslost"))
	apply.MouseButton1Down:connect(errorCatcher.checker(function()
		local ran, err = pcall(function(obj, prop, val)
			if prop == "function" then
				obj[val](obj)
			elseif prop == "insert" then
				Instance.new(val, obj)
			else
				local createTab = getfenv()[typeof(obj[prop])];
				local values = {}
				for m in val:gmatch("([^ ]+)") do
					table.insert(values, tonumber(m) or m)
				end
				
				if createTab["new"] then
					obj[prop] = createTab.new(unpack(values))
				else
					obj[prop] = tonumber(val) or val
				end
			end
		end, contextObject, propertyBox.Text, valueBox.Text)
		if not ran then
			errors.Text = tostring(err:match(":([^:]-)$") or err)
		end
	end,"property-apply"))
	close.MouseButton1Down:connect(errorCatcher.checker(function()
		local main = selections[#selections].gui.main
		main.Visible = true
		main:TweenPosition(UDim2.new(0,0,0,25),"Out","Quad",0.6,true)
		attachButtons(selections[#selections])
		edit:TweenPosition(UDim2.new(1,0,0,25),"Out","Quad",0.6,true,function()
			edit.Visible = false
		end)
		errors.Text = ""
	end,"property-close"))
end

showSelection(game)