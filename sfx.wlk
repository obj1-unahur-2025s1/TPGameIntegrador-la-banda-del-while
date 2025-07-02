import objetos.*
import wollok.game.*
import personajes.*
import modelos.*
import juego.*

class Musica{
const nombre
var sonando = false
method sonando() = sonando
const musica = game.sound(nombre +".mp3")
    method empezarMusica() {
        musica.play()
        musica.shouldLoop()
        musica.volume(0.2)
        sonando = true
  }
    method pararMusica() {
        musica.stop()
        sonando = false
  }
}
