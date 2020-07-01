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

	}
	method curacion() {
		personas.forEach({pers => pers.cura()})
	}
	method personaSeMudaA(persona, manzanaDestino) {
		persona.ubicarEn(manzanaDestino)
		self.personas().remove(persona)
	}
	method contagiadores() {
		return self.infectadas().filter({pers => not pers.estaAislada()})
	}
	method cantidadContagiadores() {
		return self.contagiadores().size()
	
	// cprreccion 	
	//method cantidadContagiadores() = personas.count({ p => p.noAisladas()}
		
	
		
//HECHO	 =>	 reemplazar por la cantidad de personas infectadas que no estan aisladas
	}
	
<<<<<<< HEAD
	
=======
	method noInfectades() {
		return personas.filter({ pers => not pers.estaInfectada() })
	} 	
	method infectadas() {
		return personas.filter({ p => p.estaInfectada() })
	}
	method cantidadInfectados() {
		return self.infectadas().size()
	}
>>>>>>> 87a4f9a13de1fc26c665ff0019b9e1f2464851a0
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
//¿faltaria lo de las 4 personas o mas?
	}
	
/* 	method transladoDeUnHabitante() {
		const quienesSePuedenMudar = personas.filter({ pers => not pers.estaAislada() })
		if (quienesSePuedenMudar.size() > 2) {
			const viajero = quienesSePuedenMudar.anyOne()
			const destino = simulacion.manzanas().filter({ manz => self.esManzanaVecina(manz) }).anyOne()
			self.personaSeMudaA(viajero, destino)			
		}
 	}
 */
	method transladoDeUnHabitante() {
		if (self.personasAisladas().size() > 2) {
			const viajero = self.personasAisladas().anyOne()
			const destino = simulacion.manzanas().filter({ manz => self.esManzanaVecina(manz) }).anyOne()
			self.personaSeMudaA(viajero, destino)
		}
	}
<<<<<<< HEAD
	method personasQueViven() = personas.size()
	
	method infectadas() = personas.filter({ p => p.estaInfectada()})
	
	method personasAisladas() {
		return personas.filter({pers => pers.estaAislada()}).asSet()
	}
	method contagiadores() =  self.infectadas().diference(self.personasAisladas())
	
	method noInfectades() = personas.filter({ pers => not pers.estaInfectada() })
    method noAisladas() = self.infectadas().filter({p => not p.estaAislada()})
=======
	
	
	method personasQueViven() {
		return personas.size()
	}
//	method infectadas() {
//		return personas.asSet().difference(self.noInfectades().asSet())
//	}
	
	method personasAisladas() {
		return personas.filter({pers => pers.estaAislada()})
	}
//	method contagiadores() {
//		return self.infectadas().asSet().diference(self.personasAisladas().asSet())
//	}
	// method noInfectades() = personas.filter({ pers => not pers.estaInfectada() })
	// method noAisladas() = self.infectadas().filter({p => not p.estaAislada()})
>>>>>>> 87a4f9a13de1fc26c665ff0019b9e1f2464851a0
	
	method vive(persona) {
		return personas.contains(persona)
	}
	method agregarPersonas(lista) {
		personas.addAll(lista)
	}
}


/*	method image() {
		var imagen
		if(self.infectadas() == 0) imagen = 'blanco.png'
		else if(self.infectadas().between(1,3)) imagen = 'amarillo.png'
		else if(self.infectadas().between(4,7)) imagen = 'naranja.png'
		else if(self.infectadas().between(8,self.cantDePersonas()-1)) imagen = 'naranjaOscuro.png'
		else imagen = 'rojo.png'
		return imagen
	}
	* 
	* 	method cantidadContagiadores() = self.noAisladas().size()
		// reemplazar por la cantidad de personas infectadas que no estan aisladas
	
	
	method infectadas() = personas.count({ p => p.estaInfectada()})
	
	method noInfectades() = personas.count({ pers => not pers.estaInfectada() })
	
	method noAisladas() = self.personasInfectadas().count({p => not p.estaAislada()})
	method personasInfectadas() = personas.filter({ p =>p.estaInfectada()})
	
 */