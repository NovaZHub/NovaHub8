-- Verificação de jogo correto
if game.PlaceId ~= 126884695634066 then
    return game.Players.LocalPlayer:Kick("Este script só funciona no Grow a Garden.")
end

-- Carregar a biblioteca Orion
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

-- Criar a janela principal
local Window = OrionLib:MakeWindow({
    Name = "Novax | Grow a Garden",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "NovaxGrowConfig"
})

-- Variáveis de controle
_G.autoFarm = false
_G.autoSell = false
_G.autoBuy = false

-- Função de Auto Farm
function AutoFarm()
    while _G.autoFarm do
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("ClickDetector") and v.Parent:FindFirstChild("Crop") then
                pcall(function()
                    fireclickdetector(v)
                end)
            end
        end
        task.wait(2)
    end
end

-- Função de Auto Sell
function AutoSell()
    while _G.autoSell do
        pcall(function()
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Server"):FireServer("Sell")
        end)
        task.wait(5)
    end
end

-- Função de Auto Buy
function AutoBuy()
    while _G.autoBuy do
        pcall(function()
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Server"):FireServer("Buy", "Seed")
        end)
        task.wait(10)
    end
end

-- 🧪 Aba: Auto Farm
local AutoTab = Window:MakeTab({
    Name = "Auto Farm",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

AutoTab:AddToggle({
    Name = "Auto Farm (Plantar + Colher)",
    Default = false,
    Callback = function(Value)
        _G.autoFarm = Value
        if Value then
            coroutine.wrap(AutoFarm)()
        end
    end
})

AutoTab:AddToggle({
    Name = "Auto Sell",
    Default = false,
    Callback = function(Value)
        _G.autoSell = Value
        if Value then
            coroutine.wrap(AutoSell)()
        end
    end
})

AutoTab:AddToggle({
    Name = "Auto Buy Seeds",
    Default = false,
    Callback = function(Value)
        _G.autoBuy = Value
        if Value then
            coroutine.wrap(AutoBuy)()
        end
    end
})

-- 🛡️ Anti-AFK
AutoTab:AddButton({
    Name = "Ativar Anti-AFK",
    Callback = function()
        local vu = game:GetService("VirtualUser")
        game:GetService("Players").LocalPlayer.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
        OrionLib:MakeNotification({
            Name = "Anti-AFK Ativado",
            Content = "Você não será desconectado por inatividade.",
            Time = 5
        })
    end
})

-- 📌 Créditos
local CreditTab = Window:MakeTab({
    Name = "Créditos",
    Icon = "rbxassetid://7733658504",
    PremiumOnly = false
})

CreditTab:AddParagraph("Feito por:", "NovaxHuv com base no Tbao Hub")
