require "string"
require "table"
require "math"

local function ToInteger(number)
    return math.floor(tonumber(number) or error("Could not cast '" .. tostring(number) .. "' to number.'"))
end

function add_to_buffer(list_element)
   table.insert(buffer,list_element)
   if (#buffer > buffer_size)then
      while #buffer > buffer_size do 
         table.remove(buffer,1)
      end
   end
   return buffer
end

function print_list(list_object)
   print("## print list")
   for i, k in ipairs(list_object) do
      print("k-> "..k)
   end
end

function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function harvest_missing()
    local copy = deepcopy(buffer)
    local cur = -1
    table.sort(copy)
    for idx, cur in ipairs(copy) do
        if not (last_nr == -1) then
            if not (last_nr + 1 == cur) then
                if last_nr < cur then
                    if not table.contains(missed, cur) then
                        msg = string.format("last_nr:%s <> %s:cur", last_nr, cur)
                        table.insert(missed, cur)
                    end
                --else
                    --msg = string.format("last_nr:%s was bigger then cur:%s, which indicates that heka was just started. Won't consider this a MISS", last_nr, cur)
                end
            end
        end
        last_nr = cur
    end
    
end



buffer = {}
buffer_size = 65000
missed = {}
reset = false
miss = false
last_nr = -1
count = 0
msg = ""

function process_message()
    count = count + 1
    local payload = read_message("Payload")
    cur_nr = ToInteger(payload)
    if count == 1 then
        reset = true
    else
        add_to_buffer(cur_nr)
    end
    return 0
end

function timer_event(ns)
    stat = "OK"
    extra = ""
    if reset then
        stat = "RESET"
        last_nr = -1
        reset = false
    end
    cnt_missed = table.getn(missed)
    harvest_missing()
    if not (cnt_missed == table.getn(missed)) then
        stat = "MISS"
    end
    res = string.format("%6s > Seen '%6s' msg so far | last:'%6s' | missed: %s | %s", stat, count, last_nr, table.concat(missed, ","), msg)
    inject_payload("txt", "", res)
end