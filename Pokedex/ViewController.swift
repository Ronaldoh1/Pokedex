//
//  ViewController.swift
//  Pokedex
//
//  Created by Ronald Hernandez on 8/13/16.
//  Copyright © 2016 Ronaldoh1. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemons = [Pokemon]()
    var isInSearchMode = false
    var filteredPokemons = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeAudio()
        parsePokemonCSV()
        searchBar.returnKeyType = .Done
        
    }
    
    //Play music
    func initializeAudio() {
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")
        do {
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path!)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    func parsePokemonCSV() {
        guard let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv") else {
            return
        }
        
        do  {
            let  csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                
                guard let pokeId = Int(row["id"]!) else {
                    return
                }
                
                guard let name = row["identifier"] else {
                    return
                }
                
                let pokemon = Pokemon(name: name, pokedexId: pokeId)
                pokemons.append(pokemon)
                
            }
            
        } catch let error as NSError {
            print(error.debugDescription)
        }
        
        
    }
    
    @IBAction func musicButtonTapped(sender: UIButton) {
        
        if musicPlayer.playing {
            musicPlayer.stop()
            sender.alpha = 0.2
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toPokemonDetails" {
            if let detailsVC = segue.destinationViewController as? PokemonDetailVC {
                if let pokemon = sender as? Pokemon {
                    detailsVC.pokemon = pokemon
                }
            }
        }
    }
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isInSearchMode = false
            view.endEditing(true)
            collectionView.reloadData()
        } else {
            isInSearchMode = true
            let lower = searchBar.text?.lowercaseString
            // check this pokemon object and grab it's property. Go through the array
            filteredPokemons = pokemons.filter({ $0.name!.rangeOfString(lower!) != nil})
            collectionView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let pokemon = isInSearchMode ? filteredPokemons[indexPath.row] : pokemons[indexPath.row]
       print(pokemon.name)
        performSegueWithIdentifier("toPokemonDetails", sender: pokemon)
            
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(105, 105)
    }
    
}

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isInSearchMode ? filteredPokemons.count : pokemons.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell {
            
            let pokemon = isInSearchMode ? filteredPokemons[indexPath.row] : pokemons[indexPath.row]
            cell.configureCell(pokemon)
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
}