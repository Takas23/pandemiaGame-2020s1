import personas.*
import simulacion.*
import wollok.game.*

class Manzana {
	const property personas = []
	var property position
	
	method image() {
		// reeemplazarlo por los distintos colores de acuerdo a la cantidad de infectados
		// también vale reemplazar estos dibujos horribles por otros más lindos
		return "blanco.png"
	}
	
	// este les va a servir para el movimiento
	method esManzanaVecina(manzana) {
		return manzana.position().distance(position) == 1
	}

	method pasarUnDia() {
		self.transladoDeUnHabitante()
		self.simulacionContagiosDiarios()
		self.curacion()
//HECHO despues agregar la curacion
	}
	method curacion() {
		personas.forEach({pers => pers.cura()})
	}
	method personaSeMudaA(persona, manzanaDestino) {
		// implementar
	}

	method cantidadContagiadores() {
		return self.contagiadores().size()
	
	// cprreccion 	
	//method cantidadContagiadores() = personas.count({ p => p.noAisladas()}
		
	
		
//HECHO	 =>	 reemplazar por la cantidad de personas infectadas que no estan aisladas
	}
	
	
	// method noInfectades() = personas.filter({ pers => not pers.estaInfectada() })
	
	method simulacionContagiosDiarios() { 
		const cantidadContagiadores = self.cantidadContagiadores()
		if (cantidadContagiadores > 0) {
			self.noInfectades().forEach({ persona => 
				if (simulacion.debeInfectarsePersona(persona, cantidadContagiadores)) {
					persona.infectarse()
				}
			})
		}
	}
	
	method transladoDeUnHabitante() {
		const quienesSePuedenMudar = personas.filter({ pers => not pers.estaAislada() })
		if (quienesSePuedenMudar.size() > 2) {
			const viajero = quienesSePuedenMudar.anyOne()
			const destino = simulacion.manzanas().filter({ manz => self.esManzanaVecina(manz) }).anyOne()
			self.personaSeMudaA(viajero, destino)			
		}
	}
	method personasQueViven() = personas.size()
	
	method infectadas() = personas.filter({ p => p.estaInfectada()})
	
	method personasAisladas() {
		return personas.filter({pers => pers.estaAislada()}).asSet()
	}
	method contagiadores() =  self.infectadas().diference(self.personasAisladas())
	
	method noInfectades() = personas.filter({ pers => not pers.estaInfectada() })
    method noAisladas() = self.infectadas().filter({p => not p.estaAislada()})
	
	method vive(persona) {
		return personas.contains(persona)
	}
	method agregarPersonas(lista) {
		personas.addAll(lista)
	}
}
