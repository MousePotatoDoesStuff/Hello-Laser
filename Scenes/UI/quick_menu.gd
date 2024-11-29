extends Control
class_name QuickMenu

signal back_signal
signal next_signal

func configure(is_done:bool):
	if is_done:
		$Next.show()
	else:
		$Next.hide()


func _on_back_pressed() -> void:
	back_signal.emit()


func _on_next_pressed() -> void:
	next_signal.emit()
