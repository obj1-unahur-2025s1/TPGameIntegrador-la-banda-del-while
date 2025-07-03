import sfx.*
import wollok.game.*
import objetos.*
import juego.*
import modelos.*
import menu.*


class Personaje { // La clase que usarán la mayoría de Personajes
  var property vida
  var property position
  method restarVida(valor){
    vida -= valor
  }
  method estaMuerto() = vida <= 0
}

object carpincho { // El jugador
  var estado =  "carpincho" // RECONOCE UN ESTADO QUE ES CARPINCHO O SUOPERCARPINCHO
  var accion = "" // RECONOCE UNA ACCION QUE ES ATK O NADA
  var direc = "Der" // RECONOCE LA DIRECCION A DONDE MIRA CON DER O IZQ
  var property danioAct = 3
  var property vida = 5
  var superCarpincho = false
  var nivel = 1
  var experiencia = 0
  var expParaSubir = 1
  var kills = 0
  method kills() = kills
  var property position = game.at(1, 8)
  const items = []
  
  method estaMuerto() = vida <= 0

  method image() = direc + estado + accion + ".png" // DADO UN ESTADO Y UNA ACCION, DEVUELVE LA IMAGEN CORRESPONDIENTE CON EL PNG AL FINAL carpincho.png
  
  method movimiento(x, y) {
      if (x == +1){
        direc = "Der"
      }
      if (x == -1){
        direc = "Izq"
      }
      position = position.right(x).down(y)
  } 

  // Método que verifica si el carpincho está muerto y activa el Game Over
method verificarFinal() {
  if (self.estaMuerto()) {
    menu.activarGameOver()
  }
  if(kills >= 4){
    menu.activarFinal()
  }
}

method resetear() { //Reinicia las estadísticas del Carpincho
    kills = 0
    position = game.at(1, 8)
    items.clear()
    vida = 5
    danioAct = 3
    superCarpincho = false
    nivel = 1
    experiencia = 0
    expParaSubir = 1
}

  method pelear(unEnemigo) { //El carpincho entra en combate cuando toca a un Enemigo
    accion = "ATK" // el estado cambia a ATK, el str se le suma en el method image()
    game.schedule(2000, { accion = "" }) // luego de 2 segundos vuelve a la accion vacia
    game.sound("japish.mp3").play()
    if (danioAct >= unEnemigo.vida()) {
      vida = (vida - unEnemigo.danioRecibido()).max(0)
      experiencia += 1
      kills += 1
      game.removeVisual(unEnemigo)
      boss.aparecer()
      if (experiencia >= expParaSubir) {
        self.subirDeNivel()
      }
      self.verificarFinal()
    } else {
      vida = (vida - unEnemigo.danioRecibido()).max(0)
      unEnemigo.restarVida(danioAct)
      self.verificarFinal()
    }
  }


  method activarSupercarpincho() { //Transforma al carpincho En SuperCarpincho si es que tiene los 3 items
    if (items.size() == 3) {
      superCarpincho = true
      game.sound("superCarpincho.mp3").play()
      estado = "carpinchoSuper" // transforma el carpincho en supercarpincho modificando el estado
      danioAct = danioAct * 2
      game.schedule(8000, {estado = "carpincho" danioAct = danioAct / 2})
      items.clear()
    }
  }

  method mostrarDatos() { //Indica las stats y objetos del carpincho
    game.say(self, "Vida:" + vida + ", ATK:" + danioAct + "Tengo:" + items.map({a => a.nombre()}))
  }

  method subirDeNivel() { //Sube al carpincho de nivel
    nivel += 1
    experiencia = 0
    danioAct += 1
    vida = 5
    game.say(self, "Nivel" + nivel + "Poder y salud aumentados!")
    game.sound("levelUp.mp3").play()
  }

  method sufrirVeneno() { //El carpincho pierde atk por 2 segundos al enfrentarse con la culebra
      danioAct = danioAct - 1
      game.schedule(2000, {danioAct = danioAct + 1})
      game.sound("culebra.mp3").play()
  }


  method recoger(objeto) { //El carpincho recoge un objeto cuando le pasa por arriba
    items.add(objeto)
    objeto.esRecogido()
    if(items.size() == 3){
      game.schedule(2000, {game.say(self, "Presiona la barra espaciadora para transformarme")})
    }
  }
}

class Enemigo inherits Personaje { //El enemigo estándar
  var property danioBase
  var property imageFile = "enemigo.png"

  method esEnemigo() = true //Indica si es o no un enemigo, recurso polimórfico para recoger
  method danioRecibido() = danioBase //El daño que provoca el jefe
  method image() = imageFile
  method resetear(){ //En un reset, reinicia la vida del jefe
    vida = 5
  }
   method mostrarDatos() { //Muestra la vida del jefe
    game.say(self, "Vida:" + vida)
  }
}

class Luciernaga inherits Enemigo { //La luciernaga, una subclase de enemigo que vuela y esquiva
  var contador = 0
  override method resetear(){
    vida = 14
    contador = 0
  }
  override method image() = "luciernaga.png"
  method movete() { //Hace que la luciernaga se pueda mover
    const x = 0.randomUpTo(game.width()).truncate(0)
    const y = 0.randomUpTo(game.height()).truncate(0)
    position = game.at(x,y)
  }
  override method danioRecibido() { //Determina la posibilidad que la luciernaga esquive
    contador += 1
    return 
    if (contador % 3 == 0) {
    0
    game.say(carpincho, "La Luciernaga esquivó el ataque!")
  } else {
    danioBase
  }
}
  method morir() { //Al morir, detiene el concepto de movimiento de la luciernaga
    if(self.estaMuerto()) {
      game.removeTickEvent("movimiento")
    }
  } 
}

class Culebra inherits Enemigo { //La culebra, una subclase de enemigo que envenena
  var venenoActivo = false
  override method image() = "culebra.png"
  override method danioRecibido() { //El daño de la culebra 
    venenoActivo = true
    return danioBase 
  }
    method movimiento(x, y) { 
      position = position.right(x).down(y)
  } 

    method movete() { //Hace que la serpiente se mueva en rectangulos, para acertar dominancia
    game.schedule(700,{self.movimiento(+2, 0)})
    game.schedule(1400,{self.movimiento(0, +2)})
    game.schedule(2100,{self.movimiento(-2, 0)})
    game.schedule(2800,{self.movimiento(0, -2)})
    }

  method efectoVeneno(carpincho) { //El efecto del veneno
    if (venenoActivo) {
      carpincho.sufrirVeneno()
      game.say(carpincho, "¡El veneno de la culebra me afecto!")
    }
  }
}

class Boss inherits Enemigo { //La Radiance, el jefe final, definitivamente no robada de Hollow Knight
  var noAparecio = true
  method aparecer() { //Permite a la Radiance spawnear
    if(carpincho.kills() >= 3 and noAparecio) {
      noAparecio = false
      game.addVisual(juego.boss())
      position = game.center()
      musicaDeFondo.pararMusica()
      musicaDeBoss.empezarMusica()
    }
  }
  override method resetear(){ //Regenera la vida de la Radiance
    vida =  20
    noAparecio = true
  }
  override method image() = "boss.png"
}

  
  
