import wollok.game.*
import simulacion.*
import manzanas.*
import personas.*

object agente {
	var property position = game.origin()
	var property image = "agenteDeSalud.png"
	const property manzanaActual = self.manzanaDondeEstoyParado()
	
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
		const aislar = {p => p.estaAislada(true)}
		manzanaActual.infectadas().forEach(aislar)
//HECHO		aislar todos los infectados
	}
	
	method cuarentenarManzana(){
		const cuarentenar = {p => p.respetaCuarentena(true)}
		manzanaActual.personas().forEach(cuarentenar)
//HECHO		pone la manzana en cuarentena	
	}
	
	method manzanaDondeEstoyParado(){
		const mismaManzana = {m => m.position() == self.position()}
		return simulacion.manzanas().find(mismaManzana)
	}
}