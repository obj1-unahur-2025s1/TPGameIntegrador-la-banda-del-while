import TPGameIntegrador-la-banda-del-while.personajes.*
import juego.*
import modelos.*
import wollok.game.*
import objetos.*
import sfx.*


object menu {
  var estadoDelJuego = "Menu"
  var gameOver = false

  method mostrarMenu() {
    estadoDelJuego = "Menu"
    game.addVisual(fondoMenu)
    game.addVisual(botonJugar)
    self.configTeclaInicio()
  }

  method ocultarMenu() {
    game.removeVisual(fondoMenu)
    game.removeVisual(botonJugar)
    game.removeVisual(gameOverImagen)
    game.removeVisual(youWinImagen)
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
  method pararMusica(){
    if(musicaDeFondo.sonando()){
      musicaDeFondo.pararMusica()
    }
    if(musicaDeBoss.sonando()){
      musicaDeBoss.pararMusica()
    }
  }
    // Nuevo método para manejar la lógica de "Game Over"
  method activarGameOver() {
    // Evita que se active múltiples veces
    //if(gameOver){return}
    game.removeTickEvent("movimiento")
    gameOver = true
    self.resetearJuego()
    self.pararMusica()
    game.sound("gameOver.mp3").play()
    game.addVisual(gameOverImagen)
    game.schedule(6000, {self.mostrarMenu()})
  }

  method activarFinal() {
    game.removeTickEvent("movimiento")
    self.resetearJuego()
    self.pararMusica()
    game.sound("youWin.mp3").play()
    game.addVisual(youWinImagen)
    game.schedule(6000, {self.mostrarMenu()})
  }


  method gameOver(valor) {
    gameOver = valor
  }

  method resetearJuego() {
    juego.todo().forEach({a => a.resetear()})
    juego.todo().forEach({a => game.removeVisual(a)})
  }
}

class Fondo {
  const property position
  const imagen
  const index

  method image() = imagen
  method zIndex() = index
}