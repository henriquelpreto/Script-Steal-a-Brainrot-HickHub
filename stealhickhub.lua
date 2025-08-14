local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Criar ScreenGui
local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")

-- Criar menu pequeno no canto superior direito
local menu = Instance.new("Frame")
menu.Size = UDim2.new(0, 150, 0, 100) -- menor
menu.Position = UDim2.new(1, -160, 0, 10) -- canto superior direito
menu.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
menu.BorderSizePixel = 0
menu.Parent = gui

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 20)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.Text = "Hick Hub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = menu

-- Botão X (fechar)
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 20, 0, 20)
closeBtn.Position = UDim2.new(1, -20, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.Parent = menu

-- Botão ENTRAR NA BASE
local enterBtn = Instance.new("TextButton")
enterBtn.Size = UDim2.new(1, -10, 0, 30)
enterBtn.Position = UDim2.new(0, 5, 0, 30)
enterBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
enterBtn.Text = "ENTRAR NA BASE"
enterBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
enterBtn.Font = Enum.Font.GothamBold
enterBtn.TextSize = 12
enterBtn.Parent = menu

-- Botão AUTO STEAL
local autoBtn = Instance.new("TextButton")
autoBtn.Size = UDim2.new(1, -10, 0, 30)
autoBtn.Position = UDim2.new(0, 5, 0, 65)
autoBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
autoBtn.Text = "AUTO STEAL"
autoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
autoBtn.Font = Enum.Font.GothamBold
autoBtn.TextSize = 12
autoBtn.Parent = menu

-- Tela preta com texto
local function showBlackScreen(text)
	local blackScreen = Instance.new("Frame")
	blackScreen.Size = UDim2.new(1, 0, 1, 0)
	blackScreen.Position = UDim2.new(0, 0, 0, 0)
	blackScreen.BackgroundColor3 = Color3.new(0, 0, 0)
	blackScreen.BackgroundTransparency = 0
	blackScreen.ZIndex = 10
	blackScreen.Parent = gui

	local label = Instance.new("TextLabel")
	label.AnchorPoint = Vector2.new(0.5, 0.5)
	label.Position = UDim2.new(0.5, 0, 0.5, 0)
	label.Size = UDim2.new(0, 300, 0, 50)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.new(1, 1, 1)
	label.Font = Enum.Font.GothamBold
	label.TextSize = 20
	label.ZIndex = 11
	label.Parent = blackScreen

	wait(2)
	blackScreen:Destroy()
end

-- Movimento suave
local TweenService = game:GetService("TweenService")
local function smoothMove(targetPos, duration)
	local char = player.Character or player.CharacterAdded:Wait()
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if hrp then
		local tween = TweenService:Create(hrp, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = CFrame.new(targetPos)})
		tween:Play()
		tween.Completed:Wait()
	end
end

-- ENTRAR NA BASE
enterBtn.MouseButton1Click:Connect(function()
	showBlackScreen("Stealing, 2s")
	local char = player.Character or player.CharacterAdded:Wait()
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if hrp then
		local target = hrp.Position + (hrp.CFrame.LookVector * 10)
		smoothMove(target, 0.8)
	end
end)

-- AUTO STEAL
autoBtn.MouseButton1Click:Connect(function()
	local spawnLocation = workspace:FindFirstChildOfClass("SpawnLocation")
	if spawnLocation then
		local target = spawnLocation.Position + Vector3.new(0, 50, 0)
		smoothMove(target, 1.2)
	end
end)

-- Fechar menu com confirmação
closeBtn.MouseButton1Click:Connect(function()
	local confirm = Instance.new("Frame")
	confirm.Size = UDim2.new(0, 200, 0, 100)
	confirm.Position = UDim2.new(0.5, -100, 0.5, -50)
	confirm.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	confirm.ZIndex = 20
	confirm.Parent = gui

	local text = Instance.new("TextLabel")
	text.Size = UDim2.new(1, 0, 0.5, 0)
	text.Text = "Quer remover o menu?"
	text.TextColor3 = Color3.new(1, 1, 1)
	text.Font = Enum.Font.GothamBold
	text.TextSize = 14
	text.BackgroundTransparency = 1
	text.ZIndex = 21 -- 🔹 Faz o texto aparecer na frente
	text.Parent = confirm

	local yesBtn = Instance.new("TextButton")
	yesBtn.Size = UDim2.new(0.5, 0, 0.5, 0)
	yesBtn.Position = UDim2.new(0, 0, 0.5, 0)
	yesBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
	yesBtn.Text = "Sim"
	yesBtn.TextColor3 = Color3.new(1, 1, 1)
	yesBtn.Font = Enum.Font.GothamBold
	yesBtn.TextSize = 14
	yesBtn.ZIndex = 21 -- 🔹 Faz o botão aparecer na frente
	yesBtn.Parent = confirm

	local noBtn = Instance.new("TextButton")
	noBtn.Size = UDim2.new(0.5, 0, 0.5, 0)
	noBtn.Position = UDim2.new(0.5, 0, 0.5, 0)
	noBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
	noBtn.Text = "Não"
	noBtn.TextColor3 = Color3.new(1, 1, 1)
	noBtn.Font = Enum.Font.GothamBold
	noBtn.TextSize = 14
	noBtn.ZIndex = 21 -- 🔹 Faz o botão aparecer na frente
	noBtn.Parent = confirm

	yesBtn.MouseButton1Click:Connect(function()
		menu:Destroy()
		confirm:Destroy()
	end)

	noBtn.MouseButton1Click:Connect(function()
		confirm:Destroy()
	end)
end)