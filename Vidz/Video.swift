//
//  Video.swift
//  Vidz
//
//  Created by Matt Houston on 6/29/16.
//  Copyright © 2016 Matthew Houston. All rights reserved.
//

import UIKit

// Model for every video.. represents each cell

class Video: NSObject {
    
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate: Date?
    
    var channel: Channel?
    
}

class Channel: NSObject {
    var name: String?
    var profileImageName: String?

}
