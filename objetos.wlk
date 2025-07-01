import personajes.*
import wollok.game.*

object yerba {
  const property position = game.at(6, 8)
  method image() = "yerba.jpg"

  method recoger() {
    game.onCollideDo(self, {carpincho.recogerUn(self)})
    game.removeVisual(self)
    game.say(carpincho, "¡Que rica yerba pa!")
  }
}

object termo {
  const property position = game.at(17, 10)
  method image() = "termo.jpg"

  method recoger() {
    game.onCollideDo(self, {carpincho.recogerUn(self)})
    game.removeVisual(self)
    game.say(carpincho, "Mi compañero, siempre a mi lado")
  }
}