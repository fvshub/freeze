-- 🔥 FVS TRADE FREEZE HUB v2.0 - WITH 60 SECOND COOLDOWN
-- Put this as a **LocalScript** in StarterPlayer → StarterPlayerScripts
-- Script is now officially named "FVS TRADE FREEZE HUB"

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local task = task or (getrenv and getrenv().task)

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Main ScreenGui (renamed exactly as you asked)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FVS TRADE FREEZE HUB"   -- ← YOUR NEW NAME
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "Hub"
mainFrame.Size = UDim2.new(0, 340, 0, 210)
mainFrame.Position = UDim2.new(0.5, -170, 0.4, -40)
mainFrame.BackgroundColor3 = Color3.fromRGB(26, 26, 31)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 16)
uiCorner.Parent = mainFrame

local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(45, 45, 55)
uiStroke.Thickness = 2
uiStroke.Parent = mainFrame

-- Title (updated to your new name)
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -70, 0, 50)      -- extra space for longer name
title.Position = UDim2.new(0, 25, 0, 10)
title.BackgroundTransparency = 1
title.Text = "● FVS TRADE FREEZE HUB"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextSize = 19                        -- slightly smaller so it fits perfectly
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

-- Close Button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 36, 0, 36)
closeBtn.Position = UDim2.new(1, -46, 0, 10)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(200, 70, 70)
closeBtn.TextSize = 26
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = mainFrame

closeBtn.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)

-- 🔥 COOLDOWN TOGGLE FUNCTION (unchanged logic)
local function createToggle(labelText, yPosition, defaultState)
	local container = Instance.new("Frame")
	container.Size = UDim2.new(1, -50, 0, 50)
	container.Position = UDim2.new(0, 25, 0, yPosition)
	container.BackgroundTransparency = 1
	container.Parent = mainFrame

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0.65, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = labelText
	label.TextColor3 = Color3.fromRGB(235, 235, 235)
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.TextSize = 17
	label.Font = Enum.Font.Gotham
	label.Parent = container

	local cooldownLabel = Instance.new("TextLabel")
	cooldownLabel.Size = UDim2.new(0.35, 0, 1, 0)
	cooldownLabel.Position = UDim2.new(0.65, 0, 0, 0)
	cooldownLabel.BackgroundTransparency = 1
	cooldownLabel.Text = ""
	cooldownLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
	cooldownLabel.TextSize = 15
	cooldownLabel.Font = Enum.Font.GothamMedium
	cooldownLabel.TextXAlignment = Enum.TextXAlignment.Right
	cooldownLabel.Parent = container

	local switch = Instance.new("Frame")
	switch.Size = UDim2.new(0, 58, 0, 30)
	switch.Position = UDim2.new(1, -78, 0.5, -15)
	switch.BackgroundColor3 = defaultState and Color3.fromRGB(0, 162, 255) or Color3.fromRGB(52, 52, 60)
	switch.Parent = container

	local switchCorner = Instance.new("UICorner")
	switchCorner.CornerRadius = UDim.new(1, 0)
	switchCorner.Parent = switch

	local knob = Instance.new("Frame")
	knob.Size = UDim2.new(0, 26, 0, 26)
	knob.Position = defaultState and UDim2.new(1, -28, 0.5, -13) or UDim2.new(0, 2, 0.5, -13)
	knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	knob.Parent = switch

	local knobCorner = Instance.new("UICorner")
	knobCorner.CornerRadius = UDim.new(1, 0)
	knobCorner.Parent = knob

	local isOn = defaultState
	local isClickable = true

	local function startCooldown()
		isClickable = false
		local timeLeft = 60
		cooldownLabel.Text = "Cooldown: " .. timeLeft .. "s"

		task.spawn(function()
			while timeLeft > 0 do
				task.wait(1)
				timeLeft -= 1
				cooldownLabel.Text = timeLeft > 0 and "Cooldown: " .. timeLeft .. "s" or ""
			end
			isClickable = true
		end)
	end

	local function toggle()
		if not isClickable then return end

		isOn = not isOn

		local targetColor = isOn and Color3.fromRGB(0, 162, 255) or Color3.fromRGB(52, 52, 60)
		local targetPos = isOn and UDim2.new(1, -28, 0.5, -13) or UDim2.new(0, 2, 0.5, -13)

		TweenService:Create(switch, TweenInfo.new(0.28, Enum.EasingStyle.Quint), {BackgroundColor3 = targetColor}):Play()
		TweenService:Create(knob, TweenInfo.new(0.28, Enum.EasingStyle.Quint), {Position = targetPos}):Play()

		print("[" .. labelText .. "] → " .. (isOn and "ON" or "OFF"))
		-- 🔥 PUT YOUR FREEZE / FORCE ACCEPT CODE HERE

		if isOn then
			startCooldown()
		end
	end

	switch.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			toggle()
		end
	end)
end

-- Create the toggles
createToggle("Freeze Trade", 72, false)
createToggle("Force Accept", 132, true)

print("✅ FVS TRADE FREEZE HUB v2.0 loaded! (named exactly as requested)")
