//
//  TodoItem.swift
//  TODO
//
//  Created by suthee prudchayatanakul on 29/1/2562 BE.
//  Copyright © 2562 organization name. All rights reserved.
//

import Foundation

class TodoItem {
    var message: String = ""
    var completed: Bool = false
        
    init(withMessage: String) {
        self.message = withMessage
        self.completed = false
    }
}
