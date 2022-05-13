//
//  areaViewModel.swift
//  Assignment2
//
//  Created by Nguyen Quang Huy on 12/5/2022.
//

import Foundation
import CoreData
import SwiftUI

extension Area {
    var nameString: String {
        get { areaName ?? "" }
        set { areaName = newValue }
    }
}
