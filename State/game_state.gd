extends Node

const Big = preload("res://Utils/big.gd")

var state = {
	"coins": Big.new(0),
	"purchases": []
}

signal onMoneyChange(money: Big)

enum BouncerPowers {BOUNCY, EXPLOTES, SIZE}

func addMoney(amount: Big):
	self.state.coins.plusEquals(amount)
	self.onMoneyChange.emit(self.state.coins)

func getPowerDuration(power: BouncerPowers):
	return 5
