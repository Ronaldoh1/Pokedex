//
//  Pokemon.swift
//  Pokedex
//
//  Created by Ronald Hernandez on 8/13/16.
//  Copyright © 2016 Ronaldoh1. All rights reserved.
//

import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _attack: String!
    private var _nextEvolutionText: String!
    private var _weight: String!
    
    private var _pokemonUrl: String!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId)"
    }
    
    func downloadPokemonDetail(completed: DownloadComplete) {
        let url = NSURL(string: _pokemonUrl)!
        
        Alamofire.request(.GET, url).responseJSON { response in
            let result  = response.result
            
            if let dictionary = result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dictionary["weight"] as? String {
                    self._weight = weight
                }
                if let height = dictionary["height"] as? String {
                    self._height = height
                }
                
                if let attack = dictionary["attack"] as? Int {
                    self._attack = String(attack)
                }
                
                if let defense = dictionary["defense"] as? Int {
                    self._defense = String(defense)
                }
                
                //Only go into the code if it casts correctly and the array has objects.
                if let types = dictionary["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    if let type = types[0]["name"] {
                        self._type = type
                    }
                    
                    if types.count > 1 {
                        for i in (1..<types.count) {
                            if let name = types[i]["name"] {
                                self._type! += "/\(name)"
                            }
                        }
                    }
                } else {
                    self._type = ""
                }
                print(self._type)
            }
        }
    }
    
}
