import sfx.*
import objetos.*
import wollok.game.*
import personajes.*
import modelos.*
import menu.*
import interfaz.*

object juego {
  const property todo = [termo, yerba, donSatur, enemigo, firefly, culebrita, carpincho, boss, inventario, inventario2, inventario3, carpinchoConsejero, say] 
  const property hitboxesBoss = [bossHitbox1, bossHitbox3, bossHitbox5, bossHitbox7, bossHitbox9]
  method boss() = boss
  var carpinchoAparecio = false
  method iniciar() {
    menu.gameOver(false)
    game.addVisual(carpincho)
    self.activarMovimientoCarpincho()
    barraVidaCarpincho.mostrarVida(carpincho.vida())
    game.addVisual(carpinchoConsejero)
    game.addVisual(inventario)
    game.addVisual(inventario2)
    game.addVisual(inventario3)
    game.addVisual(termo)
    game.addVisual(yerba)
    game.addVisual(donSatur)
    game.addVisual(enemigo)
    game.addVisual(firefly)
    game.addVisual(culebrita)
    musicaDeFondo.empezarMusica()
    game.onTick(3000, "movimiento", { firefly.movete() culebrita.movete()})
  }
  method activarMovimientoCarpincho() { 
  // SI NO HAY UNA VARIABLE QUE CONTROLE, EL CARPINCHO DESPUES DE RESETEAR SE MUEVE DOBLE
    if (not carpinchoAparecio){
      keyboard.up().onPressDo({if(carpincho.position().y() < 19)carpincho.movimiento(0, -1)})
      keyboard.left().onPressDo({if(carpincho.position().x() > 1)carpincho.movimiento(-1, 0)})
      keyboard.down().onPressDo({if(carpincho.position().y() > 1)carpincho.movimiento(0, +1)})
      keyboard.right().onPressDo({if(carpincho.position().x() < 22)carpincho.movimiento(+1, 0)})
      game.onCollideDo(carpincho, {
        algo => if(algo.tipoColision() == "Enemigo" and carpincho.puedePelear()) // Evitar multiples colisiones con la misma hitbox
        {algo.pelear()}
        if(algo.tipoColision() == "Objeto")
        {carpincho.recoger(algo)}
        })
      keyboard.space().onPressDo({carpincho.activarSupercarpincho()})
      carpinchoAparecio = true
    }
  }
}
