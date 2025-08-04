-- Variables
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local UIS = game:GetService("User InputService")
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local ImmortalButton = Instance.new("TextButton")
local JumpButton = Instance.new("TextButton")
local TeleportButton = Instance.new("TextButton")

-- Configuración de la interfaz
ScreenGui.Parent = player:WaitForChild("PlayerGui")
Frame.Size = UDim2.new(0.3, 0, 0.5, 0)
Frame.Position = UDim2.new(0.35, 0, 0.25, 0)
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.Parent = ScreenGui

-- Botón de Inmortalidad
ImmortalButton.Size = UDim2.new(1, 0, 0.2, 0)
ImmortalButton.Position = UDim2.new(0, 0, 0, 0)
ImmortalButton.Text = "Toggle Immortal"
ImmortalButton.Parent = Frame

-- Botón de Saltos Infinitos
JumpButton.Size = UDim2.new(1, 0, 0.2, 0)
JumpButton.Position = UDim2.new(0, 0, 0.2, 0)
JumpButton.Text = "Toggle Infinite Jump"
JumpButton.Parent = Frame

-- Botón de Teleportar a la Base
TeleportButton.Size = UDim2.new(1, 0, 0.2, 0)
TeleportButton.Position = UDim2.new(0, 0, 0.4, 0)
TeleportButton.Text = "Teleport to Base"
TeleportButton.Parent = Frame

-- Funciones
local immortal = false
local infiniteJump = false

ImmortalButton.MouseButton1Click:Connect(function()
    immortal = not immortal
    if immortal then
        character.Humanoid.MaxHealth = math.huge
        character.Humanoid.Health = math.huge
        ImmortalButton.Text = "Immortal: ON"
    else
        character.Humanoid.MaxHealth = 100
        character.Humanoid.Health = 100
        ImmortalButton.Text = "Immortal: OFF"
    end
end)

JumpButton.MouseButton1Click:Connect(function()
    infiniteJump = not infiniteJump
    if infiniteJump then
        UIS.JumpRequest:Connect(function()
            if infiniteJump then
                character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
        JumpButton.Text = "Infinite Jump: ON"
    else
        JumpButton.Text = "Infinite Jump: OFF"
    end
end)

TeleportButton.MouseButton1Click:Connect(function()
    character:SetPrimaryPartCFrame(CFrame.new(0, 10, 0)) -- Cambia las coordenadas a tu base
end)
