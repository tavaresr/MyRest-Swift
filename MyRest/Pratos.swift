//
//  Pratos.swift
//  MyRest
//
//  Created by Ricardo Tavares.
//  Copyright (c) 2015 Ricardo Tavares. All rights reserved.
//

import Foundation
import CoreData

class Pratos:Ingrediente
{
    @NSManaged var id: String
    @NSManaged var nome: String
    @NSManaged var preco: String?
    @NSManaged var descricao: String
    @NSManaged var data: NSDate
    @NSManaged var categoria: Categorias
    @NSManaged var imagens: Imagens
    
}