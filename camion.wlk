import cosas.*
import almacen_ruta.*

object camion {
	const property cosas = #{}
	const tara = 1000
	const pesoMax = 2500

		
	method cargar(cosa) {
		cosa.reaccionar()
		cosas.add(cosa)
	}
	//metodo solo para testing
	method cargarSinReaccion(cosa) {
	  cosas.add(cosa)
	}

	method descargar(cosa) {
		cosas.remove(cosa)
	}

	method todoPesoPar() {
		return cosas.all({cosa => cosa.peso().even()}) 
	}

	method hayAlgunoQuePesa(peso) {
		return cosas.any({cosa => cosa.peso() == peso})
	}

	method elDeNivel(nivel) {
		return cosas.find({cosa => cosa.nivelDePeligrosidad() == nivel})
	}

	method pesoTotal() {
		return cosas.sum({cosa => cosa.peso()}) + tara
	}

	method excedidoDePeso() {
		return self.pesoTotal() > pesoMax
	}

	method objetosQueSuperanLaPeligrosidad(nivel) {
		return cosas.filter({cosa => cosa.nivelDePeligrosidad() > nivel})
	}

	method objetosMasPeligrososQue(objeto) {
		return cosas.filter({cosa => cosa.nivelDePeligrosidad() > objeto.nivelDePeligrosidad() }) 
	}

	method puedeCircularEnRuta(nivel) {
		return not self.excedidoDePeso() and self.objetosQueSuperanLaPeligrosidad(nivel).size() == 0
	}

	method tieneAlgoQuePesaEntre(min, max) {
		return cosas.any({cosa => cosa.peso() >= min and cosa.peso() <= max})
	}

	method cosaMasPesada() {
		return cosas.max({cosa => cosa.peso()})
	}

	method pesos() {
		return cosas.map({cosa => cosa.peso()})	  
	}

	method totalBultos() {
		return cosas.sum({cosa => cosa.bultos()})
	}

	method todasLasCosas() {
		return cosas
	}

	//Este metodo es llamado por almacen
	method descargarTodo() {
		cosas.removeAll(cosas)	  
	}

	
	method transportar(destino, camino) {
		self.validarCamino(camino)
		self.validarDestino(destino)
		almacen.almacenar()
	}

	method validarCamino(camino) {
		self.validarPeligrosidad(camino)
		self.validarPeso(camino)
	}

	method validarPeligrosidad(camino){
		if(not self.puedeCircularEnRuta(camino.nivelDePeligrosidad())){
			self.error("Muy pegriloso!")
		}
	}

	method validarPeso(camino) {
		if(self.pesoTotal() > camino.pesoMaximo()){
			self.error("Muy pesado")
		}
	}

	method validarDestino(destino) {
		self.validarEspacio(destino)
	}

	method validarEspacio(destino) {
		if(destino.espacioDisponible() < self.totalBultos() ){
			self.error("No hay espacio en " + destino)
		}
	}
}
