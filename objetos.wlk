import personajes.*
import wollok.game.*

class Objeto {
  const nombre
  method nombre() = nombre
  const esEnemigo = false
  const frase
  const property position 
  method image() = nombre + ".png"
  method sonido() = nombre + ".mp3"
  method esEnemigo() = esEnemigo
  method esRecogido() {
    game.say(carpincho, frase)
    game.removeVisual(self)
    game.sound(self.sonido()).play() 
  }
  method resetear() {
    
  }
}