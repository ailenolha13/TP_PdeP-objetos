object gandalf {
    var property vida = 0
    const property armas = #{baston,espada}
    method agregarArma(arma) {armas.add(arma) }
    method sacarArma(arma) {armas.remove(arma) }
    method poderArmas() = (armas.sum({arma=> arma.poder()}))
    method poder() {
        if (vida>10)
        {return vida*15 + 2*self.poderArmas()}
        else
        {return vida*300 + 2*self.poderArmas()}
    }
}

object espada {
  var property poder = 0
  var property origen = 25
  
  method poder() {
    return origen*10
  }

  method tuOrigen(unOrigen) {
    if (unOrigen=="elfico")
    origen = 25
    else
    if (unOrigen=="enano")
    origen = 20
    else
    if (unOrigen=="humano")
    origen = 15
  }
}

object baston {
  var property poder = 400
}