import juego.*
import wollok.game.*


object menu {
  var estadoDelJuego = "Menu"

  method mostrarMenu() {
    estadoDelJuego = "Menu"
    game.addVisual(fondoMenu)
    game.addVisual(botonJugar)
    self.configTeclaInicio()
  }

  method ocultarMenu() {
    game.removeVisual(fondoMenu)
    game.removeVisual(botonJugar)
  }

  method iniciarJuego() {
    estadoDelJuego = "Jugando"
    self.ocultarMenu()
    juego.iniciar()
  }

  method configTeclaInicio() {
    keyboard.enter().onPressDo {
        if (estadoDelJuego == "Menu") {
            self.iniciarJuego()
        }
    }
  }
}

object fondoMenu {
  var property position = game.at(5, 0)
  method image() = "fondoMenu (2).png"
  method zIndex() = -10
}

object botonJugar {
  var property position = game.at(23, -3)
  method image() = "botonJugar.png"
  method zIndex() = -10
}