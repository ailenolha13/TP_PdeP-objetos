object gandalf {
    var property vida = 100
    const property armas = #{baston,espada}
    method tieneArmas() {
        return armas.size() > 0
    }
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
  var property poderOriginal = 30
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
//Conceptos utilizados: encapsulamiento, abstracción, polimorfismo y delegación 
object lebennin{
  const property poderRequerido = 1500

  method atravesarZona(personaje) = personaje.poder() > poderRequerido
  method recorrerZona(personaje) {}
}

object minasTirith{
  method atravesarZona(personaje) =  personaje.tieneArmas()
  method recorrerZona(personaje) {
    personaje.vida(personaje.vida()-10)
  }
}

object lossarnach{
    method atravesarZona(personaje) = true
    method recorrerZona(personaje) {
        personaje.vida(personaje.vida()+1)
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
    }
}

//Tom Bombadil
//Conceptos utilizados: polimorfismo, abstracción, encapsulamiento
object tomBombadil { 
    var property vida = 100
    method poder() = 10000 
    method armas() = #{}
    method tieneArmas() {
        return self.armas() > 0
    }
    method atravesarZona(zona) = true
    method consecuenciaZona(zona) = false
}

// Parte 2

class Espada {
  var property multiplicador = 0
  var property origen = elfico
  method poder() = origen.poderOriginal()*multiplicador
}

class Baculo {
  var property poder = 0
}

class Daga inherits Espada {
  override method poder() {
    return (origen.poderOriginal()*multiplicador)/2
  }
}

class Arco {
  var property tension = 40
  var property longitud = 0
  method aumentarTension(aumento) {tension = tension + aumento}
  method reducirTension(reduccion) {tension = tension - reduccion}
  method poder() = (tension*longitud)/10
}

class Hacha {
  var property largo = 0
  var property peso = 0
  method poder() = largo*peso
}
//Conceptos utilizados:
// Clases, SuperClases, delegacion, abstraccion, encapsulamiento y polimorfismo

class Guerrero {
  var property vida = 0
  var property armas = []
  var property items = [] 
  method poderArmas() = (armas.sum({arma=> arma.poder()}))
  method cantItems() = (items.size())

  method modificarVida(efectoVida) {
    vida = vida + efectoVida
    if (vida < 0) {
      vida = 0
    }
  }
  method estaFueraDeCombate() = vida == 0

  method ganarItem(item, cantidad) = cantidad.times({items.add(item)})

  method encontrarItem(itemAEncontrar) = items.findOrElse({item => item == itemAEncontrar}, {"Item no encontrado"})
  method eliminarItem(itemAEliminar) {
    if (self.encontrarItem(itemAEliminar) == "Item no encontrado"){
      return
    } else {
      items.remove(itemAEliminar)
    }
  }
  method perderItem(itemAEliminar, cantidad) {
    cantidad.times({items => self.eliminarItem(itemAEliminar)})
  }

  method obtenerCantidadItemIguales(itemAEvaluar) = items.count({item => item == itemAEvaluar})
}


class Hobbit inherits Guerrero {
  method poder() = vida+self.poderArmas()+self.cantItems()
}

class Enano inherits Guerrero {
  var property factor = 0
  method poder() = vida+self.poderArmas()*factor
}

class Elfo inherits Guerrero {
  var property destrezaBase = 2
  method aumentarDestrezaBase(aumento) {destrezaBase = destrezaBase + aumento}
  method reducirDestrezaBase(reduccion) {destrezaBase = destrezaBase - reduccion}
  var property destrezaPropia = 0
  method aumentarDestrezaPropia(aumento) {destrezaPropia = destrezaPropia + aumento}
  method reducirDestrezapropia(reduccion) {destrezaBase = destrezaPropia - reduccion}
  method poder() = vida+self.poderArmas()*(destrezaBase+destrezaPropia)
}

class Humano inherits Guerrero {
  var property limitador = 0
  
  method poder() {
    if (limitador == 0) {
      return 0
    }
    return vida * self.poderArmas()
  
  }
}

class Maiar inherits Guerrero {
  var property factorBasico = 15
  var property factorBajoAmenaza = 300
  method poder() {
        if (vida>10)
        {return vida*factorBasico + 2*self.poderArmas()}
        else
        {return vida*factorBajoAmenaza + 2*self.poderArmas()}
    }
}

object gollum inherits Hobbit {
  override method poder() {
    if(self.cantItems() == 0){
      return super()
    }
    return super() / 2
  }

}

//Conceptos utilizados:
// Clases, SuperClases, delegacion, abstraccion, encapsulamiento y polimorfismo

//Los caminos de la tierra media
class GrupoGuerreros {
    var property guerreros = #{} 
    var property caminosRecorridos = []

    method grupoCuentaConItems(cantidadRequerida, itemAEvaluar) = (guerreros.sum({ 
        guerrero => guerrero.obtenerCantidadItemIguales(itemAEvaluar)}) - cantidadRequerida >= 0 
        )
    
    method grupoAptoParaLebennin() = guerreros.any({
      guerrero => guerrero.poder() == poderMilQuinientos.obtenerRequerimientoPoder()
      }
      )

    method grupoAptoParabosqueDeFangorn() = guerreros.any({
      guerrero => guerrero.armas().size() > 0 }
      )
    
}

// Modelo region
class Region {
    var property nombre 
    var property zonas = #{} 
}

// Modelamos Zona
class Zona {
    var property nombre
    var property requerimiento 
    var property region
    var property efecto
    var property limitaCon = #{}
    
    method region(_region) { region = _region }

    method puedeAtravesarZona(grupoGuerreros) = requerimiento.evaluarRequerimiento(grupoGuerreros)

    method intentarAtravesarZona(grupoGuerreros) {
      if (!self.puedeAtravesarZona(grupoGuerreros)) {
        throw new Exception(message = 'El grupo de guerreros no cumple con los requisitos para atravesar esta zona')
      }
      efecto.aplicar(grupoGuerreros)
    }
    method evaluaLimitrofe(zona1, zona2) {
      return zona1.limitaCon().contains(zona2.nombre()) || zona2.limitaCon().contains(zona1.nombre())
    }
}

//Modelos Requerimientos
class Requerimiento {
    //0: sin requerimientos; 1: requerimiento item; 2: requerimiento guerrero
    var property tipoRequerimiento = 0  
    method evaluarRequerimiento(grupoGuerreros){
      return true
    }
}

//Modelos Requerimiento Item
class RequerimientoItem inherits Requerimiento { 
    var property cantidad
    var property nombre  

    override method tipoRequerimiento() = 1

    override method evaluarRequerimiento(grupoGuerreros) {
      return grupoGuerreros.grupoCuentaConItems(cantidad, nombre)
    }
}

//Modelo caminos
class Camino {
    var property zonas = []

    method puedeAtravesarCamino(grupoGuerreros) {
      return zonas.all({ zona => zona.requerimiento().evaluarRequerimiento(grupoGuerreros) })
    }

    method caminoValido() {
      var validez = true
      var i = 0
      zonas.forEach({
        zona1 => 
        if(i < zonas.size() - 1) {
          const zona2 = zonas[i+1]
          if(zonas.evaluaLimitrofe(zona1, zona2)){
          validez = false
          }
        }
      i = i+1
      }
      )
      return validez
    }

     method intentarAtravezarCamino(grupoGuerreros) {
        if (!self.caminoValido()) {
        throw new Exception(message = 'El camino no es válido')
    }
}

    method regionesAtravezadas() {
      const listaConDuplicados = zonas.map({zona => zona.region().nombre()})
      const listaSinDuplicados = []

      listaConDuplicados.forEach({
        elemento => if(!listaSinDuplicados.contains(elemento)){
          listaSinDuplicados.add(elemento)
        }
      })
      return listaSinDuplicados
    }
}

// Requerimientos de guerreros
object poderMilQuinientos inherits Requerimiento {

    method obtenerRequerimientoPoder() = 1500

    override method tipoRequerimiento() = 2

    override method evaluarRequerimiento(grupoGuerreros) { 
      return grupoGuerreros.grupoAptoParaLebennin()   
    }
}

object tieneArmas inherits Requerimiento {

    override method tipoRequerimiento() = 2

    override method evaluarRequerimiento(grupoGuerreros) {
     return grupoGuerreros.grupoAptoParabosqueDeFangorn()
     }
}

// Modelamos efecto
// Utilizamos clases y herencia, ya que de esta forma es mas robusto para el caso de que fuera necesario tener distintos tipos de efectos
class Efecto {
  method aplicar(grupoGuerreros) {}
}

class EfectoVida inherits Efecto{
  var property variacionVida = 0

  override method aplicar(grupoGuerreros) {
    grupoGuerreros.guerreros().forEach({ guerrero => 
        if (!guerrero.estaFueraDeCombate()) {
            guerrero.modificarVida(variacionVida)
        }
    })
  }
}

class EfectoItem inherits Efecto{
  var property item
  var property cantidad

  override method aplicar(grupoGuerreros) {
    grupoGuerreros.guerreros().forEach({ guerrero => 
        if (!guerrero.estaFueraDeCombate()) {
            if (cantidad > 0) {
                guerrero.ganarItem(item, cantidad)
            } else {
                guerrero.perderItem(item, cantidad.abs())
            }
        }
    })
  } 
}
