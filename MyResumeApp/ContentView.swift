//
//  ContentView.swift
//  MyResumeApp
//
//  Created by Saravanan on 06/11/19.
//  Copyright © 2019 Saravanan Vijayakumar. All rights reserved.
//

import SwiftUI

let ContactWidth: CGFloat = 300

struct HeaderView: View {
    let data: ResumeData
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(data.header.name.uppercased())
                    .font(.largeTitle)
                Text(data.header.designation)
                    .foregroundColor(ThemeColor)
                    .font(.headline)
                Text(data.header.role + "(" + data.header.domains + ")")
                    .foregroundColor(ThemeColor)
                    .font(.subheadline)
            }
            .padding()
//            .frame(width: 400)
            Spacer()
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    ImageIconView(dataType: .Phone)
                    Text(data.header.phone)
                }
                HStack(alignment: .center) {
                    ImageIconView(dataType: .Email)
                    Text(data.header.email)
                }
                HStack(alignment: .center) {
                    ImageIconView(dataType: .Blog)
                    Text(data.header.blog)
                }
                HStack(alignment: .center) {
                    ImageIconView(dataType: .Github)
                    Text(data.header.github)
                }
            }
            .frame(width: ContactWidth)
        }
//            .edgesIgnoringSafeArea(.horizontal)

    }
}

struct AboutMyselfView: View {
    let data: AboutMyselfData
    
    var body: some View {
        HStack(alignment: .top) {
            DividerView(dataType: .AboutMe)
            VStack(alignment: .leading) {
                Text(data.title)
                    .font(.title)
                Text(data.description)
                    .padding()
//                    .frame(height: 200)
            }
        }
    }
}

struct ProjectView: View {
    let data: ProjectData
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(data.id + ". ")
                Text(data.title + ":")
                Text(data.link)
            }
            Text(data.description)
                .lineLimit(4)
            Text(data.responsibility)
                .lineLimit(4)
        }
        .padding()
//        .frame(height: 70)
    }
}

struct CompanyHeaderView: View {
    let data: CompanyData
    var body: some View {
        let roleAt = self.data.role.count > 0 ? "@" : ""
        return HStack(alignment: .center) {
            Text(data.role)
                .bold()
            Text(roleAt)
            Text(data.name + ", ")
            Text(data.location)
                .italic()
            Text("(" + data.duration + ")")
                .italic()
        }
        .frame(height: 50)
    }
}

struct DividerView: View {
    let dataType: DataType
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Rectangle().fill(ThemeColor)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)//This makes sure to occupy the remaining area of the superview
                .frame(width: dataType.topLabelWidth(), height: dataType.topLabelHeight())
            ImageIconView(dataType: dataType)
            Rectangle().fill(ThemeColor)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)//This makes sure to occupy the remaining area of the superview
                .frame(width: 2)
        }
    }
}

struct CompanyView: View {
    let data: CompanyData
    
    var body: some View {
        HStack(alignment: .top) {
            DividerView(dataType: .Company)
            
            VStack(alignment: .leading) {
                CompanyHeaderView(data: data)
//                    .frame(height: 50)//DONT set here since it is set within the subview
//                .padding(EdgeInsets(top: DIVIDERTOPLABELPADDING, leading: 0, bottom: 0, trailing: 0))
                ProjectsListView(data: data.projects)
//                    .frame(height: .infinity)
//                .frame(height: height)
//                .padding(EdgeInsets(top: 0, leading: -15, bottom: 0, trailing: 0))
    //            .frame(height: CGFloat(data.projects.count*70))//Don't hardcode it, Let it happen dymanically
            }
        }
    }
}


struct ProjectsListView: View {
    let data: [ProjectData]
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(data) { project in
                ProjectView(data: project)
            }
        }
//        List(data) { project in
//            ProjectView(data: project)
//        }
//        .listRowInsets(EdgeInsets())
    }
}

struct model: Identifiable {
    var id: Int
    var text: String
}

struct CompaniesListView: View {
    let data: CompaniesData
    let array = [model(id: 1, text: "1"), model(id: 2, text: "2")]

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(data.companies) { company in
                CompanyView(data: company)
            }
//            List(array) { item in
//                Text(item.text)
//            }
        }
//        return List(array) { item in
//            Text(item.text)
//        }
////        .frame(height: 100)
//        List(data.companies) { company in
//            CompanyView(data: company)
////            .padding(EdgeInsets(top: -10, leading: 0, bottom: -10, trailing: 0))
//        }
////        .lineSpacing(0)
////        .frame(height: 500)
////        .listRowInsets(EdgeInsets())
//        .listRowInsets(EdgeInsets(top: -6, leading: 0, bottom: 0, trailing: 0)) //TODO:Remove the hardcodede padding value

    }
}


struct ResumeView: View {
    let data: ResumeData
    let padding: CGFloat = 15
    
    var body: some View {
//        List() {
        ScrollView {
        VStack(alignment: .leading) {
            HeaderView(data: data)
            AboutMyselfView(data: data.aboutMyself)
//                .listRowInsets(EdgeInsets(top: padding, leading: padding, bottom: 0, trailing: padding))

            CompaniesListView(data: data.companies)
//                .listRowInsets(EdgeInsets(top: 0, leading: padding, bottom: 0, trailing: padding))

            EducationSkillsView(education: data.education, skills: data.skills)
//                .listRowInsets(EdgeInsets(top: 0, leading: padding, bottom: 0, trailing: padding))
        }
        .padding().layoutPriority(-1)
        }
//        .listRowInsets(EdgeInsets(top: 0, leading: padding, bottom: 0, trailing: padding))
//        .listRowInsets(EdgeInsets())
//        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: -20, trailing: 0))
//        .onAppear { UITableView.appearance().separatorStyle = .none }
//        .onDisappear { UITableView.appearance().separatorStyle = .singleLine }

    }
}

//MARK: ContentView
struct ContentView: View {

    var body: some View {
        return ResumeView(data: ResumeData.fromLocalJson())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
