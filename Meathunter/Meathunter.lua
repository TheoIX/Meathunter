-- Notify when addon is loaded
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, name)
    if name == "Meathunter" then
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00Meathunter loaded. Use /meathunter to cycle adds or target boss.|r")
    end
end)

-- Register slash command
SLASH_MEATHUNTER1 = "/meathunter"
SlashCmdList["MEATHUNTER"] = function(msg)
    local addName  = "Nightmare Crawler"
    local bossName = "Mephistroth"
    local maxScan  = 20  -- Maximum enemies to scan via TargetNearestEnemy

    -- Clear current target to start fresh
    ClearTarget()

    -- Cycle through nearby enemies to find a living add
    for i = 1, maxScan do
        TargetNearestEnemy()
        if UnitExists("target") then
            local name = UnitName("target")
            if name == addName and not UnitIsDeadOrGhost("target") then
                return  -- Found a living add, stop here
            end
        end
    end

    -- Fallback: target the boss by name
    TargetByName(bossName, true)
end

