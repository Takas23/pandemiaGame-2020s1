import personas.*
import simulacion.*
import wollok.game.*

class Manzana {
	const property personas = []
	var property position
	
	method image() {
// HECHO		 reeemplazarlo por los distintos colores de acuerdo a la cantidad de infectados
		// también vale reemplazar estos dibujos horribles por otros más lindos
		
		return if(self.infectadas().size() == self.personasQueViven()){
			"rojo.png"
		}
		else if(self.infectadas().size() > 7 and self.infectadas().size() < self.personasQueViven()){
			"naranjaOscuro.png"
		}
		else if(self.infectadas().size().between(4,7)){
			"narnaja.png"
		}
		else if(self.infectadas().size().between(1,3)){
			"amarillo.png"
		}
		else {
			"blanco.png"
		}
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
	
	method noInfectades() {
		return personas.filter({ pers => not pers.estaInfectada() })
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
	method personasQueViven() {
		return personas.size()
	}
	method infectadas() {
		return personas.asSet().difference(self.noInfectades().asSet())
	}
	//
	//method infectadas() = personas.filter({ p => p.estaInfectada()})
	
	method personasAisladas() {
		return personas.filter({pers => pers.estaAislada()}).asSet()
	}
	method contagiadores() {
		return self.infectadas().diference(self.personasAisladas())
	}
	// method noInfectades() = personas.filter({ pers => not pers.estaInfectada() })
	// method noAisladas() = self.infectadas().filter({p => not p.estaAislada()})
	
	method vive(persona) {
		return personas.contains(persona)
	}
	method agregarPersonas(lista) {
		personas.addAll(lista)
	}
}
