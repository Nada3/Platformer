require 'entity'
require 'texture'

TexturedEntity = {}

function TexturedEntity:new()

	textured_entity = {}

	function textured_entity:create(texture, x, y)
		local texture = Texture:new(texture)
		local entity = Entity:new(x, y, texture.width, texture.height)

		for key, data in pairs(texture) do
			self[key] = data
		end

		for key, data in pairs(entity) do
			self[key] = data
		end
	end

	return textured_entity
end	
