local M = {}

function M.is_none(string)
    return string == 'NONE' or string == 'none'
end

function M.blend(foreground, background, alpha)
    if M.is_none(foreground) or M.is_none(background) then return M.none() end

    local fg = { M.hex_to_rgb(foreground) }
    local bg = { M.hex_to_rgb(background) }

    local blend_channel = function(c_fg, c_bg)
        local ret = (alpha * c_fg + ((1 - alpha) * c_bg))
        return math.floor(math.min(math.max(0, ret), 255) + 0.5)
    end

    return M.rgb_to_hex(blend_channel(fg[1], bg[1]), blend_channel(fg[2], bg[2]), blend_channel(fg[3], bg[3]))
end

function M.hex_to_rgb(str)
    str = string.lower(str)
    return tonumber(str:sub(2, 3), 16), tonumber(str:sub(4, 5), 16), tonumber(str:sub(6, 7), 16)
end

function M.rgb_to_hex(r, g, b)
    return '#' .. string.format('%x', r) .. string.format('%x', g) .. string.format('%x', b)
end

return M
