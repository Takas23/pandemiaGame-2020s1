import wollok.game.*
import simulacion.*
import manzanas.*
import personas.*

object agente {
	var property position = game.origin()
	var property image = "agenteDeSalud.png"
	
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
		self.manzanaActual().infectadas().forEach({p => p.estaAislada(true)})
	}

	method cuarentenarManzana(){
		self.manzanaActual().personas().forEach({p => p.respetaCuarentena(true)})
	}

	method manzanaActual(){
		return simulacion.manzanas().find({m => m.position() == self.position()})
	}
}