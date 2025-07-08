import wollok.game.*
import juego.*
import personajes.*
import menu.*

class BarraVida{
    const property position
    const property image
    const property vidas = [image, image, image, image, image]
    const vidaAMostrar = []
    method mostrarVida(numero){
        self.sacar()
        var num = 1
        var x = 0
        const y = 18
        vidas.forEach({v =>
            if(numero >= num){ 
            const vida = new VidaObjt(image = v, position = game.at(x,y))
            vidaAMostrar.add(vida)
            x += 2
            num += 1
            } 
        }
        )
        self.mostrar()
    }
    method mostrar() {
        vidaAMostrar.forEach{v=>game.addVisual(v)}
    }
    method sacar() {
        //vidaAMostrar.forEach{v=>game.removeVisual(v) vidaAMostrar.remove(v)}
        vidaAMostrar.forEach{v=>game.removeVisual(v)}
        vidaAMostrar.clear()
    }
}

const barraVidaCarpincho = new BarraVida(position = game.at(0,18), image = "Vida.png")

class VidaObjt{
    const property image
    const property position
    method tipoColision() = "Ninguno" // polimorfismo evitar colisiones sin intencion
}

