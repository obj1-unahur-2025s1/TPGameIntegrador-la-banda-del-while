import objetos.*
import wollok.game.*
import personajes.*

object juego {
  method iniciar() {
    game.addVisualCharacter(carpincho)
    game.addVisualCharacter(termo)
    game.addVisualCharacter(yerba)
    
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