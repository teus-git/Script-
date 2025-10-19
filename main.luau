--[[ 
Script: Menu Flutuante para Spawn de NPCs
Autor: ChatGPT
Coloque este script em StarterGui > LocalScript
--]]

--// Criar a interface principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NPCMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

--// Janela principal
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.Position = UDim2.new(0.35, 0, 0.35, 0)
Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

--// Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Text = "Spawn de NPC"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Frame

--// Botão de fechar (X)
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 0)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 18
CloseButton.Parent = Frame

--// Botão de minimizar (-)
local MinButton = Instance.new("TextButton")
MinButton.Size = UDim2.new(0, 30, 0, 30)
MinButton.Position = UDim2.new(0, 5, 0, 0)
MinButton.Text = "-"
MinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
MinButton.Font = Enum.Font.SourceSansBold
MinButton.TextSize = 18
MinButton.Parent = Frame

--// Campo de texto para nome do NPC
local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(1, -20, 0, 40)
TextBox.Position = UDim2.new(0, 10, 0, 60)
TextBox.PlaceholderText = "Digite o nome do NPC..."
TextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.ClearTextOnFocus = false
TextBox.Font = Enum.Font.SourceSans
TextBox.TextSize = 18
TextBox.Parent = Frame

--// Botão Enter
local EnterButton = Instance.new("TextButton")
EnterButton.Size = UDim2.new(0, 120, 0, 35)
EnterButton.Position = UDim2.new(0.5, -60, 0, 120)
EnterButton.Text = "Spawnar NPC"
EnterButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
EnterButton.TextColor3 = Color3.fromRGB(255, 255, 255)
EnterButton.Font = Enum.Font.SourceSansBold
EnterButton.TextSize = 18
EnterButton.Parent = Frame

--// Bolinha flutuante
local BallButton = Instance.new("ImageButton")
BallButton.Size = UDim2.new(0, 50, 0, 50)
BallButton.Position = UDim2.new(0.9, 0, 0.8, 0)
BallButton.Image = "rbxassetid://12284379563" -- ícone simples de círculo
BallButton.BackgroundTransparency = 1
BallButton.Visible = false
BallButton.Parent = ScreenGui

--// Funções de controle da interface
CloseButton.MouseButton1Click:Connect(function()
	Frame.Visible = false
	BallButton.Visible = false
end)

MinButton.MouseButton1Click:Connect(function()
	Frame.Visible = false
	BallButton.Visible = true
end)

BallButton.MouseButton1Click:Connect(function()
	Frame.Visible = true
	BallButton.Visible = false
end)

--// Função para procurar e spawnar o NPC
local function procurarESpawnarNPC(nome)
	local npcEncontrado = nil

	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("Model") and obj.Name == nome then
			npcEncontrado = obj
			break
		end
	end

	if npcEncontrado then
		local clone = npcEncontrado:Clone()
		clone.Parent = workspace
		clone:SetPrimaryPartCFrame(game.Players.LocalPlayer.Character.PrimaryPart.CFrame * CFrame.new(3, 0, 0))
		game.StarterGui:SetCore("SendNotification", {
			Title = "NPC Spawnado!";
			Text = nome .. " foi spawnado com sucesso!";
			Duration = 4;
		})
	else
		game.StarterGui:SetCore("SendNotification", {
			Title = "NPC não encontrado!";
			Text = "Verifique o nome digitado.";
			Duration = 4;
		})
	end
end

--// Ação ao clicar no botão
EnterButton.MouseButton1Click:Connect(function()
	local nome = TextBox.Text
	if nome and nome ~= "" then
		procurarESpawnarNPC(nome)
	end
end)