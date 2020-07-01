import simulacion.*

class Persona {
	var property estaAislada = false
	var property estaInfectada = false
	var property respetaCuarentena = false
	var diaDeInfeccion 
//	var property manzanaDondeVive
	
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
	method cura() {
		if ((diaDeInfeccion-simulacion.diaActual()).abs() > 20)
		estaInfectada = false
	}
}

