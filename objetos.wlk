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
    
  } //El método está vacio ya que los objetos no cambian realmente, el reset en general lo único que debería hacer es 
  // Restaurarle la vida a los enemigos o reiniciar las características del Carpincho, los objetos ya de por si se reinician con el juego.
}