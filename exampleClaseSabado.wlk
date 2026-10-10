object pacman {
	var vidas = 3
	var property image = "pacman.png"
	var property position = game.origin()
	method image() = image
	method cantVidas() = vidas
	method perderVida() {
		vidas = vidas - 1
		game.say(self, "PERO QUE PELOTUDO SOY! Vidas: " + self.cantVidas().toString())
		if (self.juegoTerminado()) {  // aca si me quedo sin vidas termina con la imagen de perdiste
			position = game.origin()
			
		} else { 					  //  si todavia tengo vidas inicio en la posicion de inicio
			image = "pacman.png"
			position = game.origin()
		}
	}
	method juegoTerminado() = vidas == 0

	method aumentarVida() {
		vidas = vidas + 1
		game.say(self, "PUTA, PERO QUE RICO! Vidas: " + self.cantVidas().toString())
		image = "pacmanMayor.png"
	}

}

class Rival {
	const numero
	var property position = game.at(numero + 1, numero + 1)
	method image() = "rival" + numero.toString() + ".png"

	method acercarseA(personaje) {
		const otroPosicion = personaje.position()
		var newX = position.x() + if (otroPosicion.x() > position.x()) 1 else -1
		var newY = position.y() + if (otroPosicion.y() > position.y()) 1 else -1
		position = game.at(newX, newY)
	}
}
class Frutita {
	var property position = game.at(4 , 1)
	method image() = "cherry.png"

	method serComida() {
		game.removeVisual(self)
	}
}

object generadorDeFrutas {  // todo esto fue consultado con IA. DEBO PRACTICARLO SI O SI!
	method crear(cantidad) {
		const posicionesLibres = []
		game.width().times { x =>
			game.height().times { y =>
				const posicion = game.at(x, y)
				if (game.getObjectsIn(posicion).isEmpty()) {
					posicionesLibres.add(posicion)
				}
			}
		}

		if (cantidad < 0 || cantidad > posicionesLibres.size()) {
			throw new Exception("La cantidad de frutas debe estar entre 0 y la cantidad de casillas libres")
		}

		const frutas = []
		cantidad.times { indice =>
			const posicion = posicionesLibres.anyOne()
			posicionesLibres.remove(posicion)
			frutas.add(new Frutita(position = posicion))
		}
		return frutas
	}
}
