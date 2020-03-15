//
//  Education.swift
//  MyResumeApp
//
//  Created by Saravanan on 18/11/19.
//  Copyright © 2019 Saravanan Vijayakumar. All rights reserved.
//

import SwiftUI

struct SpecialisationView: View {
    let data: EducationInstitutionData
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(data.name + ", (" + data.duration + ")")
                .font(.subheadline)
                .foregroundColor(ThemeColor)
            Text(data.location)
                .font(.footnote)
                .foregroundColor(.gray)
            HStack {
                Text("Score:   ")
                    .font(.callout)
                Text(data.score)
                    .font(.caption)
            }
            HStack {
                Text("Degree: ")
                    .font(.callout)
                Text(data.degree)
                    .font(.caption)
            }
        }
    }
}

struct EducationView: View {
    let data: EducationData
    
    var body: some View {
        HStack(alignment: .top) {
            DividerView(dataType: .Education).frame(maxHeight: .infinity)
            VStack(alignment: .leading)  {
                SpecialisationView(data: data.college)
                Spacer()
                SpecialisationView(data: data.school)
            }
            .padding(EdgeInsets(top: DIVIDERTOPLABELPADDING, leading: 0, bottom: 0, trailing: 0))
        }
    }
}

