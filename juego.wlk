import objetos.*
import wollok.game.*
import personajes.*

object juego {
  const enemigo = new Enemigo(danioBase = 1, vida = 5, position = game.at(6, 5))
  const firefly = new Luciernaga(danioBase = 2, vida = 5, position = game.center())
  const culebrita =  new Culebra(danioBase = 3, vida = 3, position = game.at(11,18))
  const boss = new Boss(danioBase = 6, vida = 20, position = game.center())
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