-- Custom Roblox Script
-- Action: Un botón en el cual se pueda activar o desactivar con la función de traspasar paredes en el steal a brainrot
-- Intensity level: 10/10

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local scriptActive = false

function toggleScript()
    scriptActive = not scriptActive
    
    if scriptActive then
        -- Activate your custom functionality here
        print("Script activated! Action: Un botón en el cual se pueda activar o desactivar con la función de traspasar paredes en el steal a brainrot")
    else
        -- Deactivate your custom functionality here
        print("Script deactivated")
    end
end

-- Main button functionality
toggleScript()
