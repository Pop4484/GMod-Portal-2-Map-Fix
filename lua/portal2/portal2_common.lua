// Common functions used in Portal 2 VScript.

function EntFire(targetname, inp, param, delay)
    local targets = ents.FindByName(targetname)
    for i,v in pairs(targets) do
        v:Fire(inp,param,delay)
    end
end