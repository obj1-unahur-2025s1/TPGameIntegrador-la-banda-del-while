import menu.Fondo
import objetos.Objeto
import personajes.*

//Fondos
const fondoMenu = new Fondo(position = game.at(5, 0),imagen = "fondoMenu (2).png", index = -10)
const botonJugar = new Fondo(position = game.at(23, -3),imagen = "botonJugar.png",index = -10)

//Objetos
const yerba = new Objeto(nombre = "Yerba", esEnemigo = false, posicion = game.at(6, 8), frase = "¡Que rica yerba pa!")
const termo = new Objeto(nombre = "Termo", esEnemigo = false, posicion = game.at(17, 10), frase = "Mi compañero, siempre a mi lado")
const donSatur = new Objeto(nombre = "DonSatur", esEnemigo = false, posicion = game.at(25, 15), frase = "¡Que buen bizcochito!")

//Enemigos
const enemigo = new Enemigo(danioBase = 1, vida = 5, position = game.at(6, 5))
const firefly = new Luciernaga(danioBase = 2, vida = 5, position = game.center())
const culebrita =  new Culebra(danioBase = 3, vida = 3, position = game.at(11,18))
const boss = new Boss(danioBase = 6, vida = 20, position = game.center())