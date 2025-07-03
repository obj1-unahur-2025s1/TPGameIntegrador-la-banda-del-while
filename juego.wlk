import TPGameIntegrador-la-banda-del-while.sfx.*
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
    self.aparecerCarpincho()
    game.addVisual(termo)
    game.addVisual(yerba)
    game.addVisual(donSatur)
    game.addVisual(enemigo)
    game.addVisual(firefly)
    game.addVisual(culebrita)
    musicaDeFondo.empezarMusica()
    game.onCollideDo(carpincho, {algo => if(algo.esEnemigo()){carpincho.pelear(algo) algo.mostrarDatos()}else{carpincho.recoger(algo)}})
    keyboard.shift().onPressDo ({carpincho.mostrarDatos()})
    keyboard.space().onPressDo({carpincho.activarSupercarpincho()})
    game.schedule(2000, {game.say(carpincho, "Con SHIFT puedo ver mis estadisticas")})
    game.onTick(3000, "movimiento", { firefly.movete() culebrita.movete()})
  }
  method aparecerCarpincho() {
    if (carpinchoAparecio){
      game.addVisual(carpincho)
    }
    else{
      game.addVisualCharacter(carpincho)
      carpinchoAparecio = true
    }
  }
}