import wollok.game.*
import simulacion.*


object agente {
	var property position = game.origin()
	var property image = "agenteDeSalud.png"
	
	
	method moveEste() {
		if (self.puedeMoverE())
		self.position(self.position().right(1))
	}
	
	method moveOeste() {
		if (self.puedeMoverO())
		self.position(self.position().left(1))
	}
	
	method moveSur() {
		if (self.puedeMoverS())
		self.position(self.position().down(1))
	}
	
	method moveNorte() {
		if (self.puedeMoverN())
		self.position(self.position().up(1))
	}
	

	method aislarInfectados(){
		self.manzanaActual().infectadas().forEach({p => p.estaAislada(true)})
	}

	method cuarentenarManzana(){
		self.manzanaActual().personas().forEach({p => p.respetaCuarentena(true)})
		self.ponerCinta()
	}

	method manzanaActual(){
		return simulacion.manzanas().find({m => m.position() == self.position()})
	}
	
	method puedeMoverN() {
		return self.position().y() < (game.height()-1)
	}
	method puedeMoverS() {
		return self.position().y() > 0
	}
	method puedeMoverE() {
		return self.position().x() < (game.width()-1)
	}
	method puedeMoverO() {
		return self.position().x() > 0
	}
	method dondeEstoy() {
		return simulacion.manzanas().find({m => m.position() == self.position()})
	}
	method ponerCinta() {
		const cinta = new CintaCuarentena(position = self.position())
		game.addVisual(cinta)
	}
}

class CintaCuarentena {
	var property position
	method image() {
		return "cuarentena3.png"
	}
}