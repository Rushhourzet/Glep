extends CSGMesh

func createSubtractingMesh():
	#print(self.get_children())
	var lastChild = childRecursion(self)
	var subtractingMesh = CSGSphere.new()
	subtractingMesh.global_translate(subtractingMesh.transform.origin + GlobalVars.rc_position)
	print(lastChild)
	print(GlobalVars.rc_position)
	print(subtractingMesh.transform.origin)
	if lastChild != null:
		lastChild.add_child(subtractingMesh)

func childRecursion(child):
	while child.get_child_count() > 0:		
		child = child.get_child(0)
	return child


func _on_Character_createSubtractingMesh():
	createSubtractingMesh()
