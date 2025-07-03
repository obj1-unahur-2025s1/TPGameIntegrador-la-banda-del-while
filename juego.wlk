import sfx.*
import objetos.*
import wollok.game.*
import personajes.*
import modelos.*
import menu.*

object juego {
  const property todo = [termo, yerba, donSatur, enemigo, firefly, culebrita, carpincho, boss] 
  method boss() = boss
  var carpinchoAparecio = false
  method iniciar() {
    menu.gameOver(false)
    game.addVisual(carpincho)
    self.activarMovimientoCarpincho()
    game.addVisual(termo)
    game.addVisual(yerba)
    game.addVisual(donSatur)
    game.addVisual(enemigo)
    game.addVisual(firefly)
    game.addVisual(culebrita)
    musicaDeFondo.empezarMusica()
    game.schedule(2000, {game.say(carpincho, "Con SHIFT puedo ver mis estadisticas")})
    game.onTick(3000, "movimiento", { firefly.movete() culebrita.movete()})
  }
  method activarMovimientoCarpincho() { 
  // SI NO HAY UNA VARIABLE QUE CONTROLE, EL CARPINCHO DESPUES DE RESETEAR SE MUEVE DOBLE
    if (not carpinchoAparecio){
      keyboard.up().onPressDo({carpincho.movimiento(0, -1)})
      keyboard.left().onPressDo({carpincho.movimiento(-1, 0)})
      keyboard.down().onPressDo({carpincho.movimiento(0, +1)})
      keyboard.right().onPressDo({carpincho.movimiento(+1, 0)})
      game.onCollideDo(carpincho, {algo => if(algo.esEnemigo()){carpincho.pelear(algo) algo.mostrarDatos()}else{carpincho.recoger(algo)}})
      keyboard.space().onPressDo({carpincho.activarSupercarpincho()})
      keyboard.shift().onPressDo ({carpincho.mostrarDatos()})
      carpinchoAparecio = true
    }
  }
}
