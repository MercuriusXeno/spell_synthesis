--- Parameters for particle emitter for spells that has recipes
--- @class ss_fuser_particle_emitter_hint
local particle_emitter_hint_params = {
	how_many = 1,
	xvel = 6,
	yvel = 8,
	color = 0xFFFFBB35, -- 0x Alpha Blue Green Red
	lifetime_min = 0.5,
	lifetime_max = 1,
	force_create = false,
	draw_front = false,
	collide_with_grid = true,
	randomize_velocity = true,
	gravity_x = 0,
	gravity_y = -15,
}

--- Parameters for particle emitter when fusion is happening
--- @class ss_fuser_particle_emitter_fusion
local particle_emitter_fusion_params = {
	how_many = 1,
	xvel = 24,
	yvel = 32,
	color = { 0xFF00FF90, 0xFFFAFF00, 0xFFFF169A, 0xFF0026FF }, -- 0x Alpha Blue Green Red
	lifetime_min = 0.1,
	lifetime_max = 0.4,
	force_create = true,
	draw_front = false,
	collide_with_grid = true,
	randomize_velocity = true,
	gravity_x = 0,
	gravity_y = 0,
}

--- @class ss_fuser
--- @field private pe_hint ss_fuser_particle_emitter_hint
local fuser = {
	pe_hint = particle_emitter_hint_params,
	pe_fusion = particle_emitter_fusion_params,
}

--- Add particles to valid entity during fusion
--- @private
--- @param entity_id entity_id
function fuser:apply_fusion_particle(entity_id)
	local x, y = EntityGetTransform(entity_id)
	SetRandomSeed(x, y)
	GameCreateCosmeticParticle(
		"spark_white_bright",
		x,
		y - 8.5,
		self.pe_fusion.how_many,
		self.pe_fusion.xvel,
		self.pe_fusion.yvel,
		self.pe_fusion.color[Random(1, #self.pe_fusion.color)], ---@diagnostic disable-line: param-type-mismatch
		self.pe_fusion.lifetime_min,
		self.pe_fusion.lifetime_max,
		self.pe_fusion.force_create,
		self.pe_fusion.draw_front,
		self.pe_fusion.collide_with_grid,
		self.pe_fusion.randomize_velocity,
		self.pe_fusion.gravity_x,
		self.pe_fusion.gravity_y
	)
end

--- Add particles to valid entity
--- @private
--- @param entity_id entity_id
function fuser:apply_hint_particle(entity_id)
	local x, y = EntityGetTransform(entity_id)
	GameCreateCosmeticParticle(
		"spark_white_bright",
		x,
		y - 15,
		self.pe_hint.how_many,
		self.pe_hint.xvel,
		self.pe_hint.yvel,
		self.pe_hint.color, ---@diagnostic disable-line: param-type-mismatch
		self.pe_hint.lifetime_min,
		self.pe_hint.lifetime_max,
		self.pe_hint.force_create,
		self.pe_hint.draw_front,
		self.pe_hint.collide_with_grid,
		self.pe_hint.randomize_velocity,
		self.pe_hint.gravity_x,
		self.pe_hint.gravity_y
	)
end

return fuser
