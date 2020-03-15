//
//  Skills.swift
//  MyResumeApp
//
//  Created by Saravanan on 18/11/19.
//  Copyright © 2019 Saravanan Vijayakumar. All rights reserved.
//

import SwiftUI

struct RatingsImage: View {
    let index: Int
    let value: Int
    let starFilledImage = IconFont.image(fromIcon: .star, size: 20, color: ThemeUIColor)!
    let starEmptyImage = IconFont.image(fromIcon: .star_empty, size: 20, color: ThemeUIColor)!

    var body: some View {
        let image =  value >= index ? starFilledImage : starEmptyImage
        return Image(uiImage: image)
            .frame(width: 30, height: 30)
            .clipped()
            .listRowInsets(EdgeInsets())
    }
}

struct RatingsView: View {
    let rating: Int
    
    var body: some View {
        HStack {
            RatingsImage(index: 1, value: rating)
            RatingsImage(index: 2, value: rating)
            RatingsImage(index: 3, value: rating)
            RatingsImage(index: 4, value: rating)
            RatingsImage(index: 5, value: rating)
        }
    }
}

struct SkillView: View {
    let data: SkillData
    
    var body: some View {
        HStack {
            Text(data.skill)
            Spacer()
            RatingsView(rating: data.rating)
        }
    }
}

struct SkillsView: View {
    let data: SkillsData
    
    var body: some View {
        HStack(alignment: .top) {
            DividerView(dataType: .Skills)
            List(data.skills) { skill in
                SkillView(data: skill)
            }
            .padding(EdgeInsets(top: DIVIDERTOPLABELPADDING, leading: 0, bottom: 0, trailing: 0))
        }
    }
}

struct EducationSkillsView: View {
    let education: EducationData
    let skills: SkillsData
    
    var body: some View {
        HStack {
            EducationView(data: education)
            SkillsView(data: skills)
        }
    }
}
