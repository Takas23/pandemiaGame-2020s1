import wollok.game.*

object agente {
	var property position = game.origin()
	var property image
	
	method moveEste() {
		self.position(self.position().right(1))
	}
	method moveOeste() {
		self.position(self.position().left(1))
	}
	method moveSur() {
		self.position(self.position().down(1))
	}
	method moveNorte() {
		self.position(self.position().up(1))
	}
	method aislarInfectados(){
		//aislar todos los infectados
	}
	method cuarentenarManzana(){
		//pone la manzana en cuarentena	
	}
}