// personajes.wlk
// personajes.wlk
// personajes.wlk
// personajes.wlk
import wollok.game.*
import objetos.*
import juego.*
import modelos.*


class Personaje {
  var property vida
  var property position
  method restarVida(valor){
    vida -= valor
  }
  method estaMuerto() = vida <= 0
}

object carpincho {
  var estado =  "carpincho" 
  var accion = ""
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
  var gameOver = false
  
  method estaMuerto() = vida <= 0

  method image() = estado + accion + ".png"
  method movimiento(x, y) {
    if(not gameOver) {
      position = position.right(x).down(y)
    }

    keyboard.w().onPressDo(if (gameOver) self.movimiento(0, -1))
    keyboard.s().onPressDo(if (gameOver) self.movimiento(0, 1))
    keyboard.a().onPressDo(if (gameOver) self.movimiento(-1, 0))
    keyboard.d().onPressDo(if (gameOver) self.movimiento(1, 0))
  } 

  /*
  method verificarGameOver() {
    if(self.estaMuerto()) {
      self.gameOver()
    }
  }

  method gameOver() {
    game.say(self, "Game Over")
    gameOver = true
  }
  */



  // Método que verifica si el carpincho está muerto y activa el Game Over
method verificarGameOver() {
  if (self.estaMuerto()) {
    self.activarGameOver()
  }
}


  // Nuevo método para manejar la lógica de "Game Over"
  method activarGameOver() {
    // Evita que se active múltiples veces
    //if(gameOver){return}
    
    gameOver = true
    game.say(self, "¡Game Over! El carpincho no pudo más.")
    game.sound("gameOver.mp3").play() // Asumiendo que tienes un sonido para Game Over
    
    // Opcional: Detener todos los ticks del juego para pausar
    //game.removeAllTickEvents()
    
    // Opcional: Mostrar una pantalla de "Game Over" o un botón de reinicio
    // Por ejemplo:
    //game.addVisual(imagenGameOver) 
    //keyboard.disable() 
    // Desactiva todas las interacciones de teclado
  }

  
  
  
  
  
  

  method pelear(unEnemigo) {
    accion = "ATK"
    game.schedule(3000, { accion = "" })
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
      estado = "carpinchoSuper"
      danioAct = danioAct * 2
      game.schedule(10000, {estado = "carpincho" danioAct = danioAct / 2})
      items.clear()
    }
  }

  method mostrarDatos() {
    game.say(self, "Vida:" + vida + ", ATK:" + danioAct + "Tengo:" + items)
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
    if(self.estaMuerto()) {
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

  
  