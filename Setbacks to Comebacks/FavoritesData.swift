//
//  FavoritesData.swift
//  Setbacks to Comebacks
//
//  Created by Terry Bu on 3/20/17.
//  Copyright © 2017 Terry Bu. All rights reserved.
//

import Foundation

class FavoritesData {
    
    static let sharedInstance = FavoritesData()
    let defaults = UserDefaults.standard
    private let FavoritesArrayDataKey = "FavArrayData"
    var favoritesArray: [Person]
    
    init() {
        if let data = defaults.data(forKey: FavoritesArrayDataKey) {
            let array = NSKeyedUnarchiver.unarchiveObject(with: data) as! [Person]
            self.favoritesArray = array
        } else {
            self.favoritesArray = [Person]()
        }
    }
    
    func addObjectToFavoritesAndSave(newPerson: Person) {
        favoritesArray.append(newPerson)
        favoritesArray.sort(by: {$0.name < $1.name })
        saveFavoritesArrayCurrentStateIntoDefaults()
    }
    
    func getFavoritesArrayFromDefaults() -> [Person]? {
        if let data = defaults.data(forKey: FavoritesArrayDataKey) {
            let array = NSKeyedUnarchiver.unarchiveObject(with: data) as! [Person]
            return array.sorted(by: { $0.name < $1.name })
        }
        return nil
    }
    
    func saveFavoritesArrayCurrentStateIntoDefaults() {
        let data = NSKeyedArchiver.archivedData(withRootObject: favoritesArray)
        defaults.set(data, forKey: FavoritesArrayDataKey)
        defaults.synchronize()
    }
    
    
}
