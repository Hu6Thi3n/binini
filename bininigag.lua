local cachedPlayerData = nil
local Player = game:GetService("Players").LocalPlayer


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
    title.Text = "Binini Hub Cat Hub W Config Farm Fruit"

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
    actionLabel.TextColor3 = Color3.fromRGB(255, 150, 0)z
    actionLabel.TextXAlignment = Enum.TextXAlignment.Left
    actionLabel.Font = Enum.Font.Code
    actionLabel.TextSize = 16
    actionLabel.Text = "Action: Loading..."

    local creditsLabel = Instance.new("TextLabel", screenGui)
    creditsLabel.Size = UDim2.new(0, 250, 0, 25)
    creditsLabel.Position = UDim2.new(0, 10, 0, 110)
    creditsLabel.BackgroundTransparency = 1
    creditsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    creditsLabel.TextXAlignment = Enum.TextXAlignment.Left
    creditsLabel.Font = Enum.Font.Code
    creditsLabel.TextSize = 16
    creditsLabel.Text = "Credits: obii Real"

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
    wait(5)
    local shop = getgenv().Config["Buy Honey Shop"]
    local function buyEventShopItems()
        local data = cachedPlayerData
        if not data or not data.EventShopStock or not data.EventShopStock.Stocks then return end
        local remote = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):FindFirstChild("BuyEventShopStock")
        for itemName,enabled in pairs(shop) do
            if enabled then
                local stock = data.EventShopStock.Stocks[itemName]
                if stock and stock.Stock>0 then
                    pcall(function() remote:FireServer(itemName) end)
                    task.wait()
                end
            end
        end
    end
    while task.wait(5) do pcall(buyEventShopItems) end
end)

spawn(function()
    if not (farm and getgenv().Config["Auto Place Pet Egg"].Enabled) then return end
    wait(5)
    local placeEgg = {}
    local base = farm:WaitForChild("Important").Plant_Locations.Can_Plant.Position
    for _,z in ipairs({-15,-19}) do
        for i = (z==-15 and -2 or -1),(z==-15 and 2 or 1) do
            table.insert(placeEgg,{Used=false,Position=Vector3.new(base.X+i*4,base.Y,base.Z+z)})
        end
    end
    while task.wait(5) do
        pcall(function()
            local data = cachedPlayerData; if not data or not data.InventoryData then return end
            local petEggs={}
            for id,item in pairs(data.InventoryData) do
                if item.ItemType=="PetEgg" then
                    table.insert(petEggs,{id=id,name=item.ItemData and item.ItemData.EggName or"Unknown",
                        uses=item.ItemData and item.ItemData.Uses or 0})
                end
            end
            if #petEggs==0 then return end
            for _,e in ipairs(placeEgg) do e.Used=false end
            local eggPlaced=0
            for _,egg in ipairs(farm:WaitForChild("Important").Objects_Physical:GetChildren()) do
                if egg.Name~="PetEgg" then continue end
                eggPlaced+=1
                local pos=egg.PetEgg.Position
                for _,entry in ipairs(placeEgg) do
                    if not entry.Used and math.abs(entry.Position.X-pos.X)<=1 and math.abs(entry.Position.Z-pos.Z)<=1 then
                        entry.Used=true; break
                    end
                end
            end
            local maxEggs=data.PetsData.MutableStats.MaxEggsInFarm
            if eggPlaced>=maxEggs then return end
            for _,egg in ipairs(petEggs) do
                pcall(function()
                    Player.Character.Humanoid:EquipTool(Player.Backpack[egg.name.." x"..egg.uses])
                end)
                task.wait(2)
                for _=1,egg.uses do
                    local target=nil
                    for _,entry in ipairs(placeEgg) do if not entry.Used then target=entry break end end
                    if not target then return end
                    game:GetService("ReplicatedStorage").GameEvents.PetEggService:FireServer("CreateEgg",target.Position)
                    target.Used=true; eggPlaced+=1; task.wait(1)
                    if eggPlaced>=maxEggs then return end
                end
            end
        end)
    end
end)

spawn(function()
    if not (farm and getgenv().Config["Auto Hatch Egg"].Enabled) then return end
    while task.wait(5) do
        pcall(function()
            for _,egg in ipairs(farm:WaitForChild("Important").Objects_Physical:GetChildren()) do
                if egg.Name~="PetEgg" then continue end
                if egg:GetAttribute("TimeToHatch")==0 then
                    game:GetService("ReplicatedStorage"):WaitForChild("GameEvents")
                        :WaitForChild("PetEggService"):FireServer("HatchPet",egg)
                end
            end
        end)
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

task.spawn(function()
    local cfg=getgenv().Config["Dupe Seed"]; if not cfg.Enabled then return end
    local delayTime=cfg.Delay or 3
    local fc=setmetatable({},{
        __index=function(_,i)
            if i=="Seed" then
                return function(ins)
                    if ins and ins:GetAttribute("Quantity") then
                        ins:SetAttribute("Quantity",ins:GetAttribute("Quantity")+1)
                        ins.Name = ins.Name:gsub("%d+",tostring(ins:GetAttribute("Quantity")))
                    end
                end
            else
                return function(ins)
                    if not ins then return end
                    local clone=ins:Clone(); clone.Parent=Player.Backpack
                    local amt,name=clone.Name:match("%[(.-)%]"),clone.Name:match("(%a+)")
                    amt=tonumber(amt:gsub("kg","")) or 1
                    local newVal=tostring(math.random(math.floor(amt)*100,(math.ceil(amt)+1)*100))/100
                    clone.Name=string.format("%s [%skg]",name,newVal)
                end
            end
        end,__newindex=function()end,__metatable="locked"
    })
    while task.wait(delayTime) do
        for _,item in ipairs(Player.Backpack:GetChildren()) do
            if item:IsA("Tool") and item:FindFirstChild("Handle") and item:GetAttribute("Quantity") then
                pcall(function() fc.Seed(item) end)
            end
        end
    end
end)
