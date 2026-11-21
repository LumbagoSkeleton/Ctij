# Global script with generally useful player data

extends Node

var inventory:Dictionary[Vector2, Item]
enum State { IDLE, IN_MENU }
var state:State = State.IDLE
