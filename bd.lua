-- for bd specially
task.wait(5)
print("BD Started")
-- AltControlScript.lua
-- This script should be executed by alts.

-- Settings
local controllerUsername = "uwutimmyreborn228" -- Replace with your username
local altPlayer = game.Players.LocalPlayer

-- Function to handle commands
local function onChatMessage(player, message)
    if player.Name == controllerUsername then
        local args = string.split(message, " ")
        local command = args[1]:lower()

        if command == "rr" then
            altPlayer.Character.Humanoid:TakeDamage(altPlayer.Character.Humanoid.Health) -- Resets the alt
        elseif command == "ss" then
            local textToSay = table.concat(args, " ", 2) -- Combines remaining parts of the message
            game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(textToSay, "All")
        end
    end
end

-- Connect to chat messages
game.Players.PlayerChatted:Connect(onChatMessage)
