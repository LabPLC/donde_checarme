json.centros @centros.each do |centro|
	json.(centro, :nombre)
	json.(centro, :latitude)
	json.(centro, :longitude)
	json.(centro, :direccion)
	json.(centro, :encargado)
	json.(centro, :telefono)
	json.(centro, :tipo)
	json.(centro, :horario)
	json.(centro, :categories)
	json.(centro, :id)
	json.(centro, :tipo)
	json.(centro, :subtipo)
end