local Player = game:GetService("Players").LocalPlayer
local cachedPlayerData = nil

-- Utility functions
local function createTextLabel(parent, name, size, position, text, textColor, textSize)
    local label = Instance.new("TextLabel", parent)
    label.Name = name
    label.Size = size
    label.Position = position
    label.BackgroundTransparency = 1
    label.TextColor3 = textColor
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Code
    label.TextSize = textSize
    label.Text = text
    return label
end

local function updateLighting()
    local Lighting = game:GetService("Lighting")
    local Terrain = workspace:FindFirstChildOfClass("Terrain")

    sethiddenproperty(Lighting, "Technology", Enum.Technology.Compatibility)
    Lighting.GlobalShadows = false
    Lighting.FogEnd = math.huge
    Lighting.Brightness = 5
    Lighting.ClockTime = 14
    Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
    Lighting.Ambient = Color3.new(1, 1, 1)

    if Terrain then
        Terrain.WaterWaveSize = 0
        Terrain.WaterWaveSpeed = 0
        Terrain.WaterReflectance = 0
        Terrain.WaterTransparency = 1
    end

    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level02
    settings().Rendering.EagerBulkExecution = false
end

local function optimizeWorkspace()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
            v.CastShadow = false
        elseif v:IsA("Decal") or v:IsA("Texture") or v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v:Destroy()
        elseif v:IsA("Sound") then
            v.Volume = 0
        end
    end
end

local function setupFPSDisplay()
    local playerGui = Player:WaitForChild("PlayerGui")
    local screenGui = Instance.new("ScreenGui", playerGui)
    screenGui.Name = "FPSDisplay"
    screenGui.ResetOnSpawn = false

    createTextLabel(screenGui, "Title", UDim2.new(0, 250, 0, 25), UDim2.new(0, 10, 0, 10), "Binini Hub Cat Hub W Config Farm Fruit", Color3.fromRGB(255, 255, 0), 18)
    local fpsLabel = createTextLabel(screenGui, "FPSLabel", UDim2.new(0, 250, 0, 25), UDim2.new(0, 10, 0, 35), "FPS: ...", Color3.fromRGB(0, 255, 0), 16)
    local timeLabel = createTextLabel(screenGui, "TimeLabel", UDim2.new(0, 250, 0, 25), UDim2.new(0, 10, 0, 60), "Time: 00:00:00", Color3.fromRGB(0, 170, 255), 16)
    local actionLabel = createTextLabel(screenGui, "ActionLabel", UDim2.new(0, 350, 0, 25), UDim2.new(0, 10, 0, 85), "Action: Loading...", Color3.fromRGB(255, 150, 0), 16)
    createTextLabel(screenGui, "CreditsLabel", UDim2.new(0, 250, 0, 25), UDim2.new(0, 10, 0, 110), "Credits: obii Real", Color3.fromRGB(255, 255, 255), 16)

    getgenv().UpdateAction = function(text)
        actionLabel.Text = "Action: " .. tostring(text)
    end

    -- Update FPS
    spawn(function()
        local counter = 0
        local lastTime = tick()
        game:GetService("RunService").RenderStepped:Connect(function()
            counter += 1
            if tick() - lastTime >= 1 then
                fpsLabel.Text = "FPS: " .. tostring(counter)
                counter = 0
                lastTime = tick()
            end
        end)
    end)

    -- Update Time
    local startTime = tick()
    spawn(function()
        while true do
            local elapsed = tick() - startTime
            local hours = math.floor(elapsed / 3600)
            local minutes = math.floor((elapsed % 3600) / 60)
            local seconds = math.floor(elapsed % 60)
            timeLabel.Text = string.format("Time: %02d:%02d:%02d", hours, minutes, seconds)
            wait(1)
        end
    end)
end

-- Hook Player Data
local function hookPlayerData()
    task.spawn(function()
        local DataService = require(game:GetService("ReplicatedStorage").Modules.DataService)
        if typeof(DataService.GetData) == "function" then
            local oldGetData = DataService.GetData
            DataService.GetData = function(self, ...)
                local data = oldGetData(self, ...)
                cachedPlayerData = data
                return data
            end
        else
            warn("DataService.GetData is not a function or unavailable.")
        end
    end)
end

-- Main Execution
spawn(function()
    wait(5)
    setupFPSDisplay()
    updateLighting()
    optimizeWorkspace()
    hookPlayerData()
end)
