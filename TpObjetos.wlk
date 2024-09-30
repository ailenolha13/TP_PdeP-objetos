object gandalf {
    var property vida = 100
    const property armas = #{baston,espada}
    method agregarArma(arma) {armas.add(arma)}
    method sacarArma(arma) {armas.remove(arma)}
    method poderArmas() = (armas.sum({arma=> arma.poder()}))
    method poder() {
        if (vida>10)
        {return vida*15 + 2*self.poderArmas()}
        else
        {return vida*300 + 2*self.poderArmas()}
    }
}

object espada {
  
  var property origen = elfico
  method poder() = origen.poderOriginal()*10
  
}

object elfico {
  var property poderOriginal = 25
}
object enano {
  var property poderOriginal = 20
}
object humano {
  var property poderOriginal = 15
}

object baston {
  var property poder = 400
}

// Conceptos utilizados:
// colecciones, polimorfismo, delegacion, abstraccion y encapsulamiento

// Recorriendo la Tierra Media

// Zonas de la Tierra Media

object lebennin {
    const property poderRequerido = 1500

    method atravesarZona(personaje) = personaje.poder() > poderRequerido
    method recorrerZona(personaje) {
        personaje
    } 
}

object minasTirith {

    method atravesarZona(personaje) =  personaje.armas().size() > 0 
    method recorrerZona(personaje) {
        personaje.vida() - 10
    } 
        
}

object lossarnach {
    method atravesarZona(personaje) = true
    method recorrerZona(personaje) {
        personaje.vida() + 1
    }
}

// Camino de Gondor
// Conceptos utilzados:
// Polimorfismo, abstracción, encapsulamiento, delegación 
object gondor {
    var zonaInicio = null
    var zonaDestino = null

    method definirCamino(zona1, zona2) {
        zonaInicio = zona1
        zonaDestino = zona2
    }

    method puedeAtravesarZonas(personaje){
        return zonaInicio.atravesarZona(personaje) && zonaDestino.atravesarZona(personaje)
    }

    method recorrerCamino(personaje) {
      if (self.puedeAtravesarZonas(personaje)) {
            zonaInicio.recorrerZona(personaje)
            zonaDestino.recorrerZona(personaje)
        }
        return personaje
    }
}

// lebennin → poder > 1500 → OK
// minas tirith → armas > 0 → OK
// lossarnach → sinRequisitos → OK

// zonas → lebennin → noPasaNada → OK
//       → minas tirith → vida = vida - 10 → OK
//       → lossarnach → vida = vida + 1 → OK

// caminoGondor 
// gondor → lebennin a minas tirith → poder > 1500 y armas > 0 → OK
// gondor → noPasaNada y vida = vida - 10 → OK  

//Tom Bombadil
object tomBombadil {

    method atravesarZona(zona) = true
    method consecuenciaZona(zona) { }
}