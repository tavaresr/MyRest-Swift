//
//  Imagens.swift
//  MyRest
//
//  Created by Ricardo Tavares.
//  Copyright (c) 2015 Ricardo Tavares. All rights reserved.
//

import Foundation
import CoreData

class Imagens:NSManagedObject
{
    @NSManaged var nome: String
    @NSManaged var galeria: Galeria
    @NSManaged var noticias: Noticias
    @NSManaged var pratos: Pratos
}