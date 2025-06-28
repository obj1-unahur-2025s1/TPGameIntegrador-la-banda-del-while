Juego: "Rescate en la Ciudad"
Concepto:
Sos un Rescatista que debe ayudar a diferentes personajes en la ciudad antes de que pase algo malo.

Clases y herencia:
Clase base: Personaje
Tiene posición, energía y un método accion() que indica qué hace el personaje en el juego.

Subclases:
Rescatista (jugador)
Se mueve con las teclas.
Puede rescatar a otros personajes (tocándolos).

Civil (personajes a rescatar)
Se mueven lentamente o están quietos.
Tienen poca energía.

Villano (enemigos)
Se mueven rápido.
Pueden atacar o disminuir la energía del rescatista.

Cada subclase implementa su versión de accion() (polimorfismo):
Rescatista.accion() escucha controles para moverse.
Civil.accion() se mueve o espera a ser rescatado.
Villano.accion() persigue al rescatista.

Niveles:
Nivel 1: Zona pequeña, pocos civiles y villanos.
Nivel 2: Zona más grande, más villanos y civiles, más difícil.

Objetivo:
El jugador debe rescatar todos los civiles antes de que los villanos los transformen en zombie o antes de que se acabe el tiempo.
Si un zombie muerde a un sobreviviente, la idea es que se transforme en zombie y corra por el mapa.
Si un soldado rescata a un sobreviviente, le da puntos y a su vez cada sobreviviente dropea un arma con distinto poder (Podemos dropear arma o solamente subirle el nivel de daño al arma que tiene, yo pienso que si dropeamos armas esta bueno porque lo podemos poner en una coleccion que tiene el soldado)
Si se chocan dos zombies estaria bueno que sea forme otra imangen y saque mas daño cuando ataca al soldado.

