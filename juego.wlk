// juego.wlk
// juego.wlk
// juego.wlk
// juego.wlk
// juego.wlk
// juego.wlk
import objetos.*
import wollok.game.*
import personajes.*
import modelos.*


object juego {
  method boss() = boss
  method iniciar() {
    game.addVisualCharacter(carpincho)
    game.addVisual(termo)
    game.addVisual(yerba)
    game.addVisual(donSatur)
    game.addVisual(enemigo)
    game.addVisual(firefly)
    game.addVisual(culebrita)
    game.onTick(3000, "movimiento", { firefly.movete() })
    game.onCollideDo(carpincho, {algo => if(algo.esEnemigo()){carpincho.pelear(algo) algo.mostrarDatos()}else{carpincho.recoger(algo)}})
    keyboard.shift().onPressDo ({carpincho.mostrarDatos()})
    keyboard.space().onPressDo({carpincho.activarSupercarpincho()})
    game.onTick(2000, "boss",{boss.aparecer()})
  }

}