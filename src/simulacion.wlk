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

	method totalPersonas() {
		return manzanas.sum({m => m.personasQueViven()})
	}	//testeado OK
	
	method totalInfectados() {
		return manzanas.sum({m => m.cantidadInfectados()})
	}
	
	method totalSintomaticos() {
		return manzanas.sum({m => m.cantidadSintomaticos()})
	}
	
	method crearManzana() {
		return new Manzana()
	}
	
 	method crearPersona() {
		return new Persona()
	}

	method crearInfectado() {
		return new Persona(estaInfectada = true, diaDeInfeccion = diaActual)
	}	//OK
	
	method nuevoInfectado() {
		self.manzanaRandom().personas().add(self.crearInfectado())
	}	//OK
	
	method manzanaRandom() {
		return manzanas.anyOne()
	}	//OK
	
	method pasaUnDia() {
		manzanas.forEach({m => m.pasarUnDia()})
		diaActual += 1
	}
}