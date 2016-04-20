//
//  Ementa.swift
//  MyRest
//
//  Created by Ricardo Tavares.
//  Copyright (c) 2015 Ricardo Tavares. All rights reserved.
//

import Foundation
import CoreData

class Ementa:NSManagedObject
{
    @NSManaged var id: Int
    @NSManaged var nome: String
    @NSManaged var categorias: NSSet
}