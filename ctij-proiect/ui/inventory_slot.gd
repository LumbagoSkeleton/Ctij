extends TextureRect

class_name InventorySlot

const WIDTH = 24
const HEIGHT = 24

enum ContainerType { PLAYER,CHEST }
var container:ContainerType
var inv_item:InventoryItem
var grid_pos:Vector2i
