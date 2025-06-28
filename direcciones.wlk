import personajes.*
import protagonista.*
import wollok.game.*

class Moveset {
    method moverArriba(objeto, cant) {
      objeto.position(objeto.position().up(cant))
    }
    method moverAbajo(objeto, cant) {
      objeto.position(objeto.position().down(cant))
    }
    method moverIzquierda(objeto, cant) {
      objeto.position(objeto.position().left(cant))
    }
    method moverDerecha(objeto, cant) {
      objeto.position(objeto.position().right(cant))
    }

    method puedeMoverArriba(unObjeto, escenarioActual) {}

    method puedeMoverAbajo(unObjeto, escenarioActual) {}

    method puedeMoverIzquierda(unObjeto, escenarioActual) {}

    method puedeMoverDerecha(unObjeto, escenarioActual) {}   

    method puntoX(unPj) = unPj.position().x()

    method puntoY(unPj) = unPj.position().y() 

    method moverXoY(unPj) = true

    method moverY(unPj) {}

    method moverX(unPj) {}

    method movimientoColeccion(unaColeccion) {}

    method moverAleatorio(num,objeto,escenarioActual){
        if(num == 0) {
            movimientos.puedoMoverArriba(objeto,escenarioActual)
        } else if(num == 1) {
            movimientos.puedoMoverAbajo(objeto,escenarioActual)
        } else if(num == 2) {
            movimientos.puedoMoverDerecha(objeto,escenarioActual)
        } else if(num == 3) {
            movimientos.puedoMoverIzquierda(objeto,escenarioActual)
        }
    }
}

object movimientos inherits Moveset {
  override method moverXoY(unPj) = (self.puntoY(unPj) - self.puntoX(protagonista)).abs() > (self.puntoX(protagonista) - self.puntoX(protagonista)).abs()

  override method puedeMoverArriba(unObjeto, escenarioAct) {
    const destino = unObjeto.position().up(1)
    if (escenarioAct.noPasar().contains(destino) or unObjeto.position().y() > 9) { //Contar espacios de tablero y reeemplazar el 9
        self.moverAleatorio(randomizer.devolverNum(0, 4), unObjeto, escenarioAct)
    } else {
      self.moverArriba(unObjeto, 1)  
    } 
  }

  override method puedeMoverAbajo(unObjeto, escenarioAct){
	const destino = unObjeto.position().down(1)
	if(escenarioAct.noPasar().contains(destino) or unObjeto.position().y() < 0){
		self.moverAleatorio(randomizer.devolverNum(0,4), unObjeto, escenarioAct)
	} else {
	    self.moverAbajo(unObjeto, 1)
	}
  }
	
	override method puedeMoverDerecha(unObjeto, escenarioAct){
		const destino = unObjeto.position().right(1)
		if(escenarioAct.noPasar().contains(destino) or unObjeto.position().x() > 9){
			self.moverAleatorio(randomizer.devolverNum(0,4), unObjeto, escenarioAct)
		}else{
			self.moverDerecha(unObjeto, 1)
		}
	}
	
	override method puedeMoverIzquierda(unObjeto, escenarioAct){
		const destino = unObjeto.position().left(1)
		if(escenarioAct.noPasar().contains(destino)  or unObjeto.position().x() <= 0){
			self.moverAleatorio(randomizer.devolverNum(0,4), unObjeto, escenarioAct)
		}else{
			self.moverIzquierda(unObjeto, 1)
		}
	}

    method movimientoEnemigo(unEnemigo) {
      const numero = randomizer.devolverNum(0, 4)
      if (numero == 1) {
        self.moverArriba(unEnemigo, 1)
      } else if (numero == 2) {
        self.moverAbajo(unEnemigo, 1)
      } else if (numero == 3) {
        self.moverDerecha(unEnemigo, 1)
      } else {
        self.moverIzquierda(unEnemigo, 1)
      }
    }

    override method moverY(unPj) {
        if(self.puntoY(unPj) - self.puntoY(protagonista) > 0) {
            self.puedeMoverAbajo(unPj, escenario.nivel())
            unPj.perfil("frente")
        } else if (self.puntoY(unPj) - self.puntoY(protagonista) < 0) {
            self.puedeMoverArriba(unPj, escenario.nivel())
            unPj.perfil("espalda")
        }
    }

    override method moverX(unPj) {
        if(self.puntoX(unPj) - self.puntoX(protagonista) > 0) {
            self.puedeMoverIzquierda(unPj, escenario.nivel())
            unPj.perfil("izquierda")
        } else if (self.puntoX(unPj) - self.puntoX(protagonista) < 0) {
            self.puedeMoverDerecha(unPj, escenario.nivel())
            unPj.perfil("derecha")
        } 
    }
}

object movesetProtagonista inherits Moveset {
  
  override method puedeMoverArriba(unObjeto, escenarioAct) {
    const destino = unObjeto.position().up(1)
    if(not (escenarioAct.noPasar().contains(destino) or unObjeto.position().y() > 9)) { //Contar espacios de tablero y reeemplazar el 9
        self.moverArriba(unObjeto, 1)  
    }
  }

  override method puedeMoverAbajo(unObjeto, escenarioAct){
	const destino = unObjeto.position().down(1)
	if(not (escenarioAct.noPasar().contains(destino) or unObjeto.position().y() < 0)){
		self.moverAbajo(unObjeto, 1)
	} 
  }
	
	override method puedeMoverDerecha(unObjeto, escenarioAct){
		const destino = unObjeto.position().right(1)
		if(not (escenarioAct.noPasar().contains(destino) or unObjeto.position().x() > 9)){
			self.moverDerecha(unObjeto, 1)
		}
	}
	
	override method puedeMoverIzquierda(unObjeto, escenarioAct){
		const destino = unObjeto.position().left(1)
		if(not (escenarioAct.noPasar().contains(destino)  or unObjeto.position().x() <= 0)){
			self.moverIzquierda(unObjeto, 1)
		}
	}
}