//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Ronald Hernandez on 8/14/16.
//  Copyright © 2016 Ronaldoh1. All rights reserved.
//

import UIKit
import Alamofire

class PokemonDetailVC: UIViewController {
    
    @IBOutlet weak var pokemonName: UILabel!
    
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var baseAttackLabel: UILabel!
    @IBOutlet weak var pokedexIdLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var nextEvolutionLabel: UILabel!
    @IBOutlet weak var currentEvolution: UIImageView!
    @IBOutlet weak var nextEvolution: UIImageView!
    
    var pokemon: Pokemon!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainImage.image = UIImage(named: "\(pokemon.pokedexId)")
        
        pokemon.downloadPokemonDetail { 
            // this will be called after download is done. 
            self.updateUI()
        }
    }

    func updateUI() {
        if let description = pokemon.description {
            self.descriptionLabel.text = description
        }
    }
    

    @IBAction func backButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
