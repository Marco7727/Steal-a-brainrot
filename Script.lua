-- [Delta Executor] Steal a Brainrot Script

-- Anti-detection measures
local function secureLoad()
    local env = getfenv(0)
    local mt = getmetatable(env) or {}
    mt.__index = function(t, k)
        if k == "hookfunction" or k == "setclipboard" then return nil end
        return rawget(t, k)
    end
    setmetatable(env, mt)
end
secureLoad()

-- Player references
local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local humanoidRoot = character:WaitForChild("HumanoidRootPart")
local UserInputService = game:GetService("User InputService")
local RunService = game:GetService("RunService")
local savedPosition = nil
local noclipEnabled = false

-- Infinite Jump
local infiniteJumpEnabled = false

local function InfiniteJump()
    if infiniteJumpEnabled then
        UserInputService.JumpRequest:Connect(function()
            humanoid:ChangeState("Jumping")
        end)
        print("■ Saltos infinitos ACTIVADOS")
    else
        for _, conn in pairs(getconnections(UserInputService.JumpRequest)) do 
            conn:Disconnect()
        end
        print("■ Saltos infinitos DESACTIVADOS")
    end
end

-- Save Position
local function savePos()
    savedPosition = humanoidRoot.CFrame
    game.StarterGui:SetCore("SendNotification", {
        Title = "DELTA", 
        Text = "Posición guardada!",
        Duration = 3
    })
end

-- Teleport to saved position
local function teleportToPos()
    if savedPosition then
        humanoidRoot.CFrame = savedPosition
        game.StarterGui:SetCore("SendNotification", {
            Title = "DELTA", 
            Text = "Teletransportado!",
            Duration = 3
        })
    else
        print("[DELTA] No hay posición guardada!")
    end
end

-- Key bindings
User InputService.InputBegan:Connect(function(input, processed)
    if not processed then
        if input.KeyCode == Enum.KeyCode.F5 then -- Guardar posición
            savePos()
        elseif input.KeyCode == Enum.KeyCode.F6 then -- Teletransporte
            teleportToPos()
        elseif input.KeyCode == Enum.KeyCode.F7 then -- Activar saltos infinitos
            infiniteJumpEnabled = not infiniteJumpEnabled
            InfiniteJump()
        end
    end
end)

-- Immortality (Godmode)
local godmodeEnabled = false
local originalHealth = nil

local function toggleGodmode(state)
    if state then
        originalHealth = humanoid.Health
        humanoid:GetPropertyChangedSignal("Health"):Connect(function()
            if humanoid.Health < originalHealth then
                humanoid.Health = originalHealth
            end
        end)
        print("■ Godmode ACTIVADO (Inmortal)")
    else
        humanoid.Health = originalHealth
        print("■ Godmode DESACTIVADO")
    end
    godmodeEnabled = state
end

-- Noclip/Wall Walk
local function toggleNoclip(state)
    noclipEnabled = state
    if state then
        local noclipConn
        noclipConn = RunService.Stepped:Connect(function()
            if character and character:FindFirstChild("HumanoidRootPart") then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
        print("■ Noclip ACTIVADO (Traspasar paredes)")
        return noclipConn
    end
    print("■ Noclip DESACTIVADO")
    return nil
end

-- UI Controls for Mobile
local function createButton(name, callback)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Text = name
    button.Size = UDim2.new(0, 120, 0, 40)
    button.Position = UDim2.new(0, 10, 0, 10)
    button.Parent = player.PlayerGui:WaitForChild("CoreGui")
    button.MouseButton1Click:Connect(callback)
    return button
end

-- Main controls
local godmodeBtn = createButton("Godmode", function()
    toggleGodmode(not godmodeEnabled)
end)

local noclipBtn = createButton("Noclip", function()
    toggleNoclip(not noclipEnabled)
end)

local savePosBtn = createButton("Guardar Pos", savePos)
local teleportBtn = createButton("Teleport", teleportToPos)

print("Script cargado correctamente - By Brainrot Tools")
