import juego.*
import modelos.*
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

class Fondo {
  const property position
  const imagen
  const index

  method image() = imagen
  method zIndex() = index
}