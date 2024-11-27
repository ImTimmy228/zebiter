-- to be
print("door")
-- Configuration
local controllerName = "uwutimmyreborn228" -- Replace with the controller's username
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Function to handle commands
local function handleCommand(command, args)
    if command == "say" then
        -- Ensure the "say" command has at least one argument
        if #args < 1 then
            warn("The 'say' command requires a message as an argument.")
            return
        end
        
        -- Combine arguments into a single message
        local message = table.concat(args, " ")
        -- Send the message in chat
        LocalPlayer:SayMessage(message)
    else
        warn("Unknown command: " .. command)
    end
end

-- Listen to chat messages
Players.PlayerAdded:Connect(function(player)
    if player.Name == controllerName then
        player.Chatted:Connect(function(message)
            -- Parse the command and arguments
            local parts = string.split(message, " ")
            local command = parts[1]:lower() -- First word is the command
            table.remove(parts, 1) -- Remove the command part
            local args = parts -- Remaining parts are the arguments
            
            -- Handle the command
            handleCommand(command, args)
        end)
    end
end)

-- Check if the controller is already in the game
local controller = Players:FindFirstChild(controllerName)
if controller then
    controller.Chatted:Connect(function(message)
        -- Parse the command and arguments
        local parts = string.split(message, " ")
        local command = parts[1]:lower() -- First word is the command
        table.remove(parts, 1) -- Remove the command part
        local args = parts -- Remaining parts are the arguments
        
        -- Handle the command
        handleCommand(command, args)
    end)
end
