import personas.*
import manzanas.*

object simulacion {
	var property diaActual = 0
	const property manzanas = []
	
	// parametros del juego
	const property chanceDePresentarSintomas = 30
	const property chanceDeContagioSinCuarentena = 25
	const property chanceDeContagioConCuarentena = 2
	const property personasPorManzana = 10
	const property duracionInfeccion = 20

	/*
	 * este sirve para generar un azar
	 * p.ej. si quiero que algo pase con 30% de probabilidad pongo
	 * if (simulacion.tomarChance(30)) { ... } 
	 */ 	
	method tomarChance(porcentaje) = 0.randomUpTo(100) < porcentaje

	method agregarManzana(manzana) { manzanas.add(manzana) }
	
	method debeInfectarsePersona(persona, cantidadContagiadores) {
		const chanceDeContagio = if (persona.respetaCuarentena()) 
			self.chanceDeContagioConCuarentena() 
			else 
			self.chanceDeContagioSinCuarentena()
		return (1..cantidadContagiadores).any({n => self.tomarChance(chanceDeContagio) })	
	}

/* 	method crearManzana() {
		const nuevaManzana = new Manzana()
				// agregar la cantidad de personas segun self.personasPorManzana()
		return nuevaManzana
	}
*/
//revisar
 	method crearManzana() {
		const nuevaManzana = new Manzana()
		nuevaManzana.agregarPersonas(self.crear_Personas(personasPorManzana))
			return nuevaManzana
	}
	method crear_Personas(cantidad) {
		var contador = cantidad
		const nuevasPersonas = []
			if (cantidad > 0) { 
				nuevasPersonas.add(self.crearPersona())
				contador -= 1
			}
				return nuevasPersonas
	}

	method crearPersona() {
		return new Persona()
	}
	
//	method nuevoInfectado() {
//		self.manzanaRandom().add(self.crearInfectado())
//	}
	method crearInfectado() {
		self.crearPersona().infectarse()
	}
	method manzanaRandom() {
		return manzanas.anyOne()
	}

}