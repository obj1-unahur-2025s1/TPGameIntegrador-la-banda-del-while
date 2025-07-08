import menu.Fondo
import objetos.Objeto
import personajes.*
import sfx.*

//Fondos
const fondoMenu = new Fondo(position = game.at(0, 0),imagen = "fondomenui.jpg", index = -10)
const botonJugar = new Fondo(position = game.at(9, 0),imagen = "botonJugar2.png",index = -10)
const gameOverImagen = new Fondo(position = game.at(7,6),imagen = "GameOver.png", index = -10)
const youWinImagen = new Fondo(position = game.at(6,5), imagen = "youWin.png", index = -10)
const inventario = new Fondo(position = game.at(1,1), imagen = "Inventario5.png", index = -1)
const inventario2 = new Fondo(position = game.at(3,1), imagen = "Inventario5.png", index = -1)
const inventario3 = new Fondo(position = game.at(5,1), imagen = "Inventario5.png", index = -1)
const carpinchoConsejero = new Fondo(position = game.at(20,12), imagen = "carpinchosay.png", index = 20)
const say = new Fondo(position = game.at(15,16), imagen = "", index = 21)

//Objetos // INSTANCIAS DE LA CLASE OBJETO
const yerba = new Objeto(nombre = "Yerba", position = game.at(4, 8), frase = "ricomate", positionInventario = game.at(1,1)) 
const termo = new Objeto(nombre = "Termo",  position = game.at(17, 10), frase = "micompa", positionInventario = game.at(3,1))
const donSatur = new Objeto(nombre = "DonSatur", position = game.at(8, 14), frase = "ricobizcochito", positionInventario = game.at(5,1))

//Enemigos
const enemigo = new Enemigo(danioBase = 1, vida = 5, position = game.at(17, 2))
const firefly = new Luciernaga(danioBase = 2, vida = 14, position = game.at(5, 5))
const culebrita =  new Culebra(danioBase = 3, vida = 5, position = game.at(11,8))
const boss = new Boss(danioBase = 2, vida = 20, position = game.at(9,6))

//Musica

const musicaDeBoss = new Musica(nombre = "bossSoundtrack")
const musicaDeFondo = new Musica(nombre = "MusicaNivel")
const musicaIntro = new Musica(nombre = "Intro")

// HitBox

const bossHitbox1 = new Hitbox(unEnemigo = boss, position = game.at(9, 7))
const bossHitbox3 = new Hitbox(unEnemigo = boss, position = game.at(9, 9))
const bossHitbox5 = new Hitbox(unEnemigo = boss, position = game.at(10, 8))
const bossHitbox7 = new Hitbox(unEnemigo = boss, position = game.at(11, 7))
const bossHitbox9 = new Hitbox(unEnemigo = boss, position = game.at(11, 9))