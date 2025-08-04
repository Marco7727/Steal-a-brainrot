-- [Delta Executor] Steal a Brainrot Script

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

-- Mobile touch controls
User InputService.TouchStarted:Connect(function(touch, processed)
    if not processed then
        local touchPos = touch.Position
        -- Define touch zones for buttons
        if touchPos.X < 200 and touchPos.Y < 200 then -- Example area for infinite jump
            infiniteJumpEnabled = not infiniteJumpEnabled
            InfiniteJump()
        elseif touchPos.X < 400 and touchPos.Y < 200 then -- Example area for saving position
            savePos()
        elseif touchPos.X < 600 and touchPos.Y < 200 then -- Example area for teleport
            teleportToPos()
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

-- Main controls for mobile
local function createMobileControls()
    -- Create buttons for mobile UI
    local jumpButton = Instance.new("TextButton")
    jumpButton.Size = UDim2.new(0, 100, 0, 50)
    jumpButton.Position = UDim2.new(0, 10, 0, 10)
    jumpButton.Text = "Saltos Infinitos"
    jumpButton.Parent = player.PlayerGui:WaitForChild("CoreGui")
    jumpButton.MouseButton1Click:Connect(toggleInfiniteJump)

    local saveButton = Instance.new("TextButton")
    saveButton.Size = UDim2.new(0, 100, 0, 50)
    saveButton.Position = UDim2.new(0, 120, 0, 10)
    saveButton.Text = "Guardar Pos"
    saveButton.Parent = player.PlayerGui:WaitForChild("CoreGui")
    saveButton.MouseButton1Click:Connect(savePos)

    local teleportButton = Instance.new("TextButton")
    teleportButton.Size = UDim2.new(0, 100, 0, 50)
    teleportButton.Position = UDim2.new(0, 230, 0, 10)
    teleportButton.Text = "Teletransportar"
    teleportButton.Parent = player.PlayerGui:WaitForChild("CoreGui")
    teleportButton.MouseButton1Click:Connect(teleportToPos)

    local godmodeButton = Instance.new("TextButton")
    godmodeButton.Size = UDim2.new(0, 100, 0, 50)
    godmodeButton.Position = UDim2.new(0, 340, 0, 10)
    godmodeButton.Text = "Godmode"
    godmodeButton.Parent = player.PlayerGui:WaitForChild("CoreGui")
    godmodeButton.MouseButton1Click:Connect(function()
        toggleGodmode(not godmodeEnabled)
    end)

    local noclipButton = Instance.new("TextButton")
    noclipButton.Size = UDim2.new(0, 100, 0, 50)
    noclipButton.Position = UDim2.new(0, 450, 0, 10)
    noclipButton.Text = "Noclip"
    noclipButton.Parent = player.PlayerGui:WaitForChild("CoreGui")
    noclipButton.MouseButton1Click:Connect(function()
        toggleNoclip(not noclipEnabled)
    end)
end

createMobileControls()

print("Script cargado correctamente - By Brainrot Tools")
