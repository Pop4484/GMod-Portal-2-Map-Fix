ENT.Base = "base_point"
ENT.Type = "point"

ENT.active = false
ENT.start_active = false

ENT.maxblobcount = 250
ENT.blobs_per_second = 1
ENT.min_speed = 100
ENT.max_speed = 100
ENT.blob_spread_radius = 0
ENT.blob_spread_angle = 0
ENT.blob_streak_percentage = 0
ENT.min_streak_time = 0.2
ENT.max_streak_time = 0.5
ENT.min_streak_speed_dampen = 500 
ENT.max_streak_speed_dampen = 1000 

function ENT:KeyValue( key, value )
	if key == "maxblobcount" then
		self.active = value
	end
	if key == "start_active" then
		self.start_active = value
	end
    if key == "blobs_per_second" then
		self.blobs_per_second = value
	end
    if key == "min_speed" then
		self.min_speed = value
	end
    if key == "max_speed" then
		self.max_speed = value
	end
    if key == "blob_spread_radius" then
		self.blob_spread_radius = value
	end
    if key == "blob_spread_angle" then
		self.blob_spread_angle = value
	end
    if key == "blob_streak_percentage" then
		self.blob_streak_percentage = value
	end
    if key == "min_streak_time" then
		self.min_streak_time = value
	end
    if key == "max_streak_time" then
		self.max_streak_time = value
	end
end

function ENT:Think()
    if CLIENT then return end
    if !self.active then return end
    local blob = ents.Create("paint_sphere")
    blob:SetVelocity(self:GetAngles():Forward() * math.random(self.min_speed,self.max_speed))
    blob:SetPos(self:GetPos()/*+Vector(
        math.random(-self.blob_spread_radius,self.blob_spread_radius),
        math.random(-self.blob_spread_radius,self.blob_spread_radius),
        math.random(-self.blob_spread_radius,self.blob_spread_radius)):Rotate(self:GetAngles())*/)
    blob:Spawn()
    self:NextThink(CurTime() + (1/self.blobs_per_second))
    return true
end