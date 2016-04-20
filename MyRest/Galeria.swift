//
//  Galeria.swift
//  MyRest
//
//  Created by Ricardo Tavares.
//  Copyright (c) 2015 Ricardo Tavares. All rights reserved.
//

import Foundation
import CoreData

class Galeria:NSManagedObject
{
    @NSManaged var id: Int
    @NSManaged var imagens: Imagens
}