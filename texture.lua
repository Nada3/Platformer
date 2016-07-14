Texture = {}

function Texture:new(source)

	texture = {}
	texture.source = source
	texture.image = love.graphics.newImage(texture.source)
	texture.width = texture.image:getWidth()
	texture.height = texture.image:getHeight()
	texture.scale_x = 1
	texture.scale_y = 1

	function texture:load(source)
		self.source = source
		self.image = love.graphics.newImage(texture.source)
		self.width = texture.image:getWidth()
		self.height = texture.image:getHeight()
		self.scale_x = 1
		self.scale_y = 1
	end

	function texture:resize(width, height)
		self.scale_x = self.width/width
		self.scale_y = self.height/height
		self.width = width
		self.height = height
	end
	
	return texture
end
