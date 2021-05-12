import insert from table
import newQuad from love.graphics

generateUVs = (texture, tileSize)->
	uvsQuads = {}
	uvs = {}

	textureW = texture\getWidth!
	textureH = texture\getHeight!
	print textureW, textureH

	-- tile width/height as a persentage of the texture
	widthPs = tileSize / textureW
	heightPs = tileSize / textureH
	cols = textureW / tileSize
	rows = textureH / tileSize

	-- top left position of the tile in texture
	left = 0
	top = 0

	-- bottom right position of the tile in texture
	right = widthPs
	bottom = heightPs

	for j = 0, rows - 1
		for i = 0, cols - 1
			insert uvsQuads, newQuad left * textureW,
				top * textureH,
				right * textureW,
				bottom * textureH,
				texture
			insert uvs, {top, left, bottom, right}
			left += widthPs
			right += widthPs
		left = 0
		top += heightPs
		right = widthPs
		bottom += heightPs

	uvsQuads, uvs


generateUVs
