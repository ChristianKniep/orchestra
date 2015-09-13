require "string"
require "table"
require "math"

local function ToInteger(number)
    return math.floor(tonumber(number) or error("Could not cast '" .. tostring(number) .. "' to number.'"))
end

miss_cnt = 0
cur_nr = 0
next_nr = 0
count = 0
exp = 0
reset = false
miss = false

function process_message()
    count = count + 1
    local payload = read_message("Payload")
    cur_nr = ToInteger(payload)
    if count == 1 then
        reset = true
    else
        if not (cur_nr == next_nr) then
            miss_cnt = miss_cnt + 1
            miss = true
        end
    end
    exp = next_nr
    next_nr = cur_nr + 1
    return 0
end

function timer_event(ns)
    stat = "OK"
    extra = ""
    if reset then
        stat = "RESET"
        reset = false
    end
    if miss then
        stat = "MISS"
        miss = false
    end
    res = string.format("%6s > Seen '%5s' msg so far last:%4s | missed:%s", stat, count, cur_nr, miss_cnt)
    inject_payload("txt", "", res)
end