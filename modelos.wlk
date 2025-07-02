import menu.Fondo
import objetos.Objeto
import personajes.*
import sfx.*

//Fondos
const fondoMenu = new Fondo(position = game.at(0, 0),imagen = "fondomenui.jpg", index = -10)
const botonJugar = new Fondo(position = game.at(9, 0),imagen = "botonJugar2.png",index = -10)
const gameOverImagen = new Fondo(position = game.at(7,6),imagen = "GameOver.png", index = -10)
const youWinImagen = new Fondo(position = game.at(6,5), imagen = "youWin.png", index = -10)

//Objetos // PARA DECIRLE AL PROFE SON INSTANCIAS DE LA CLASE OBJETO
const yerba = new Objeto(nombre = "Yerba", position = game.at(6, 8), frase = "¡Que rica yerba pa!") 
const termo = new Objeto(nombre = "Termo",  position = game.at(17, 10), frase = "Mi compañero, siempre a mi lado")
const donSatur = new Objeto(nombre = "DonSatur", position = game.at(8, 15), frase = "¡Que buen bizcochito!      ")

//Enemigos
const enemigo = new Enemigo(danioBase = 1, vida = 5, position = game.at(17, 1))
const firefly = new Luciernaga(danioBase = 2, vida = 5, position = game.at(5, 5))
const culebrita =  new Culebra(danioBase = 3, vida = 5, position = game.at(11,8))
const boss = new Boss(danioBase = 2, vida = 20, position = game.at(11,8))

//Musica

const musicaDeBoss = new Musica(nombre = "bossSoundtrack")
const musicaDeFondo = new Musica(nombre = "MusicaNivel")