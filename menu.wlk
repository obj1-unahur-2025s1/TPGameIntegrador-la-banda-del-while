import personajes.*
import juego.*
import modelos.*
import wollok.game.*
import objetos.*
import sfx.*
import interfaz.*


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
  
  method activarGameOver() {
    // Evita que se active múltiples veces
    const sonido = new Sound(file = "gameOver.mp3")
    game.removeTickEvent("movimiento")
    gameOver = true
    self.resetearJuego()
    self.pararMusica()
    barraVidaCarpincho.sacar()
    sonido.play()
    game.addVisual(gameOverImagen)
    game.schedule(6000, {sonido.stop() self.mostrarMenu()})
  }

  method activarFinal() {
    const sonido = new Sound(file = "youWin.mp3")
    game.removeTickEvent("movimiento")
    self.resetearJuego()
    self.pararMusica()
    barraVidaCarpincho.sacar()
    sonido.play()
    game.addVisual(youWinImagen)
    game.schedule(6000, {self.mostrarMenu() sonido.stop()}) 
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