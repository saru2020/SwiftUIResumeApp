//
//  Components.swift
//  MyResumeApp
//
//  Created by Saravanan on 18/11/19.
//  Copyright © 2019 Saravanan Vijayakumar. All rights reserved.
//

import SwiftUI

struct ImageIconView: View {
    let dataType: DataType
    var body: some View {
        Image(uiImage: dataType.fontIconImage())
            .frame(width: 30, height: 30)
            .cornerRadius(15)
            .border(ThemeColor, width: dataType.imageBorderWidth())
            .clipped()
    }
}


