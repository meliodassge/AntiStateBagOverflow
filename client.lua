local MAX_LENGTH = 131072

local function onStateBagChange(bagName, key, value, reserved)
    if tonumber(reserved) ~= 0 then
        return
    end

    local function isSuspicious(value)
        return type(value) == "string" and value:len() >= MAX_LENGTH
    end

    if isSuspicious(key) or isSuspicious(value) then
        TriggerServerEvent("BanEvent")

        ForceSocialClubUpdate()

        print(("[StateBagChange] Suspicious activity detected. Key/Value length exceeded limit. Banning user..."):format())
    end
end

local retval = AddStateBagChangeHandler(nil, nil, onStateBagChange)
