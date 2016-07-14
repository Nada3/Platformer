Entity = {}

function Entity:new(x, y, w, h, s)
	
	entity = {}
	entity.x = x or 0
	entity.y = y or 0
	entity.width = w or 1
	entity.height = h or 1
	entity.speed = s or 0
	entity.fall = false
	entity.jump = false

	function entity:move(vx, vy)
		self.x = self.x + vx
		self.y = self.y + vy
	end

	function entity:test_collide(x, y, width, height)
		if (x >= self.x + self.width) or (x + width <= self.x) or (y >= self.y + self.height) or (y + height <= self.y) then
			return false
		else
			return true
		end
	end

	return entity
end
