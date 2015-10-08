_PRESERVATION_VERSION = read_config("preservation_version") or 0
_PRESERVATION_VERSION = _PRESERVATION_VERSION + 1 -- force a revision update due to internal changes

require "circular_buffer"
require "string"
local alert         = require "alert"
local annotation    = require "annotation"
local anomaly       = require "anomaly"

local title             = "Linar Increase"
local rows              = read_config("rows") or 1440
local sec_per_row       = read_config("sec_per_row") or 1
local anomaly_config    = anomaly.parse_config(read_config("anomaly_config"))
local alert_throttle    = read_config("alert_throttle") or 3600
alert.set_throttle(alert_throttle * 1e9)

annotation.set_prune(title, rows * sec_per_row * 1e9)

lin_inc = circular_buffer.new(rows, 1, sec_per_row)
lin_inc:set_header(1, "UNIX_EPOCH")

function process_message ()
    local ts = read_message("Timestamp")
    local epoch = read_message("Payload")
    if type(epoch) ~= "number" then return -1 end

    lin_inc:add(ts, epoch, 1) -- col will be truncated to an int
    return 0
end

function timer_event(ns)
    if anomaly_config then
        if not alert.throttled(ns) then
            local msg, annos = anomaly.detect(ns, title, lin_inc, anomaly_config)
            if msg then
                annotation.concat(title, annos)
                alert.send(ns, msg)
            end
        end
        inject_payload("cbuf", title, annotation.prune(title, ns), lin_inc)
    else
        inject_payload("cbuf", title, lin_inc)
    end
end