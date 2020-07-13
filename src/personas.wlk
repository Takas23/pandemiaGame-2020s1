import simulacion.*


class Persona {
	var property estaAislada = false
	var property estaInfectada = false
	var property respetaCuarentena = false
	var property tieneSintomas = false
	var diaDeInfeccion 

	method infectarse() {
		estaInfectada = true
		diaDeInfeccion = simulacion.diaActual()
		if (simulacion.tomarChance(30)) {
			tieneSintomas = true
		}
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
	
	method cura() {
		if (self.estaInfectada() 
			and (diaDeInfeccion-simulacion.diaActual()).abs() > simulacion.duracionInfeccion())
		self.estaInfectada(false)
		self.tieneSintomas(false)
	}	
}