 import wollok.game.*
 import direcciones.*
 import protagonista.*

 class Elementos {
    method image() 
    method chocasteCon(unPj)   
 }

 class Objetos inherits Elementos {
    var property position = randomizer.emptyPosition()
 }

 class Medkit inherits Objetos {
    const property salud 

    override method image() = "Vendaje" + self.actualizarImagen() + ".png"
    override method chocasteCon(unPj) {
        unPj.recuperarSalud(self.salud())
        curaciones.removerCuracion(self)
    } 

    method actualizarImagen() = if(salud < 0) "2" else "1"
}

object curaciones {
  var property curaciones = []

  method generarCura(pos) {
    const nuevaCura = new Medkit(position = pos, salud = movimientos.positivoNegativo())
    nuevaCura.actualizarImagen()
    game.addVisual(nuevaCura)
    movimientos.movimientoEnemigo(nuevaCura)
    curaciones.add(nuevaCura)
  }

  method removerCura(unaCura) {
    curaciones.remove(unaCura)
    game.removeVisual(unaCura)
  }
}

object barraVida inherits Elementos {
  var property position = game.at(6, 0)

  override method image() = "barraVida/barra-" + protagonista.salud() + ".png"

  override method chocasteCon(unPj) {}
}

object coleccionVidas {
  var property vidas = [new ProtagonistaVidas(position = gameAt.(5, 0)), new ProtagonistaVidas(position = game.at(4, 0)), new ProtagonistaVidas(position = game.at(3, 0)) ]

  method removerVida() {
    game.removeVisual(vidas.first())
    vidas.remove(vidas.first())
  }

  method image() {
    vidas.forEach({v => game.addVisual(v)})
  }
}

class ProtagonistaVidas {
    var property position
    method image() = "prota_frente_vida.png"
}

object start {
  var property position = game.at(3, 2)

  method image() = "Game_over_o_end/start.png"
  method actualizarStart() {
    game.onTick(300, "actualizar Start", {=> self.visual()})
  }
  method visual() {
    if (game.hasVisual(self)) {
        game.removeVisual(self)
    } else {
        game.addVisual(self)
    }
  }
}

object sonidos {
  method musicaDeFondo() = "vordt_of_the_boreal_valley_mp3".play()
}