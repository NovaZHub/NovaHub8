-- Kick desativado para teste (descomente quando tiver certeza do PlaceId correto)
-- if game.PlaceId ~= 10622089237 then
--     game.Players.LocalPlayer:Kick("Esse script só funciona em Grow a Garden.")
-- end
print("Kick desativado temporariamente para teste")

-- Carrega a Orion Library
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

local Window = OrionLib:MakeWindow({
    Name = "Novax | Grow a Garden",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "NovaxGrowConfig"
})

_G.autoFarm = false
_G.autoSell = false
_G.autoBuy = false

function AutoFarm()
    spawn(function()
        while _G.autoFarm do
            for _, v in pairs(workspace:GetDescendants()) do
                if v.Name == "ClickDetector" and v.Parent:FindFirstChild("Crop") then
                    pcall(function()
                        fireclickdetector(v)
                    end)
                    wait(0.3) -- espera um pouco para não spammer o clique
                end
            end
            wait(2)
        end
    end)
end

function AutoSell()
    spawn(function()
        while _G.autoSell do
            local args = {"Sell"}
            local success, err = pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Server"):FireServer(unpack(args))
            end)
            if not success then
                warn("Erro ao tentar vender:", err)
            end
            wait(5)
        end
    end)
end

function AutoBuy()
    spawn(function()
        while _G.autoBuy do
            local args = {"Buy", "Seed"}
            local success, err = pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Server"):FireServer(unpack(args))
            end)
            if not success then
                warn("Erro ao tentar comprar sementes:", err)
            end
            wait(10)
        end
    end)
end

local Tab = Window:MakeTab({
    Name = "Auto Farm",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

Tab:AddToggle({
    Name = "Auto Farm (Plantar + Colher)",
    Default = false,
    Callback = function(Value)
        _G.autoFarm = Value
        if Value then
            AutoFarm()
        end
    end
})

Tab:AddToggle({
    Name = "Auto Sell",
    Default = false,
    Callback = function(Value)
        _G.autoSell = Value
        if Value then
            AutoSell()
        end
    end
})

Tab:AddToggle({
    Name = "Auto Buy Seeds",
    Default = false,
    Callback = function(Value)
        _G.autoBuy = Value
        if Value then
            AutoBuy()
        end
    end
})

Tab:AddButton({
    Name = "Ativar Anti-AFK",
    Callback = function()
        local vu = game:GetService("VirtualUser")
        game:GetService("Players").LocalPlayer.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            wait(1)
            vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        end)
        OrionLib:MakeNotification({
            Name = "Anti-AFK Ativado",
            Content = "Você não será desconectado por inatividade.",
            Time = 5
        })
    end
})

local CreditTab = Window:MakeTab({
    Name = "Créditos",
    Icon = "rbxassetid://7733658504",
    PremiumOnly = false
})

CreditTab:AddParagraph("Feito por:", "NovaxHuv com base no Tbao Hub")
