import wollok.game.*
import objetos.*
import juego.*


class Personaje {
  var property vida
  var property position
  method restarVida(valor){
    vida -= valor
  }
  method estaMuerto() = vida <= 0
}

object carpincho {
  var property danioAct = 3
  var property vida = 5
  var superCarpincho = false
  var nivel = 1
  var experiencia = 0
  var expParaSubir = 1
  var kills = 0
  method kills() = kills
  var property position = game.at(1, 11)
  const items = []
  var image = "carpincho.png"

  method image() = image

  method pelear(unEnemigo) {
    if (not superCarpincho) {
      self.cambiarImagen("carpinchoATK.png")
      game.schedule(3000, {self.cambiarImagen("carpincho.png")})
    }
    else{
      self.cambiarImagen("carpinchoSuperATK.png")
      game.schedule(3000, {self.cambiarImagen("carpinchoSuper.png")})
    }
    if (danioAct >= unEnemigo.vida()) {
      vida = (vida - unEnemigo.danioRecibido()).max(0)
      experiencia += 1
      game.removeVisual(unEnemigo)
      kills += 1
      if (experiencia >= expParaSubir) {
        self.subirDeNivel()
      }
    } else {
      vida = (vida - unEnemigo.danioRecibido()).max(0)
      unEnemigo.restarVida(danioAct)
    }
  }


  method activarSupercarpincho() {
    if (items.size() == 3) {
      superCarpincho = true
      image = "carpinchoSuper.png"
      danioAct = danioAct * 2
      game.schedule(10000, {self.cambiarImagen("carpincho.png") danioAct = danioAct / 2})
      items.clear()
    }
  }

  method mostrarDatos() {
    game.say(self, "Vida:" + vida + ", ATK:" + danioAct + "Tengo:" + items)
  }

  method cambiarImagen(unaImagen) {
    image = unaImagen
  }

  method subirDeNivel() {
    nivel += 1
    experiencia = 0
    danioAct += 1
    expParaSubir += 1
    vida = 5
    game.say(self, "Nivel" + nivel + "Poder y salud aumentados!")
    game.sound("levelUp.mp3").play()
  }

  method sufrirVeneno() {
    vida = vida - 1
  }
  method recoger(objeto) {
    items.add(objeto)
    objeto.esRecogido()
  }

  method mover(x, y) {
    position = position.right(x).down(y)
  }

  
}

class Enemigo inherits Personaje {
  var property danioBase
  var property imageFile = "enemigo.png"

  method esEnemigo() = true
  method danioRecibido() = danioBase
  method image() = imageFile

   method mostrarDatos() {
    game.say(self, "Vida:" + vida)
  }
}

class Luciernaga inherits Enemigo {
  var contador = 0
  override method image() = "luciernaga.png"
  method movete() {
    const x = 0.randomUpTo(game.width()).truncate(0)
    const y = 0.randomUpTo(game.height()).truncate(0)
    position = game.at(x,y)
  }
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
  method morir() {
    if(self.vida() == 0) {
      game.removeTickEvent("movimiento")
    }
  } 
}

class Culebra inherits Enemigo {
  var venenoActivo = false
  override method image() = "culebra.png"
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

class Boss inherits Enemigo {
  method aparecer() {
    if(carpincho.kills() >= 3) {
      game.addVisual(juego.boss())
      game.removeTickEvent("boss")
    }
  }
  override method image() = "boss.png"
}

  
  