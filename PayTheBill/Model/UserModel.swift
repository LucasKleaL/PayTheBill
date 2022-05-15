//
//  UserModel.swift
//  PayTheBill
//
//  Created by Lucas Kusman Leal on 13/05/22.
//

import Foundation
import SwiftUI

struct UserModel: Identifiable, Codable {
    var id: String = UUID().uuidString;
    var userUid: String?;
    var userName: String?;
    var userBills: Array<String>?;
}
