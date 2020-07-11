import simulacion.*


class Persona {
	var property estaAislada = false
	var property estaInfectada = false
	var property respetaCuarentena = false
	var diaDeInfeccion 

	
	method infectarse() {
		estaInfectada = true
		diaDeInfeccion = simulacion.diaActual()
	}	//testeado OK
	
//	method sePuedeContagiar(persona) { if(self.manzanaDondeVive() == persona.manzanaDondeVive()) persona.infectarse()
//	}
//revisar
	method sePuedeContagiar(persona) {
		if(self.viveCon(persona)) {
			persona.infectarse()}
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
	
/* 	method cura() {
		if ((diaDeInfeccion-simulacion.diaActual()
		).abs() > simulacion.duracionInfeccion())
		estaInfectada = false
	}

*/
	method cura() {
		if (self.estaInfectada() 
			and (diaDeInfeccion-simulacion.diaActual()).abs() > simulacion.duracionInfeccion())
		self.estaInfectada(false)
	}	//testeado OK
}


/*class Persona {
	var property estaAislada = false
	var property respetaCuarentena = true
	var property diaQueSeInfecto = 0
	var property presentaSintomas = false
	var property estaInfectada = false
	var property manzanaDondeVive = 0
	
	
	method infectarse() {
		// implementar 
		estaInfectada = true 
		diaQueSeInfecto = simulacion.diaActual()	
	}
	method sePuedeContagiar(persona) = self.manzanaDondeVive() == persona.manzanaDondeVive() and  persona.infestadaYNoAislada()
	method infestadaYNoAislada() = self.estaInfectada() and not self.estaAislada()
}*/


