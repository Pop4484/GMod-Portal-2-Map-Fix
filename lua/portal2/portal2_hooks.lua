hook.Add( "AcceptInput", "Portal 2 Map Fix - RunScriptCode", function( ent, name, activator, caller, data )
    if name == "RunScriptCode" then
        print(ent:GetName().." Ran "..data)
        RunString(data,ent:GetName()..":"..data) // this is a lot better lmao
    end
end )