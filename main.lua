----------------------------------------------------------------
-- FLUENT
----------------------------------------------------------------

local Fluent = loadstring(game:HttpGet(
"https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"
))()

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

local VIM =
    game:GetService(
        "VirtualInputManager"
    )

local RunService =
    game:GetService(
        "RunService"
    )

local player =
    Players.LocalPlayer

local character =
    player.Character
    or player.CharacterAdded:Wait()

local hrp =
    character:WaitForChild(
        "HumanoidRootPart"
    )

local humanoid =
    character:WaitForChild(
        "Humanoid"
    )

player.CharacterAdded:Connect(
function(char)

    character = char

    hrp =
        character:WaitForChild(
            "HumanoidRootPart"
        )

    humanoid =
        character:WaitForChild(
            "Humanoid"
        )
end)

----------------------------------------------------------------
-- FPS LAG
----------------------------------------------------------------

local lagEnabled = false
local lagIntensity = 500000
local lagDuration = 0.3
local lagRunning = false

Tabs.Main:AddParagraph({

    Title = "FPS Lag",

    Content =
        "Fake fps drop"
})

Tabs.Main:AddToggle(
"LagToggle",
{

    Title = "Enable FPS Lag",

    Default = false,

    Callback = function(v)

        lagEnabled = v
    end
})

Tabs.Main:AddSlider(
"LagPower",
{

    Title = "Lag Power",

    Min = 100000,

    Max = 2000000,

    Default = 500000,

    Rounding = 0,

    Callback = function(v)

        lagIntensity = v
    end
})

Tabs.Main:AddSlider(
"LagDuration",
{

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

        if lagRunning then
            return
        end

        lagRunning = true

        task.spawn(function()

            local endTime =
                tick()
                + lagDuration

            while tick()
            < endTime do

                for i = 1,
                    lagIntensity,
                    5000
                do

                    if tick()
                    >= endTime then
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

            lagRunning = false
        end)
    end
})

----------------------------------------------------------------
-- MACRO
----------------------------------------------------------------

local macroEnabled = false

Tabs.Main:AddParagraph({

    Title = "Macro",

    Content =
        "Spam G + Number + CTRL"
})

Tabs.Main:AddToggle(
"MacroToggle",
{

    Title = "Enable Macro",

    Default = false,

    Callback = function(v)

        macroEnabled = v
    end
})

local selectedPreset =
    "G+1+CTRL"

Tabs.Main:AddDropdown(
"MacroPreset",
{

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

local function pressThreeKeys(
    key1,
    key2,
    key3
)

    VIM:SendKeyEvent(
        true,
        key1,
        false,
        game
    )

    VIM:SendKeyEvent(
        true,
        key2,
        false,
        game
    )

    VIM:SendKeyEvent(
        true,
        key3,
        false,
        game
    )

    task.wait(0.05)

    VIM:SendKeyEvent(
        false,
        key1,
        false,
        game
    )

    VIM:SendKeyEvent(
        false,
        key2,
        false,
        game
    )

    VIM:SendKeyEvent(
        false,
        key3,
        false,
        game
    )
end

Tabs.Main:AddButton({

    Title = "Run Macro",

    Callback = function()

        if not macroEnabled then
            return
        end

        if selectedPreset
        == "G+1+CTRL"
        then

            pressThreeKeys(
                Enum.KeyCode.G,
                Enum.KeyCode.One,
                Enum.KeyCode.LeftControl
            )
        end
    end
})

----------------------------------------------------------------
-- MOVEMENT
----------------------------------------------------------------

local movement = {

    edgeEnabled = false,

    edgePower = 85,

    betterBounceEnabled = false,

    betterBouncePower = 14,
}

Tabs.Movement:AddParagraph({

    Title = "Movement",

    Content =
        "Edge + Better Bounce"
})

Tabs.Movement:AddToggle(
"EdgeToggle",
{

    Title = "Enable Edge Boost",

    Default = false,

    Callback = function(v)

        movement.edgeEnabled = v
    end
})

Tabs.Movement:AddSlider(
"EdgePower",
{

    Title = "Edge Power",

    Min = 50,

    Max = 3000,

    Default = 85,

    Rounding = 0,

    Callback = function(v)

        movement.edgePower = v
    end
})

Tabs.Movement:AddToggle(
"BounceToggle",
{

    Title =
        "Enable Better Bounce",

    Default = false,

    Callback = function(v)

        movement
        .betterBounceEnabled = v
    end
})

Tabs.Movement:AddSlider(
"BouncePower",
{

    Title =
        "Better Bounce Power",

    Min = 5,

    Max = 40,

    Default = 14,

    Rounding = 1,

    Callback = function(v)

        movement
        .betterBouncePower = v
    end
})

----------------------------------------------------------------
-- MOVEMENT LOOP
----------------------------------------------------------------

RunService.Heartbeat:Connect(
function()

    if not hrp then
        return
    end

    local vel =
        hrp.AssemblyLinearVelocity

    if movement.edgeEnabled then

        if vel.Y < -1 then

            local parts =
                hrp:GetTouchingParts()

            for _, p in pairs(parts)
            do

                if p
                and p:IsA(
                    "BasePart"
                )
                and not p:IsDescendantOf(
                    character
                )
                then

                    hrp
                    .AssemblyLinearVelocity =

                        Vector3.new(

                            vel.X,

                            movement.edgePower,

                            vel.Z
                        )

                    break
                end
            end
        end
    end

    if movement
    .betterBounceEnabled
    then

        if vel.Y < -10 then

            local parts =
                hrp:GetTouchingParts()

            for _, p in pairs(parts)
            do

                if p
                and p:IsA(
                    "BasePart"
                )
                and not p:IsDescendantOf(
                    character
                )
                then

                    hrp
                    .AssemblyLinearVelocity =

                        Vector3.new(

                            vel.X,

                            movement
                            .betterBouncePower,

                            vel.Z
                        )

                    break
                end
            end
        end
    end
end)

----------------------------------------------------------------
-- CACTUS PLATFORM
----------------------------------------------------------------

local cactusPlatformEnabled =
    false

local cactusPlatformSize = 12
local cactusPlatformHeight = 3
local cactusPlatformTransparency = 1

Tabs.Movement:AddParagraph({

    Title = "Cactus Platform",

    Content =
        "Invisible platform above cactus"
})

Tabs.Movement:AddToggle(
"CactusPlatformToggle",
{

    Title =
        "Enable Cactus Platform",

    Default = false,

    Callback = function(v)

        cactusPlatformEnabled = v

        if v then

            task.spawn(function()

                while
                cactusPlatformEnabled
                do

                    local folder =
                        workspace.Game.Map
                        .Parts
                        .ImmovableProps

                    for _, cactus in ipairs(
                        folder:GetChildren()
                    ) do

                        if string.find(
                            cactus.Name
                            :lower(),

                            "cactus"
                        ) then

                            local highestPart =
                                nil

                            local highestY =
                                -math.huge

                            for _, obj in ipairs(
                                cactus
                                :GetDescendants()
                            ) do

                                if obj:IsA(
                                    "BasePart"
                                ) then

                                    if obj.Position.Y
                                    > highestY
                                    then

                                        highestY =
                                            obj
                                            .Position.Y

                                        highestPart =
                                            obj
                                    end
                                end
                            end

                            if highestPart then

                                local old =
                                    cactus
                                    :FindFirstChild(
                                        "CutePlatform"
                                    )

                                if not old then

                                    local part =
                                        Instance.new(
                                            "Part"
                                        )

                                    part.Name =
                                        "CutePlatform"

                                    part.Parent =
                                        cactus

                                    part.Anchored =
                                        true

                                    part.CanCollide =
                                        true

                                    part.Material =
                                        Enum.Material
                                        .SmoothPlastic

                                    part.Transparency =
                                        cactusPlatformTransparency

                                    part.Size =
                                        Vector3.new(
                                            cactusPlatformSize,
                                            1,
                                            cactusPlatformSize
                                        )

                                    part.CFrame =

                                        highestPart
                                        .CFrame

                                        * CFrame.new(
                                            0,
                                            cactusPlatformHeight,
                                            0
                                        )
                                end
                            end
                        end
                    end

                    task.wait(2)
                end
            end)

        else

            local folder =
                workspace.Game.Map
                .Parts.ImmovableProps

            for _, cactus in ipairs(
                folder:GetChildren()
            ) do

                local old =
                    cactus:FindFirstChild(
                        "CutePlatform"
                    )

                if old then
                    old:Destroy()
                end

                for _, v in ipairs(
                    cactus:GetDescendants()
                ) do

                    if v:IsA(
                        "SelectionBox"
                    ) then

                        v:Destroy()
                    end
                end
            end
        end
    end
})

Tabs.Movement:AddSlider(
"CactusPlatformSize",
{

    Title = "Platform Size",

    Min = 2,

    Max = 40,

    Default = 12,

    Rounding = 0,

    Callback = function(v)

        cactusPlatformSize = v
    end
})

Tabs.Movement:AddSlider(
"CactusPlatformHeight",
{

    Title = "Platform Height",

    Min = 0,

    Max = 15,

    Default = 3,

    Rounding = 0,

    Callback = function(v)

        cactusPlatformHeight = v
    end
})

Tabs.Movement:AddSlider(
"CactusPlatformTransparency",
{

    Title =
        "Platform Transparency",

    Min = 0,

    Max = 100,

    Default = 100,

    Rounding = 0,

    Callback = function(v)

        cactusPlatformTransparency =
            v / 100

        local folder =
            workspace.Game.Map
            .Parts.ImmovableProps

        for _, cactus in ipairs(
            folder:GetChildren()
        ) do

            local part =
                cactus
                :FindFirstChild(
                    "CutePlatform"
                )

            if part then

                part.Transparency =
                    cactusPlatformTransparency
            end
        end
    end
})

----------------------------------------------------------------
-- FOV
----------------------------------------------------------------

Tabs.Misc:AddSlider(
"FOVSlider",
{

    Title = "FOV",

    Min = 30,

    Max = 120,

    Default = 70,

    Rounding = 0,

    Callback = function(v)

        workspace.CurrentCamera
        .FieldOfView = v
    end
})

----------------------------------------------------------------
-- NOTIFY
----------------------------------------------------------------

Fluent:Notify({

    Title = "Cute Femboy Hub",

    Content =
        "Loaded Successfully 🌸",

    Duration = 5
})
