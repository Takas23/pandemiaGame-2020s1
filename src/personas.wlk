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
	}	//testeado OK
	
	method viveCon(persona) {
		return self.dondeVive() == persona.dondeVive()
	}	//testeado OK
	
	method ubicarEn(manzana) {	
		manzana.personas().add(self)	
	}	//testeado OK
	
	method cura() {
		if (self.estaInfectada() 
			and (diaDeInfeccion-simulacion.diaActual()).abs() > simulacion.duracionInfeccion())
		self.estaInfectada(false)
	}	//testeado OK
}