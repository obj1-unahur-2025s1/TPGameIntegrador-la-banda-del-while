class Personaje {
    var vida
    var velocidadMovimiento
}

class Sobreviviente inherits Personaje {
    var rescatado = false
    const armaADropear
    method rescatePorSoldado(unSoldado){
        soldado.rescatarSobreviviente(self)
        rescatado = true
    }
    method mordidaZombie(unZombie){
        self.transformarEnZombie()
    }
    //ver como transformar en zombie
    method transformarEnZombie()
    //chequear metodo en sobreviviente y en el soldado si se ejecuta bien
    method dropArma(soldado){
        if(soldado.rescatarSobreviviente(self)){
            soldado.agregarArmaAlInvetario(self.getArma())
        }
    } //te da el arma dropeada
    method getArma() = armaADropear
}

class Zombie inherits Personaje {
    method atacarSoldado(unSoldado){
        unSoldado.recibirAtaqueZombie()
    }
    method morderSobreviviente(sobreviviente){
        sobreviviente.transformarEnZombie()
    }

}

object soldado {
    const property armas = []
    var puntos = 0
    var vida = 100
    var velocidad = 100
    var property position = game.center()
	var property perfil = "fren"
	var property image = self.perfil()
    
    method image() = "soldado.png"
 	method puntoX () = self.position().x()
	method puntoY () = self.position().y()
 	method coordenadas() = [self.position().x(), self.position().y()]
 	method moverArriba(){ 
 		self.perfil("es")				 
 	}
 	method moverAbajo(){
 		self.perfil("fren")
 	}
 	method moverDerecha(){
 		self.perfil("der")
 	} 
 	method moverIzquierda(){
 		self.perfil("izq")
 	}

    //chequear metodo en sobreviviente y en el soldado si se ejecuta bien
    method rescatarSobreviviente(sobreviviente){
        puntos += sobreviviente.puntos()
        self.agregarArmaAlInvetario(sobreviviente)
    }
    method atacarZombie(){}
    method recibirAtaqueZombie(){
        vida = (vida - 20).max(0)

        // ver como hacer para que la velocidad se disminuya por un tiempo y dsp se retorne al 100
        velocidad = (velocidad / 2).max(0)
    }
    method agregarArmaAlInvetario(unSobreviviente){
        armas.add(unSobreviviente.dropArma())
    }


}

  
  