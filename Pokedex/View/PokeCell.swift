//
//  PokeCell.swift
//  Pokedex
//
//  Created by Ronald Hernandez on 8/13/16.
//  Copyright © 2016 Ronaldoh1. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    //making corner round
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0 
        
    }
    
    func configureCell(pokemon: Pokemon) {
        
        self.pokemon = pokemon
        nameLabel.text = self.pokemon.name
        
        self.thumbImage.image = UIImage(named: "\(self.pokemon.pokedexId)")
        
    }
    
}
