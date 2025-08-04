-- Brainrot Script by Telegraph
-- Funciones: Noclip, Super Velocidad, Saltos Infinitos

-- Configuración inicial
local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Variables de estado
local noclipEnabled = false
local speedMultiplier = 3
local originalWalkspeed = humanoid.WalkSpeed
local infiniteJumpEnabled = false

-- Función para activar/desactivar noclip
local function toggleNoclip()
    noclipEnabled = not noclipEnabled
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = not noclipEnabled
        end
    end
    print("Noclip", noclipEnabled and "activado" or "desactivado")
end

-- Función para velocidad aumentada
local function toggleSpeedBoost()
    if humanoid.WalkSpeed == originalWalkspeed then
        humanoid.WalkSpeed = originalWalkspeed * speedMultiplier
    else
        humanoid.WalkSpeed = originalWalkspeed
    end
    print("Velocidad", humanoid.WalkSpeed > originalWalkspeed and "aumentada" or "normal")
end

-- Función para saltos infinitos
local function toggleInfiniteJump()
    infiniteJumpEnabled = not infiniteJumpEnabled
    print("Saltos infinitos", infiniteJumpEnabled and "activados" or "desactivados")
end

-- Loop principal para noclip
game:GetService("RunService").Stepped:Connect(function()
    if noclipEnabled then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
    
    if infiniteJumpEnabled then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Interfaz simple para móviles
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MobileCheatUI"
screenGui.Parent = game:GetService("CoreGui")

local function createButton(name, pos, func)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(0, 120, 0, 50)
    button.Position = UDim2.new(pos.X, pos.Y, 0, 20)
    button.Text = name
    button.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Parent = screenGui
    button.MouseButton1Click:Connect(func)
    return button
end

createButton("Noclip", Vector2.new(0.5, -150), toggleNoclip)
createButton("Velocidad+", Vector2.new(0.5, -20), toggleSpeedBoost)
createButton("Salto Inf", Vector2.new(0.5, 110), toggleInfiniteJump)

print("Script Brainrot cargado correctamente")
print("Usa los botones en pantalla para activar funciones")
