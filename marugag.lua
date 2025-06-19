local cachedPlayerData = nil
local Player = game:GetService("Players").LocalPlayer
print("Welcome to Maru Hub W Config, Make by Hu6Thi3n")


spawn(function()
    wait(5)
    local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    local screenGui = Instance.new("ScreenGui", playerGui)
    screenGui.Name = "FPSDisplay"
    screenGui.ResetOnSpawn = false

    local title = Instance.new("TextLabel", screenGui)
    title.Size = UDim2.new(0, 250, 0, 25)
    title.Position = UDim2.new(0, 10, 0, 10)
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.fromRGB(255, 255, 0)
    title.TextStrokeTransparency = 0.5
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Font = Enum.Font.Code
    title.TextSize = 18
    title.Text = "Maru Hub W Config"

    local fpsLabel = Instance.new("TextLabel", screenGui)
    fpsLabel.Size = UDim2.new(0, 250, 0, 25)
    fpsLabel.Position = UDim2.new(0, 10, 0, 35)
    fpsLabel.BackgroundTransparency = 1
    fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    fpsLabel.TextXAlignment = Enum.TextXAlignment.Left
    fpsLabel.Font = Enum.Font.Code
    fpsLabel.TextSize = 16
    fpsLabel.Text = "FPS: ..."

    local timeLabel = Instance.new("TextLabel", screenGui)
    timeLabel.Size = UDim2.new(0, 250, 0, 25)
    timeLabel.Position = UDim2.new(0, 10, 0, 60)
    timeLabel.BackgroundTransparency = 1
    timeLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
    timeLabel.TextXAlignment = Enum.TextXAlignment.Left
    timeLabel.Font = Enum.Font.Code
    timeLabel.TextSize = 16
    timeLabel.Text = "Time: 00:00:00"

    local actionLabel = Instance.new("TextLabel", screenGui)
    actionLabel.Size = UDim2.new(0, 350, 0, 25)
    actionLabel.Position = UDim2.new(0, 10, 0, 85)
    actionLabel.BackgroundTransparency = 1
    actionLabel.TextColor3 = Color3.fromRGB(255, 150, 0)
    actionLabel.TextXAlignment = Enum.TextXAlignment.Left
    actionLabel.Font = Enum.Font.Code
    actionLabel.TextSize = 16
    actionLabel.Text = "Action: Loading..."

    getgenv().UpdateAction = function(text)
        actionLabel.Text = "Action: " .. tostring(text)
    end

    local startTime = tick()
    spawn(function()
        while true do
            local t = tick() - startTime
            local h = math.floor(t / 3600)
            local m = math.floor((t % 3600) / 60)
            local s = math.floor(t % 60)
            timeLabel.Text = string.format("Time: %02d:%02d:%02d", h, m, s)
            wait(1)
        end
    end)

    local fps = 0
    spawn(function()
        local counter = 0
        local lastTime = tick()
        game:GetService("RunService").RenderStepped:Connect(function()
            counter = counter + 1
            if tick() - lastTime >= 1 then
                fps = counter
                counter = 0
                lastTime = tick()
                fpsLabel.Text = "FPS: " .. tostring(fps)
            end
        end)
    end)

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
end)

-- HOOK PlayerData
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
        warn("DataService.GetData bukan fungsi atau belum tersedia.")
    end
end)

pcall(function()
    local Lighting = game:GetService("Lighting")
    sethiddenproperty(Lighting, "Technology", Enum.Technology.Compatibility)
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 1e10
    Lighting.Brightness = 5
    Lighting.ClockTime = 12
    Lighting.Ambient = Color3.new(1,1,1)
    Lighting.OutdoorAmbient = Color3.new(1,1,1)

    local Terrain = workspace:FindFirstChildOfClass("Terrain")
    if Terrain then
        Terrain.WaterWaveSize = 0
        Terrain.WaterWaveSpeed = 0
        Terrain.WaterReflectance = 0
        Terrain.WaterTransparency = 1
    end

    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level02
    settings().Rendering.EagerBulkExecution = false

    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy()
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v:Destroy()
        end
    end

    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("BloomEffect") or v:IsA("ColorCorrectionEffect") then
            v.Enabled = false
        end
    end

    local cam = workspace:FindFirstChildOfClass("Camera")
    if cam then
        cam.FieldOfView = 70
    end

    game:GetService("UserSettings"):GetService("UserGameSettings").SavedQualityLevel = Enum.SavedQualitySetting.QualityLevel1
end)

pcall(function()
    sethiddenproperty(game:GetService("Lighting"), "Technology", Enum.Technology.Compatibility)

    local Lighting = game:GetService("Lighting")
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 1e10
    Lighting.Brightness = 0
    Lighting.ClockTime = 14
    Lighting.Ambient = Color3.new(1, 1, 1)
    Lighting.OutdoorAmbient = Color3.new(1, 1, 1)

    for _, v in ipairs(Lighting:GetChildren()) do
        if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("BloomEffect") or v:IsA("ColorCorrectionEffect") then
            v:Destroy()
        end
    end

    local Terrain = workspace:FindFirstChildOfClass("Terrain")
    if Terrain then
        Terrain.WaterWaveSize = 0
        Terrain.WaterWaveSpeed = 0
        Terrain.WaterReflectance = 0
        Terrain.WaterTransparency = 1
    end

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.Material = Enum.Material.SmoothPlastic
            obj.Reflectance = 0
            obj.CastShadow = false
        elseif obj:IsA("Decal") or obj:IsA("Texture") then
            obj:Destroy()
        elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") then
            obj:Destroy()
        elseif obj:IsA("Sound") then
            obj.Volume = 0
        end
    end

    local cam = workspace:FindFirstChildOfClass("Camera")
    if cam then
        cam.FieldOfView = 50
    end

    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level02
    settings().Rendering.EagerBulkExecution = false
    game:GetService("UserSettings"):GetService("UserGameSettings").SavedQualityLevel = Enum.SavedQualitySetting.QualityLevel1

    for _, gui in ipairs(game.Players.LocalPlayer:WaitForChild("PlayerGui"):GetChildren()) do
        if not gui:IsA("ScreenGui") then
            gui:Destroy()
        end
    end
end)

task.spawn(function()
    game:GetService("Lighting").FogEnd = 1e10
    game:GetService("Lighting").FogStart = 1e10
    game:GetService("Lighting").GlobalShadows = false
    game:GetService("Lighting").Brightness = 0

    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Decal") or v:IsA("Texture") or v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v:Destroy()
        elseif v:IsA("Sound") then
            v.Volume = 0
        end
    end

    local Terrain = workspace:FindFirstChildOfClass("Terrain")
    if Terrain then
        Terrain.WaterWaveSize = 0
        Terrain.WaterWaveSpeed = 0
        Terrain.WaterReflectance = 0
        Terrain.WaterTransparency = 1
    end

    for _, v in pairs(game:GetService("Lighting"):GetChildren()) do
        if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
            v.Enabled = false
        end
    end

    local cam = workspace.CurrentCamera
    if cam then
        for _, v in pairs(cam:GetChildren()) do
            if v:IsA("PostEffect") then
                v:Destroy()
            end
        end
    end
end)

task.delay(6, function()
    pcall(function()
        local preserved = {
            "Camera", "Terrain", "Effects", "Players", "Lighting", "SoundService",
            "RunService", "ReplicatedStorage", "ReplicatedFirst", "StarterGui", "StarterPack"
        }

        for _, obj in ipairs(game:GetChildren()) do
            if not table.find(preserved, obj.Name) then
                if obj:IsA("Model") or obj:IsA("Folder") or obj:IsA("Part") then
                    obj:Destroy()
                end
            end
        end

        local preservedInWorkspace = {
            "Camera", "Terrain", "Ignore", "Map", "Spawns"
        }

        for _, obj in ipairs(workspace:GetChildren()) do
            if not table.find(preservedInWorkspace, obj.Name) then
                if obj:IsA("Model") or obj:IsA("Folder") or obj:IsA("Part") then
                    obj:Destroy()
                end
            end
        end
    end)
end)

local function getFarm()
    for _, farm in ipairs(workspace:WaitForChild("Farm"):GetChildren()) do
        local ok, owner = pcall(function()
            return farm:WaitForChild("Important").Data.Owner.Value
        end)
        if ok and owner == Player.Name then
            return farm
        end
    end
    return nil
end

local farm = getFarm()

task.spawn(function()
    local DataService = require(game:GetService("ReplicatedStorage").Modules.DataService)
    if typeof(DataService.GetData) == "function" then
        local old = DataService.GetData
        DataService.GetData = function(self,...)
            local data = old(self,...)
            cachedPlayerData = data
            return data
        end
    end
end)

spawn(function()
    local cfg=getgenv().Config["Hop Server"]
    if not (cfg and cfg.Enabled) then return end
    local hopMinutes=cfg.Minutes or 10
    while true do
        if getgenv().UpdateAction then getgenv().UpdateAction("Hopping server in "..hopMinutes.." minutes") end
        wait(hopMinutes*60)
        if getgenv().UpdateAction then getgenv().UpdateAction("Teleporting to new server...") end
        game:GetService("TeleportService"):Teleport(game.PlaceId)
    end
end)

task.spawn(function()
    repeat wait() until game:IsLoaded() and game.Players.LocalPlayer
    if not getgenv().Config["Enable Screen Black"] then
        task.delay(6,function()
            pcall(function()
                local fpsCap=getgenv().Config["Screen Black FPS Cap"] or 30
                if typeof(setfpscap)=="function" then setfpscap(fpsCap) end
                for _,v in ipairs(game:GetDescendants()) do
                    if v:IsA("LocalScript") and v.Name:lower():find("blackscreen") then v:Destroy()
                    elseif v:IsA("Frame") and v.BackgroundColor3==Color3.new(0,0,0)
                         and v.AbsoluteSize.X>300 and v.AbsoluteSize.Y>200 then v:Destroy()
                    elseif v:IsA("ImageLabel") and v.ImageColor3==Color3.new(0,0,0) then v:Destroy()
                    end
                end
                for _,gui in ipairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
                    if gui:IsA("ScreenGui") and gui.Name:lower():find("black") then gui:Destroy() end
                end
            end)
        end)
    end
end)

pcall(function()
    local ts=game:GetService("TeleportService")
    local cfg=getgenv().Config["Auto Rejoin"]
    if cfg.Enabled then
        local delayTime=cfg.Delay or 5
        local function TryRejoin() task.wait(delayTime); ts:Teleport(game.PlaceId,Player) end
        pcall(function()
            Player.OnTeleport:Connect(function(state)
                if state==Enum.TeleportState.Failed or state==Enum.TeleportState.RequestRejected then TryRejoin() end
            end)
        end)
        pcall(function()
            game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
                if child.Name=="ErrorPrompt" then TryRejoin() end
            end)
        end)
    end
end)

pcall(function()
    local cfg=getgenv().Config["World Optimization"]; if not cfg.Enabled then return end
    local removed,limit=0,cfg.MaxToRemove
    for _,v in pairs(workspace:GetDescendants()) do
        if removed>=limit then break end
        if v:IsA("BasePart") or v:IsA("Model") then
            local name=v.Name:lower(); local remove=false
            for _,kw in ipairs(cfg.KeywordsToRemove) do if name:find(kw) then remove=true break end end
            for _,safe in ipairs(cfg.SafeWords) do if name:find(safe) then remove=false break end end
            if remove then pcall(function() v:Destroy() end); removed+=1 end
        end
    end
end)

pcall(function()
    local cfg=getgenv().Config["Remove Specific Parts"]; if not cfg.Enabled then return end
    local tol,cframes=cfg.Tolerance or 0.1,{}
    for _,t in ipairs(cfg.Targets) do table.insert(cframes,CFrame.new(unpack(t))) end
    for _,cf in ipairs(cframes) do
        for _,v in ipairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and v.CFrame.Position:FuzzyEq(cf.Position,tol) then pcall(function() v:Destroy() end) end
        end
    end
end)

pcall(function()
    local cfg=getgenv().Config["Remove Structures"]; if not cfg.Enabled then return end
    for _,v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Model") or v:IsA("BasePart") then
            local name=v.Name:lower()
            for _,kw in ipairs(cfg.Keywords) do
                if name:find(kw) then pcall(function() v:Destroy() end) break end
            end
        end
    end
end)

pcall(function()
    local cfg=getgenv().Config["Anti Fall Ground"]; if not cfg.Enabled then return end
    local part=Instance.new("Part")
    part.Size=Vector3.new(unpack(cfg.Size)); part.Position=Vector3.new(unpack(cfg.Position))
    part.Anchored=true; part.CanCollide=true; part.Transparency=cfg.Transparency
    part.Name="AntiFallGround"; part.Parent=workspace
end)

pcall(function()
    local cfg=getgenv().Config["FPS Lock"]; if cfg.Enabled then
        local fps=tonumber(cfg.Value); if fps and fps>=30 and fps<=100 and typeof(setfpscap)=="function" then
            pcall(function() setfpscap(fps) end)
        end
    end
end)
