//
//  BillModel.swift
//  PayTheBill
//
//  Created by Lucas Kusman Leal on 15/05/22.
//

import Foundation
import SwiftUI

struct BillModel: Identifiable, Codable {
    var id: String = UUID().uuidString;
    var userUid: String?;
    var billOwner: String?;
    var billCategory: String?;
    var title: String?;
    var desc: String?;
    var value: Float?;
    var payedValue: Float?;
    var parcels: Int?;
    var creationDate: String?;
    var finishDate: String?;
}
