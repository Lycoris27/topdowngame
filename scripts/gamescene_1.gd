extends Node2D

const TILE = preload("res://scenes/tile.tscn") 
const REDTILE = preload("res://scenes/redtile.tscn")
@onready var tilehandler = $tilehandler

var math
var mathx
var mathy
var playersx
var playersy
var heldno
var tileInstance 


### inactive: playerturn
### Requiring improvements: attackmode

var tilemode = false # whenever player tiles are active
var enemytilemode = false # whenever enemy tiles are active
var checkmode = false # when player is moving
var attackmode = false # when player is attacking
var playerturn = true # when we want to swap to enemy turn to have enemies move

var heldplayer : Node 
var heldplayerpos



### we need an enemy
 
func SendEnterSignal(character, sender, posx, posy, input):
	if enemytilemode:
		CancelTiles()
		enemytilemode = false
	elif input:
		if checkmode:
			ConfirmAction(attackmode, heldplayer, character)
		elif tilemode:
			MoveLocation(heldplayer, sender, character)
		elif character != null:
			GenerateTiles(character)
	elif !input:
		if checkmode:
			DenyAction(heldplayer)
		elif tilemode:
			CancelTiles()


func GenerateTiles(player): # this will generate the tiles around the player
	
	if player.playerInAction and player.name ==  "Enemy":
		enemytilemode = true
		tilehandler.BeginGeneration(player)

	elif player.playerInAction: # if the player is allowed to act
		tilemode = true
		heldplayer = player
		tilehandler.BeginGeneration(player)




#movelocation and attackenemy should be combined, just make it send to another function for the if statement and do different things based on the circumstance
func MoveLocation(player, cursor, cha): # this will change the location of the player and delete all tiles
	if cha != null: 
		if cha.name == "Enemy":
			heldno = 2
	else:
		heldno = 1
	print("passing through with heldno = ", heldno)
	if WithinRange(player, player.position, cursor.position, heldno):
		if heldno == 1:
			heldplayerpos = player.position
			player.position = cursor.position
			checkmode = true
		elif heldno == 2:
			player.position.x = cursor.heldposx
			player.position.y = cursor.heldposy
			checkmode = true
			attackmode = true
			pass

func CancelTiles(): # turns off tilemode and deletes all tiles on the tilehandler
	tilemode = false
	tilehandler.DeleteTiles()
	pass

func ConfirmAction(attack, player, enemy): # deletes all tiles, tells the player its no longer able to act, and turns both tilemode and checkmode off
	tilehandler.DeleteTiles()
	checkmode = false
	tilemode = false
	heldplayer.playerInAction = false
	if attack:
		enemy.TakeDamage(player.stats["atk"])
		if enemy.values["healthC"] > 0:
			player.TakeDamage(enemy.stats["atk"])
			if player.value["HealthC"] <= 0:
				player.Die()
		else:
			enemy.Die()

func DenyAction(player): # sets the player back to starting position, then turns checkmode off
	player.position = heldplayerpos
	checkmode = false
	pass

func WithinRange(player, playpos, curpos, no):
	math = (playpos - curpos) * (playpos - curpos)
	mathx = sqrt(math.x)/16
	mathy = sqrt(math.y)/16 
	if mathx + mathy < player.values["move"] + no:
		print("succeeded")
		return true
	else:
		print("failed")
		return false


# attack mode will be a second checkmode, if the player is attempting to 
func Attack():
	pass

func Items():
	pass

func Wait():
	pass
