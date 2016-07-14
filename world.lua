World = {}

function World:new(width, height)

	world = {}
	world.width = width
	world.height = height
	world.entity = {}
	world.jump_list = {}

	function world:add_entity(entity, tag)
		if tag then
			self.entity[tag] = entity
		else
			table.insert(self.entity, entity)
			return table.getn(self.entity)
		end
	end

	function world:remove_entity(tag)
		table.remove(self.entity, tag)
	end

	function world:get_entity_by_tag(tag)
		if self.entity[tag] then
			return self.entity[tag]
		else
			return -1
		end
	end

	function world:jump(tag, max)
		local jmp = {tag=tag, max=max, acc=0}
		local aj = false
		local entity = self:get_entity_by_tag(tag)
		if entity.fall then aj = true end
		if entity.jump then aj = true end

		if not aj then
			self:get_entity_by_tag(tag).jump = true
			table.insert(self.jump_list, jmp)
		end
	end

	function world:test_collide_with_all(obj)
		for id, entity in pairs(self.entity) do
			if obj:test_collide(entity.x, entity.y, entity.width, entity.height) and entity ~= obj then
				return entity
			end
		end
		return false
	end

	function world:update(dt)
		for id, jmp in pairs(self.jump_list) do
			if not jmp.fall then
				local entity = self:get_entity_by_tag(jmp.tag)
				entity:move(0, -entity.speed)
				jmp.acc = jmp.acc + entity.speed
				local collide = self:test_collide_with_all(entity)
				if jmp.acc >= jmp.max or collide then
					table.remove(self.jump_list, id)
					entity.fall = true
					entity.jump = false
				end
			end
		end	
		for id, entity in pairs(self.entity) do
			if not self:test_collide_with_all(entity) and not entity.jump and entity.y ~= self.width - entity.width then
				entity.fall = true
			end
			if entity.fall then
				entity:move(0, entity.speed)
				local collide = self:test_collide_with_all(entity)
				if collide then
					if entity.y <= collide.y then
						entity.y = collide.y - entity.width
						entity.fall = false
					end
				end
				if entity.y >= self.width - entity.width then
					entity.y = self.width - entity.width
					entity.fall = false
				end
			end		
		end
	end

	function world:draw()
		for id, entity in pairs(self.entity) do
			if entity.image ~= nil then
				love.graphics.draw(entity.image, entity.x, entity.y, 0, entity.scale_x, entity.scale_y)
			else
				love.graphics.rectangle('fill', entity.x, entity.y, entity.width, entity.height)
			end
		end
	end
	
	return world

end
