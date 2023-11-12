// bad implementation of """""vscript"""""
AddCSLuaFile()

ENT.Base = "base_point"
ENT.Type = "point"

include("portal2/portal2_common.lua") // Include the Portal 2 VScript Functions lua file

// Go through Portal 2 LUA Ported VScript files, you can add custom ones too!
local files,dir = file.Find("lua/portal2/vscript/*","GAME")
for i,script in pairs(files) do
    include("lua/portal2/vscript/"..script)
end

function ENT:AcceptInput( name, activator, caller, data )
    if name == "RunScriptCode" then
        print(self:GetName().." Ran "..data)
        RunString(data,self:GetName()..":"..data) // this is a lot better lmao

        //painful code alert
        /*if data == "StartClawPickup()" then
            StartClawPickup()
        end
        if data == "sp_a1_wakeup_WheatleyGettingGrabbed()" then
            sp_a1_wakeup_WheatleyGettingGrabbed()
        end*/
    end
end