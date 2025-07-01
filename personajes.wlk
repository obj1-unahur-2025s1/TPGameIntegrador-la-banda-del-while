import wollok.game.*
import objetos.*


class Personaje {
  var property vida
  var property position
  method estaMuerto() = vida <= 0
}

object carpincho {
  var danioAct = 3
  var property vida = 5
  var nivel = 1
  var experiencia = 0
  var expParaSubir = 3
  var property position = game.at(1, 11)
  const items = []

  method image() = "carpincho.png"

  method pelear(unEnemigo) {
    if (danioAct >= unEnemigo.vida()) {
      experiencia += 1
      if (experiencia >= expParaSubir) {
        self.subirDeNivel()
      }
      game.removeVisual(unEnemigo)
    } else {
      vida = (vida - unEnemigo.danioRecibido()).max(0)
    }
  }

  method subirDeNivel() {
    nivel += 1
    experiencia = 0
    expParaSubir += 2
    danioAct += 1
    vida = 5
    game.say(self, "Nivel" + nivel + "Poder y salud aumentados!")
  }

  method sufrirVeneno() {
    vida = vida - 1
  }
  method recogerUn(objeto) {
    items.add(objeto)
  }

  method mover(x, y) {
    position = position.right(x).down(y)
  }
}

class Enemigo inherits Personaje {
  var property danioBase
  var property imageFile = "enemigo.jpg"

  method danioRecibido() = danioBase
  method image() = imageFile

  method accionContra(unCarpincho) {
    game.onCollideDo(unCarpincho, { unCarpincho.pelear(self) })
  }
}

class Luciernaga inherits Enemigo {
  var contador = 0

  override method danioRecibido() {
    contador += 1
    return 
    if (contador % 3 == 0) {
    0
    game.say(carpincho, "La Luciernaga esquivó el ataque!")
  } else {
    danioBase
  }
}
}

class Culebra inherits Enemigo {
  var venenoActivo = false

  override method danioRecibido() {
    venenoActivo = true
    return danioBase
  }

  method efectoVeneno(carpincho) {
    if (venenoActivo) {
      carpincho.sufrirVeneno()
      game.say(carpincho, "¡El veneno de la culebra me afecto!")
    }
  }
}



  
  