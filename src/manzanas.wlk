import personas.*
import simulacion.*
import wollok.game.*

//clase abstracta
class Manzana {
	const property personas = []
	var property position

	method image()
	
	method noInfectadas() {
		return personas.filter({ pers => not pers.estaInfectada()})
	} 	
	
	method infectadas() {
		return personas.filter({ p => p.estaInfectada() })
	}	
	
	method cantidadInfectados() {
		return self.infectadas().size()
	}	
	
	method sintomaticos() {
		return self.infectadas().filter({ p => p.tieneSintomas()})
	}
	
	method cantidadSintomaticos() {
		return self.sintomaticos().size()
	}
	
	method personasAisladas() {
		return personas.filter({pers => pers.estaAislada()})
	}
	
	method cantidadAisladas() {
		return self.personasAisladas().size()
	}
	
	method noAisladas() = personas.filter({p => not p.estaAislada()})
	
	method personasQueViven() {
		return personas.size()
	}	
	
	method esManzanaVecina(manzana) {
		return manzana.position().distance(position) == 1
	}

	method vive(persona) {
		return personas.contains(persona)
	}	
	
	method pasarUnDia() {
		self.transladoDeUnHabitante()
		self.simulacionContagiosDiarios()
		self.curacion()

	}
	method curacion() {
		personas.forEach({pers => pers.cura()})
	}	

	method contagiadores() = self.infectadas().filter({p => not p.estaAislada()})	

	method cantidadContagiadores() {
		return self.contagiadores().size()
	}
	

	method simulacionContagiosDiarios() { 
		const cantidadContagiadores = self.cantidadContagiadores()
	
		if (cantidadContagiadores > 0) {
			self.noInfectadas().forEach({p => 
				(1..cantidadContagiadores).forEach({n => 
					if (simulacion.debeInfectarsePersona(p, cantidadContagiadores)) {
						p.infectarse()}
			})
		})}
	}
	
	method transladoDeUnHabitante() {
		if (self.noAisladas().size() > 2) {
			const viajero = self.noAisladas().anyOne()
			const destino = simulacion.manzanas().filter({ manz => self.esManzanaVecina(manz) }).anyOne()
			self.personaSeMudaA(viajero, destino)
		}
	}
	
	method personaSeMudaA(persona, manzanaDestino) {
		persona.ubicarEn(manzanaDestino)
		personas.remove(persona)
	}
	
	method agregarPersonasManzana() {
			(1..simulacion.personasPorManzana()).forEach({n =>
			simulacion.crearPersona().ubicarEn(self)})
	}
}

class ManzanaA inherits Manzana {
	override method image() {
		return if ((self.cantidadInfectados() == self.personasQueViven())) {
			"c1r.png"
		}
		else if(self.cantidadInfectados().between(8, (self.personasQueViven()-1))) {
			"c1nn.png"
		}
		else if(self.cantidadInfectados().between(4,7)){
			"c1n.png"
		}
		else if(self.cantidadInfectados().between(1,3)){
			"c1a.png"
		}
		else {
			"c1b.png"
		}
	}
}

class ManzanaB inherits Manzana {
	 override method image() {
		return if ((self.cantidadInfectados() == self.personasQueViven())) {
			"c2r.png"
		}
		else if(self.cantidadInfectados().between(8, (self.personasQueViven()-1))) {
			"c2nn.png"
		}
		else if(self.cantidadInfectados().between(4,7)){
			"c2n.png"
		}
		else if(self.cantidadInfectados().between(1,3)){
			"c2a.png"
		}
		else {
			"c2b.png"
		}
	}
}