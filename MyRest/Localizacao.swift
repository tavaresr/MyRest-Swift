//
//  Localizacao.swift
//  MyRest
//
//  Created by Ricardo Tavares.
//  Copyright (c) 2015 Ricardo Tavares. All rights reserved.
//

import Foundation
import CoreData

class Localizacao:NSManagedObject
{
    @NSManaged var morada: String
    @NSManaged var coordenadas_lat: String
    @NSManaged var coordenadas_lon: String
    @NSManaged var horario: String
}