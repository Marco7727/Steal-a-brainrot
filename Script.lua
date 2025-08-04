-- Delta Executor Script for Steal a Brainrot
-- Make sure to inject this while in-game

local player = game:GetService("Players").LocalPlayer
repeat wait() until player.Character
local humanoid = player.Character.Humanoid
local root = player.Character.HumanoidRootPart
local UIS = game:GetService("User InputService")
local RunService = game:GetService("RunService")

-- Simple anti-detection
pcall(function() 
    getconnections(game:GetService("ScriptContext").Error)(1):Disable()
end)

-- Anti-detection measures for mobile
local function secureLoad()
    -- Prevent detection from mobile anti-cheat
    local mobileAntiBan = {
        heartbeatCheck = function()
            return nil -- Disable heartbeat checks
        end,
        disableModuleScanner = function()
            -- Disable module scanning on mobile
            for _,v in pairs(getloadedmodules()) do
                if v.Name == "Scanner" then
                    v.Disabled = true
                end
            end
        end
    }
    mobileAntiBan.disableModuleScanner()
end
secureLoad()

-- Player references
local savedPosition = nil
local noclipEnabled = false
local infiniteJumpEnabled = false

-- Working infinite jump for mobile
local infiniteJump = false
UIS.JumpRequest:Connect(function()
    if infiniteJump then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

local function setInfiniteJump(val)
    infiniteJump = val
    game.StarterGui:SetCore("SendNotification",{
        Title = "Brainrot Tools",
        Text = "Saltos Infinitos "..(val and "ON" or "OFF"),
        Duration = 2
    })
end

-- Save Position
local function savePosition()
    savedPosition = root.CFrame
    game.StarterGui:SetCore("SendNotification",{
        Title = "Brainrot Tools",
        Text = "Posición guardada!",
        Duration = 2
    })
end

-- Teleport to saved position
local function teleportToPosition()
    if savedPosition then
        player.Character.HumanoidRootPart.CFrame = savedPosition
        game.StarterGui:SetCore("SendNotification",{
            Title = "Brainrot Tools",
            Text = "Teletransportado!",
            Duration = 2
        })
    else
        warn("No position saved!")
    end
end

-- Noclip Functionality
local noclipConnection = nil
local function toggleNoclip(state)
    noclipEnabled = state
    if state then
        if noclipConnection then
            noclipConnection:Disconnect()
        end
        noclipConnection = RunService.Stepped:Connect(function()
            if player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
        game.StarterGui:SetCore("SendNotification",{
            Title = "Noclip",
            Text = "Noclip ACTIVADO",
            Duration = 3
        })
    elseif noclipConnection then
        noclipConnection:Disconnect()
        game.StarterGui:SetCore("SendNotification",{
            Title = "Noclip",
            Text = "Noclip DESACTIVADO",
            Duration = 3
        })
    end
end

-- Godmode Functionality
local godmodeEnabled = false
local originalHealth = nil
local godmodeConnection = nil
local function toggleGodmode(state)
    godmodeEnabled = state
    if state then
        if godmodeConnection then
            godmodeConnection:Disconnect()
        end
        originalHealth = humanoid.Health
        godmodeConnection = humanoid:GetPropertyChangedSignal("Health"):Connect(function()
            if humanoid.Health < originalHealth then
                humanoid.Health = originalHealth
            end
        end)
        game.StarterGui:SetCore("SendNotification",{
            Title = "Godmode",
            Text = "Inmortalidad ACTIVADA",
            Duration = 3
        })
    elseif godmodeConnection then
        godmodeConnection:Disconnect()
        game.StarterGui:SetCore("SendNotification",{
            Title = "Godmode",
            Text = "Inmortalidad DESACTIVADA",
            Duration = 3
        })
    end
end

-- Mobile touch controls
local function createButton(name, position, callback)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Text = name
    button.Size = UDim2.new(0, 120, 0, 40)
    button.Position = position
    button.Parent = player.PlayerGui:WaitForChild("CoreGui")
    button.MouseButton1Click:Connect(callback)
    return button
end

-- Create mobile buttons
local jumpBtn = createButton("Saltos", UDim2.new(0, 20, 0, 20), function()
    setInfiniteJump(not infiniteJump)
end)

local saveBtn = createButton("Guardar", UDim2.new(0, 150, 0, 20), savePosition)

local tpBtn = createButton("Teleport", UDim2.new(0, 280, 0, 20), teleportToPosition)

local godmodeBtn = createButton("Godmode", UDim2.new(0, 410, 0, 20), function()
    toggleGodmode(not godmodeEnabled)
end)

local noclipBtn = createButton("Noclip", UDim2.new(0, 540, 0, 20), function()
    toggleNoclip(not noclipEnabled)
end)

print("Brainrot Tools loaded successfully!")
game.StarterGui:SetCore("SendNotification",{
    Title = "Brainrot Tools",
    Text = "Script cargado correctamente!",
    Duration = 5
})
