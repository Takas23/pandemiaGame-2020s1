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

	method agregarManzana(manzana) {
		manzanas.add(manzana) 
	}	//testeado OK
	
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
	method totalPersonas() {
		return manzanas.sum({m => m.personasQueViven()})
	}	//testeado OK
	
	method totalInfectados() {
		return manzanas.sum({m => m.cantidadInfectados()})
	}
//revisar 
/* 
	method crearManzana() {
		const nuevaManzana = new Manzana()
		nuevaManzana.agregarPersonas(self.crear_Personas(personasPorManzana))
			return nuevaManzana
	}
*/
	method crearManzana() {
		return new Manzana()
	}


//revisar
/* 
	method crear_Personas(cantidad) {
		var contador = cantidad
		const nuevasPersonas = []
			if (contador > 0) { 
				nuevasPersonas.add(self.crearPersona())	
				contador -= 1
				self.crear_Personas(contador)		
			}
				return nuevasPersonas
	}

	method crear_Personas() {
		manzanas.forEach({ m =>
		(1..personasPorManzana).forEach({ e => 
			const nuevaPers = self.crearPersona()
			m.agregarPersona(nuevaPers) 
		})
	})
	}
	* 
	*/
	/*	
	method agregarPersonas() {
		manzanas.forEach({m =>
			(1..personasPorManzana).forEach({n =>
			self.crearPersona().ubicarEn(m)
		})})
	}
	*/
	
	
 	method crearPersona() {
		return new Persona()
	}

	method crearInfectado() {
		return new Persona(estaInfectada = true, diaDeInfeccion = diaActual)
	}	//OK
	
	method nuevoInfectado() {
		self.manzanaRandom().personas().add(self.crearInfectado())
	}	//OK
	
/*	method crearInfectado() {
		return self.crearPersona().infectarse()
	}
*/
	method manzanaRandom() {
		return manzanas.anyOne()
	}	//OK
	
	method pasaUnDia() {
		manzanas.forEach({m => m.pasarUnDia()})
		diaActual += 1
	}


}