AddCSLuaFile()
ENT.Type = "point"
ENT.Base = "base_point"

function ENT:AcceptInput(name, activator, caller, data)
    if name == "ChangeLevel" then
        RunConsoleCommand("changelevel",data) 
    end
end
