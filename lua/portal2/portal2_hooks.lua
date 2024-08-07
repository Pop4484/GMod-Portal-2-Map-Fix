hook.Add( "AcceptInput", "Portal 2 Map Fix - RunScriptCode", function( ent, name, activator, caller, data )
    if name == "RunScriptCode" then
        print(ent:GetName().." Ran "..data)
        RunString(data,ent:GetName()..":"..data) // this is a lot better lmao
    end
end )

local fsteps = {
    "player/footsteps/fs_fm_lightbridge_01.wav",
    "player/footsteps/fs_fm_lightbridge_02.wav",
    "player/footsteps/fs_fm_lightbridge_03.wav",
    "player/footsteps/fs_fm_lightbridge_04.wav",
    "player/footsteps/fs_fm_lightbridge_05.wav",
    "player/footsteps/fs_fm_lightbridge_06.wav",
    "player/footsteps/fs_fm_lightbridge_07.wav",
    "player/footsteps/fs_fm_lightbridge_08.wav"
}

hook.Add("PlayerFootstep","Portal 2 Map Fix - Footsteps",function(ply,pos,foot,snd,vol,filter)
    local ground = ply:GetGroundEntity()
    if !IsValid(ground) then return false end 
    if ground:GetClass() == "projected_wall_entity" then
        EmitSound(fsteps[math.random(#fsteps)],pos)
        return true
    end
end)