object knightRider {
	method peso() { return 500 }
	method nivelDePeligrosidad() { return 10 }
	method bultos() {return 1}
	method reaccionar() {/*No hace nada */}
}

object bumblebee {
	var property estadoActual = auto

	method transformarse() {
		estadoActual.cambiarForma()
	}
	
	method peso() { return estadoActual.peso() }

	method nivelDePeligrosidad() {
		return estadoActual.nivelDePeligrosidad()
	 }

 	method bultos() {return 2}

	method reaccionar() {self.transformarse()}

}

object auto {
	method peso() { return 800 }

	method nivelDePeligrosidad() { return 15 }

	method cambiarForma() {
		bumblebee.estadoActual(robot)
	}
}

object robot {
	method peso() { return 800 }

	method nivelDePeligrosidad() { return 30}

	method cambiarForma() {
		bumblebee.estadoActual(auto)
	}
}


object paqueteDeLadrillos {
	var cantidadDeLadrillos = 50
	const pesoLadrillo = 2

	method peso() {
		return cantidadDeLadrillos * pesoLadrillo
	}

	//metodo para testing
	method cuantosTiene() {
		return cantidadDeLadrillos
	}

	method nivelDePeligrosidad() {return 2}

	method bultos(){ 
		return if (cantidadDeLadrillos.between(0, 100)) {1}
		else if (cantidadDeLadrillos.between(101, 300)) {2}
		else {3}
	}

	method reaccionar() {cantidadDeLadrillos += 12}
}

object arena {
	var cantidadEnKg = 500

	method peso() {return cantidadEnKg}

	method nivelDePeligrosidad() {return 1}

	method bultos() {return 1}

	method reaccionar() {cantidadEnKg += 20}
}

object bateriaAntiaerea {
	var property estado = bateriaDescargada

	method cargar_disparar() {
	  estado.cambiarEstado()
	}

	method peso() {return estado.peso()}

	method nivelDePeligrosidad() {
		return estado.nivelDePeligrosidad()
	}

	method estaDescargada() {
		return estado == bateriaDescargada
	}

	method bultos() {
	  return if (self.estaDescargada()) {2}
	  else {1}
	}

	method reaccionar() {self.cargar_disparar()}
}

object bateriaCargada {
	method cambiarEstado() {
		bateriaAntiaerea.estado(bateriaDescargada)
	}

	method peso() {return 300}

	method nivelDePeligrosidad() {return 100}
}

object bateriaDescargada {
	method cambiarEstado() {
		bateriaAntiaerea.estado(bateriaCargada)
	}

	method peso() {return 100}

	method nivelDePeligrosidad() {return 0}
}

object contenedorPortuario {
	const container = #{bateriaAntiaerea}
	const pesoBase = 100

	method peso() {
		return container.sum({cosa => cosa.peso()}) + pesoBase
	}

	method nivelDePeligrosidad() {
		return container.map({cosa => cosa.nivelDePeligrosidad()}).maxIfEmpty(0)
	}

	method bultos() {
		return self.bultoContenedor() + container.size()
	}

	method bultoContenedor() {return 1}

	method reaccionar() {
		container.forEach({cosa => cosa.reaccionar()})
	}
}

object residuosRadioactivos {
	var property peso = 100
	
	method peso() {return peso}
	
	method nivelDePeligrosidad() {return 200}

	method bultos() {return 1}

	method reaccionar() {peso += 15}
}

object embalajeDeSeguridad {
	var property objetoEmbalado = knightRider

	method peso() {return objetoEmbalado.peso()}

	method nivelDePeligrosidad() {
		return objetoEmbalado.nivelDePeligrosidad() / 2
	}

	method bultos() {return 2}

	method reaccionar() {/* No hace nada*/}

}