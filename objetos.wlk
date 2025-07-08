import personajes.*
import wollok.game.*

class Objeto {
  const positionInventario
  const nombre
  method nombre() = nombre
  const frase
  var property position 
  var recogido = false
  method recogido() = recogido
  method image() = nombre + ".png"
  method sonido() = nombre + ".mp3"
  method tipoColision() = "Objeto"
  method esRecogido() {
    carpincho.decir(frase)
    game.sound(self.sonido()).play() 
    recogido = true
  }
  method resetear() {
    recogido = false
  }
  method cambiarPosition(){
    position = positionInventario
  }
}