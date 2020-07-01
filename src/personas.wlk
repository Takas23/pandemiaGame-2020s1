import simulacion.*

class Persona {
	var property estaAislada = false
	var property estaInfectada = false
	var property respetaCuarentena = false
	var diaDeInfeccion 

	
	method infectarse() {
		estaInfectada = true
		diaDeInfeccion = simulacion.diaActual()
	}
//	method sePuedeContagiar(persona) { if(self.manzanaDondeVive() == persona.manzanaDondeVive()) persona.infectarse()
//	}
	method sePuedeContagiar(persona) {
		if(self.viveCon(persona)) {
			persona.infectarse()}
	}
	method dondeVive() {
		return simulacion.manzanas().find({m => m.vive(self)})
	}
	method viveCon(persona) {
		return self.dondeVive() == persona.dondeVive()
	}
	method ubicarEn(manzana) {
		manzana.personas().add(self)	
	}
/* 	method cura() {
		if ((diaDeInfeccion-simulacion.diaActual()
		).abs() > simulacion.duracionInfeccion())
		estaInfectada = false
	}

*/
	method cura() {
		if (self.estaInfectada() 
			and (diaDeInfeccion-simulacion.diaActual()).abs() > simulacion.duracionInfeccion())
		self.estaInfectada(true)
	}
}

/* 
class Persona {
	var property estaAislada = false
	var property respetaLaCuarentena = true
	var property diaQueSeInfecto = 0
	var property presentaSintomas = false
	var property estaInfectada = false
	
	
	method infectarse() {
		// implementar 
		estaInfectada = true 
		diaQueSeInfecto = simulacion.diaActual()
		
		
	}
}

 
 */