import objetos.*
import wollok.game.*
import personajes.*

object juego {
  const enemigo = new Enemigo(danioBase = 3, vida = 5, position = game.at(6, 5))
  method iniciar() {
    game.addVisualCharacter(carpincho)
    game.addVisual(termo)
    game.addVisual(yerba)
    game.addVisual(enemigo)

  keyboard.shift().onPressDo ({carpincho.mostrarDatos()})
  }
}