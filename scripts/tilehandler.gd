extends Node2D

const TILE = preload("res://scenes/tile.tscn")
const REDTILE = preload("res://scenes/redtile.tscn")
var tileInstance 

var playersx
var playersy

func BeginGeneration(player):
	#creates a tile instance under the players feet
	CreateTile(player.position.x/16, player.position.y/16)
	#then checks the x and y around the player
	for x in range(-(player.values["move"] + 1),player.values["move"] + 2):
		for y in range(-(player.values["move"] + 1), player.values["move"] + 2):
			playersx = (player.position.x / 16) + x
			playersy = (player.position.y / 16) + y
			# and if in within range, creates tiles
			if sqrt(y*y) + sqrt(x*x)  <= (player.values["move"]) and sqrt(y*y) + sqrt(x*x) != 0 :
				CreateTile(playersx,playersy)
				pass
			if sqrt(y*y) + sqrt(x*x)  > (player.values["move"]) and sqrt(y*y) + sqrt(x*x) == (player.values["move"]) + 1:
				CreateRedTile(playersx,playersy)
				pass


func CreateTile(x, y):
	tileInstance = TILE.instantiate()
	tileInstance.position = Vector2(x*16,y*16) 
	add_child(tileInstance)

func CreateRedTile(x,y):
	tileInstance = REDTILE.instantiate()
	tileInstance.position = Vector2(x*16,y*16)
	add_child(tileInstance)

func DeleteTiles():
	for i in get_children():
		remove_child(i)
