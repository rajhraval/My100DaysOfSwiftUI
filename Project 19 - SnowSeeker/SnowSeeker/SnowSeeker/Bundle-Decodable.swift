//
//  Bundle-Decodable.swift
//  SnowSeeker
//
//  Created by RAJ RAVAL on 06/04/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import Foundation

extension Bundle {
    
    func decode<T: Decodable>(_ file: String) -> T {
        
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) form bundle.")
        }
        
        return loaded
        
    }
    
}
