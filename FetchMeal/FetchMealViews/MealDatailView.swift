//
//  MealDatailView.swift
//  FetchMeal
//
//  Created by Roman on 5/4/23.
//

import SwiftUI

struct MealDatailView: View {
    var details: String
    var body: some View {
        Text(details)
    }
}

struct MealDatailView_Previews: PreviewProvider {
    static var previews: some View {
        MealDatailView(details: "details")
    }
}
