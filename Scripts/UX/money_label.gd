extends Label

var Big = preload("res://Utils/big.gd")

var exp_str = ["", "K", "M", "B", "T", "C", "Q", "S", "Sp", "E", "N", "D"]

func _ready():
	GameState.onMoneyChange.connect(self.onMoneyChange)
	
func onMoneyChange(amount: Big):
	self.text = "Money: " + amount.toAA()
	
func parseMoney(amount: int):
	var exp = amount / 1000
	
