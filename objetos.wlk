import personajes.*
import wollok.game.*

object yerba {
  const property position = game.at(6, 8)
  method image() = "yerba.png"
  method esEnemigo() = false
  method esRecogido() {
    game.say(carpincho, "¡Que rica yerba pa!")
    game.removeVisual(self)
    game.sound("Yerbita.mp3").play()
  }
}

object termo {
  const property position = game.at(17, 10)
  method image() = "termo.png"
  method esEnemigo() = false
  method esRecogido() {
    game.say(carpincho, "Mi compañero, siempre a mi lado")
    game.removeVisual(self)
    game.sound("termito.mp3").play()
  }
}

object donSatur {
  const property position = game.at(25, 15)
  method image() = "donSatur.png"
  method esEnemigo() = false
  method esRecogido() {
    game.say(carpincho, "¡Que buen bizcochito!")
    game.removeVisual(self)
    game.sound("donSatur.mp3").play()
  }
}