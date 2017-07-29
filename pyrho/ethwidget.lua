local awful = require("awful")
local wibox = require("wibox")
local json = require("json")
local beautiful = require("beautiful")

function createEthWidget()
    local object = {}
    object.textwidget = wibox.widget {
        markup = '204',
        align  = 'center',
        valign = 'center',
        widget = wibox.widget.textbox,
        font = beautiful.fonts.ethprice
    }

    object.imagewidget = wibox.widget.imagebox(beautiful.icon.eth)
    object.imagewidget:buttons(awful.util.table.join(
        awful.button({}, 1, function() awful.spawn.with_shell("xdg-open 'https://trade.kraken.com/kraken/ethusd'") end)
    ))

    local function getRates()
        local apiEndpoint = "https://api.kraken.com/0/public/Ticker?pair=ETHUSD"
        return "curl " .. apiEndpoint
    end

    local function onUpdate(output)
        if (output ~= nil) then
            res = json.decode(output).result.XETHZUSD
            local opening = string.format("$%6.2f", res.o)
            local avg = string.format("$%6.2f", res.p[1])
            object.textwidget:set_text(avg)
            if (avg > opening) then
                object.imagewidget:set_image(beautiful.icon.ethup)
            else
                object.imagewidget:set_image(beautiful.icon.ethdown)
            end
        end
    end

	local function update()
        awful.spawn.easy_async(getRates(), onUpdate)
	end

	-- Set update timer
	--------------------------------------------------------------------------------
	local t = timer({ timeout = 60 })
	t:connect_signal("timeout", update)
	t:start()
    update()

    return object
end

return createEthWidget
