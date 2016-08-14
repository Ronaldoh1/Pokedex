//
//  Pokemon.swift
//  Pokedex
//
//  Created by Ronald Hernandez on 8/13/16.
//  Copyright © 2016 Ronaldoh1. All rights reserved.
//

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
    }
    
}
