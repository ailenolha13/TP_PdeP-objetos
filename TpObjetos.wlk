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
object lebennin {
    const property poderRequerido = 1500

    method atravesarZona(personaje) = personaje.poder() > poderRequerido
    method recorrerZona(personaje) {}
}

object minasTirith {

    method atravesarZona(personaje) =  personaje.tieneArmas()
    method recorrerZona(personaje) {
        personaje.vida(personaje.vida()-10)
    } 
}

object lossarnach {
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
  method obtenerCantidadItemIGuales(itemAEvaluar) = items.filter({ 
    item => item == itemAEvaluar }).size()
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
  method poder() = vida*self.poderArmas()/limitador
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
  override method poder() = (vida+self.poderArmas()+items/2)
}

//Conceptos utilizados:
// Clases, SuperClases, delegacion, abstraccion, encapsulamiento y polimorfismo

//Los caminos de la tierra media
class GrupoGuerreros {
    var property guerreros = #{} 
    var property caminosRecorridos = [] 
    
    // method agregarGuerrero(guerrero) = guerreros.add(guerrero)
    
    method obtenerCantidadTotalItem(itemAEvaluar) = guerreros.sum({ 
        guerrero => guerrero.obtenerCantidadItemIGuales(itemAEvaluar)})
    
    // method recorrerCaminos(camino) = caminosRecorridos.add(camino)
}

// Modelo region y zona
class Region {
    var property nombre 
    var property zonas = #{} 

    // method agregarZona(_zona) = zonas.add(_zona)
}

class Zona {
    var property nombre
    var property requerimiento = null
    var region  

    method asignarRequerimiento(_requerimiento) = _requerimiento

    method region(_region) { region = _region }
}

//Modelos de requerimientos
class RequerimientoItem {
    var property cantidad
    var property nombre  
}

class RequerimientoGuerrero {
    var property criterio
}

//Modelo caminos
class Camino {
    var property zonas = []

    // method agregarZona(_zona) = zonas.add(_zona)
}

//Requerimientos de guerreros
object poderMilQuinientos {
    var property requerimientoPoder = 1500

    method evaluarRequerimiento(grupoGuerreros) {
        grupoGuerreros.find({ guerrero => guerrero.poder() == 1500 })
    }
}

object tieneArmas {
    method tieneArmas(grupoGuerreros) {
      grupoGuerreros.find({ guerrero => guerrero.armas().size() > 0 })
    } 
}
