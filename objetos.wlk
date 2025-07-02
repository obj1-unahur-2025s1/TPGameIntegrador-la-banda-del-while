import personajes.*
import wollok.game.*

class Objeto {
  const nombre
  const esEnemigo
  const frase
  const property posicion 
  method image() = nombre + ".png"
  method sonido() = nombre + ".mp3"
  method position() = posicion
  method esEnemigo() = esEnemigo
  method esRecogido() {
    game.say(carpincho, frase)
    game.removeVisual(self)
    //game.sound(self.sonido()).play() agregar cuando coloquen el sonido porque rompe
  }
}