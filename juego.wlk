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
    
    keyboard.up().onPressDo {
    carpincho.mover(0, -1)
  }

  keyboard.down().onPressDo {
    carpincho.mover(0, 1)
  }

  keyboard.left().onPressDo {
    carpincho.mover(-1, 0)
  }

  keyboard.right().onPressDo {
    carpincho.mover(1, 0)
  }
  }

  
}