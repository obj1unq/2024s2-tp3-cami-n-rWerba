import cosas.*
import camion.*

object almacen {
    const stock = #{}
    const bultosMaximos = 3

    method almacenar() {
        stock.addAll(camion.todasLasCosas())
        camion.descargarTodo()
    }

    method espacioDisponible() {
        return bultosMaximos - stock.size()
    }
}

object ruta9 {
    method nivelDePeligrosidad() {return 11}
    method pesoMaximo() {/*no hay*/}
}

object caminoVecinal {
    var property pesoMaximo = 400
    method nivelDePeligrosidad() {/*no hay*/}
    method pesoMaximo() {return pesoMaximo}

}

