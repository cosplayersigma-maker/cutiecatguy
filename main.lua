local Fluent = loadstring(game:HttpGet(
"https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"
))()

local SaveManager = loadstring(game:HttpGet(
"https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"
))()

local InterfaceManager = loadstring(game:HttpGet(
"https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"
))()

----------------------------------------------------------------
-- WINDOW
----------------------------------------------------------------

local Window = Fluent:CreateWindow({

    Title = "Cute Femboy Hub",

    SubTitle = "by imnor deptrai",

    TabWidth = 160,

    Size = UDim2.fromOffset(580,460),

    Acrylic = true,

    Theme = "Dark",

    MinimizeKey = Enum.KeyCode.RightControl
})

----------------------------------------------------------------
-- TABS
----------------------------------------------------------------

local Tabs = {

    Main = Window:AddTab({

        Title = "Main",

        Icon = "home"
    }),

    Movement = Window:AddTab({

        Title = "Movement",

        Icon = "move"
    }),

    Misc = Window:AddTab({

        Title = "Misc",

        Icon = "settings"
    })
}

----------------------------------------------------------------
-- SERVICES
----------------------------------------------------------------

local Players =
    game:GetService("Players")

local UIS =
    game:GetService("UserInputService")

local VIM =
    game:GetService("VirtualInputManager")

local RunService =
    game:GetService("RunService")

local player =
    Players.LocalPlayer

local character =
    player.Character
    or player.CharacterAdded:Wait()

local hrp =
    character:WaitForChild(
        "HumanoidRootPart"
    )

player.CharacterAdded:Connect(function(char)

    character = char

    hrp =
        character:WaitForChild(
            "HumanoidRootPart"
        )
end)

----------------------------------------------------------------
-- FPS LAG
----------------------------------------------------------------

local lagEnabled = false
local lagIntensity = 500000
local lagDuration = 0.3
local isActive = false

Tabs.Main:AddParagraph({

    Title = "FPS Lag",

    Content = "Fake fps drop"
})

Tabs.Main:AddToggle("LagToggle", {

    Title = "Enable FPS Lag",

    Default = false,

    Callback = function(v)

        lagEnabled = v
    end
})

Tabs.Main:AddSlider("LagPower", {

    Title = "Lag Power",

    Min = 100000,

    Max = 2000000,

    Default = 500000,

    Rounding = 0,

    Callback = function(v)

        lagIntensity = v
    end
})

Tabs.Main:AddSlider("LagDuration", {

    Title = "Lag Duration",

    Min = 1,

    Max = 30,

    Default = 3,

    Rounding = 1,

    Callback = function(v)

        lagDuration = v / 10
    end
})

Tabs.Main:AddButton({

    Title = "Run FPS Lag",

    Callback = function()

        if not lagEnabled then
            return
        end

        if isActive then
            return
        end

        isActive = true

        task.spawn(function()

            local endTime =
                tick() + lagDuration

            while tick() < endTime do

                for i = 1,
                    lagIntensity,
                    5000
                do

                    if tick() >= endTime then
                        break
                    end

                    for j = i,
                        math.min(
                            i + 4999,
                            lagIntensity
                        )
                    do

                        local x =
                            math.sqrt(j)
                            * math.random()
                            * math.sin(j)
                    end
                end

                task.wait()
            end

            isActive = false
        end)
    end
})

----------------------------------------------------------------
-- EDGE BOOST
----------------------------------------------------------------

local edgeEnabled = false
local edgePower = 50
local edgeConnection

Tabs.Movement:AddParagraph({

    Title = "Edge Boost",

    Content = "Boost at edge"
})

Tabs.Movement:AddToggle("EdgeToggle", {

    Title = "Enable Edge Boost",

    Default = false,

    Callback = function(v)

        edgeEnabled = v

        if edgeConnection then
            edgeConnection:Disconnect()
        end

        if v then

            edgeConnection =
                RunService.Heartbeat:Connect(
                function()

                    if not hrp then
                        return
                    end

                    local vel =
                        hrp.AssemblyLinearVelocity

                    if vel.Y < -1 then

                        local parts =
                            hrp:GetTouchingParts()

                        for _, p in pairs(parts) do

                            if p
                            and p:IsA(
                                "BasePart"
                            )
                            and not p:IsDescendantOf(
                                character
                            )
                            then

                                hrp.AssemblyLinearVelocity =
                                    Vector3.new(
                                        vel.X,
                                        edgePower,
                                        vel.Z
                                    )

                                break
                            end
                        end
                    end
                end)
        end
    end
})

Tabs.Movement:AddSlider("EdgePower", {

    Title = "Edge Power",

    Min = 50,

    Max = 3000,

    Default = 50,

    Rounding = 0,

    Callback = function(v)

        edgePower = v
    end
})

----------------------------------------------------------------
-- MACRO
----------------------------------------------------------------

local macroEnabled = false

local selectedPreset =
    "G+1+CTRL"

Tabs.Movement:AddParagraph({

    Title = "Macro",

    Content = "Macro presets"
})

Tabs.Movement:AddToggle("MacroToggle", {

    Title = "Enable Macro",

    Default = false,

    Callback = function(v)

        macroEnabled = v
    end
})

Tabs.Movement:AddDropdown("MacroPreset", {

    Title = "Preset",

    Values = {

        "G+1+CTRL",
        "G+2+CTRL",
        "G+3+CTRL",
        "G+4+CTRL",
        "G+5+CTRL",
        "G+6+CTRL",
    },

    Multi = false,

    Default = 1,

    Callback = function(v)

        selectedPreset = v
    end
})

Tabs.Movement:AddButton({

    Title = "Run Macro",

    Callback = function()

        if not macroEnabled then
            return
        end

        local presetMap = {

            ["G+1+CTRL"] =
                Enum.KeyCode.One,

            ["G+2+CTRL"] =
                Enum.KeyCode.Two,

            ["G+3+CTRL"] =
                Enum.KeyCode.Three,

            ["G+4+CTRL"] =
                Enum.KeyCode.Four,

            ["G+5+CTRL"] =
                Enum.KeyCode.Five,

            ["G+6+CTRL"] =
                Enum.KeyCode.Six,
        }

        local numKey =
            presetMap[selectedPreset]

        if numKey then

            VIM:SendKeyEvent(
                true,
                Enum.KeyCode.G,
                false,
                game
            )

            VIM:SendKeyEvent(
                true,
                numKey,
                false,
                game
            )

            VIM:SendKeyEvent(
                true,
                Enum.KeyCode.LeftControl,
                false,
                game
            )

            task.wait(0.05)

            VIM:SendKeyEvent(
                false,
                Enum.KeyCode.G,
                false,
                game
            )

            VIM:SendKeyEvent(
                false,
                numKey,
                false,
                game
            )

            VIM:SendKeyEvent(
                false,
                Enum.KeyCode.LeftControl,
                false,
                game
            )
        end
    end
})

----------------------------------------------------------------
-- CACTUS HITBOX
----------------------------------------------------------------

local cactusEnabled = false
local cactusSize = 8

Tabs.Movement:AddParagraph({

    Title = "Cactus",

    Content = "Expand cactus top"
})

Tabs.Movement:AddToggle("CactusToggle", {

    Title = "Enable Cactus Hitbox",

    Default = false,

    Callback = function(v)

        cactusEnabled = v

        if v then

            task.spawn(function()

                while cactusEnabled do

                    local folder =
                    workspace.Game.Map.Parts.ImmovableProps

                    for _, cactus in ipairs(
                        folder:GetChildren()
                    ) do

                        if string.find(
                            cactus.Name:lower(),
                            "cactus"
                        ) then

                            local topPart = nil
                            local highestY =
                                -math.huge

                            for _, obj in ipairs(
                                cactus:GetDescendants()
                            ) do

                                if obj:IsA(
                                    "BasePart"
                                ) then

                                    if obj.Position.Y
                                    > highestY
                                    then

                                        highestY =
                                            obj.Position.Y

                                        topPart =
                                            obj
                                    end
                                end
                            end

                            if topPart then

                                pcall(function()

                                    topPart.Size =
                                        topPart.Size
                                        + Vector3.new(
                                            cactusSize,
                                            cactusSize,
                                            cactusSize
                                        )

                                    topPart.CanCollide =
                                        true

                                    topPart.Transparency =
                                        0

                                    if not topPart:FindFirstChild(
                                        "ESP"
                                    ) then

                                        local box =
                                            Instance.new(
                                                "SelectionBox"
                                            )

                                        box.Name =
                                            "ESP"

                                        box.Parent =
                                            topPart

                                        box.Adornee =
                                            topPart

                                        box.LineThickness =
                                            0.05

                                        box.Color3 =
                                            Color3.fromRGB(
                                                0,
                                                255,
                                                0
                                            )
                                    end
                                end)
                            end
                        end
                    end

                    task.wait(3)
                end
            end)
        end
    end
})

Tabs.Movement:AddSlider("CactusSize", {

    Title = "Cactus Size",

    Min = 2,

    Max = 20,

    Default = 8,

    Rounding = 0,

    Callback = function(v)

        cactusSize = v
    end
})

----------------------------------------------------------------
-- FOV
----------------------------------------------------------------

local camera =
    workspace.CurrentCamera

Tabs.Misc:AddSlider("FOV", {

    Title = "FOV",

    Min = 30,

    Max = 120,

    Default = 70,

    Rounding = 0,

    Callback = function(v)

        if camera then
            camera.FieldOfView = v
        end
    end
})

----------------------------------------------------------------
-- SAVE
----------------------------------------------------------------

SaveManager:SetLibrary(Fluent)

InterfaceManager:SetLibrary(Fluent)

SaveManager:IgnoreThemeSettings()

SaveManager:SetIgnoreIndexes({})

InterfaceManager:SetFolder(
    "CuteFemboyHub"
)

SaveManager:SetFolder(
    "CuteFemboyHub/Evade"
)

InterfaceManager:BuildInterfaceSection(
    Tabs.Settings
)

SaveManager:BuildConfigSection(
    Tabs.Settings
)

Window:SelectTab(1)

Fluent:Notify({

    Title = "Cute Femboy Hub",

    Content = "Loaded Successfully 🌸",

    Duration = 5
})
