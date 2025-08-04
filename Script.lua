-- Brainrot Script for Roblox - All Features Activated
-- Includes: Noclip, Super Speed, Infinite Jump, God Mode, Auto-Steal Brainrot
-- Works with Delta Executor

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local root = character:WaitForChild("HumanoidRootPart")

-- Activate NoClip (Walk through walls)
for _, part in pairs(character:GetDescendants()) do
    if part:IsA("BasePart") then
        part.CanCollide = false
    end
end

-- Activate Super Speed
humanoid.WalkSpeed = 50

-- Activate God Mode (Inmortalidad)
humanoid.MaxHealth = math.huge
humanoid.Health = math.huge
humanoid.Died:Connect(function()
    wait(0.1)
    humanoid.MaxHealth = math.huge
    humanoid.Health = math.huge
end)

-- Teleport to Base (change coordinates as needed)
local baseLocation = Vector3.new(0, 100, 0) -- Adjust these coordinates
root.CFrame = CFrame.new(baseLocation)

-- Auto-Steal Brainrot function
local function stealBrainrot()
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj.Name == "Brainrot" and obj:IsA("BasePart") then
            firetouchinterest(root, obj, 0)
            firetouchinterest(root, obj, 1)
        end
    end
end

-- Activate Infinite Jump
game:GetService("User InputService").JumpRequest:Connect(function()
    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
end)

-- Automatic farming loop
while wait(1) do
    stealBrainrot()
end

print("Brainrot Mega-Hack Activado! Todas las funciones están activadas")
