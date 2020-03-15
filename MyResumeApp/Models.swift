//
//  Models.swift
//  MyResumeApp
//
//  Created by Saravanan on 18/11/19.
//  Copyright © 2019 Saravanan Vijayakumar. All rights reserved.
//

import UIKit

let DIVIDERTOPLABELPADDING: CGFloat = 15
let DIVIDERLABELWIDTH: CGFloat = 2

struct HeaderData: Codable {
    var name = "Name"
    var designation = "Designation"
    var role = "Role"
    var domains = "Domains"
    var phone = "Phone"
    var email = "Email"
    var blog = "blog"
    var github = "github"
}

struct AboutMyselfData: Codable {
    var title = "About Myself"
    var description = "Description about myself"
}

struct ProjectData: Codable, Identifiable {
    var id = "Project Identifier"
    var title = "Project Title"
    var link = "Project/App Link"
    var description = "Description blah blah blah blah blah blah blah blah blah blah "
    var responsibility = "Responsibility blah blah blah blah blah blah blah blah blah blah "
}

struct CompaniesData: Codable {
    var companies: [CompanyData]
    
    init() {
        var company1 = CompanyData()
        company1.name = "Company 1"
        company1.location = "Company 1 location"
        company1.duration = "Company 1 duration"
        
        companies = [company1]
    }
}

struct CompanyData: Codable, Identifiable {
    var id = "Company Id"
    var role = "Role"
    var name = "Company Name"
    var location = "Location"
    var duration = "Duration"
    var projects = [ProjectData()]
    
    init() {
        var project1 = ProjectData()
        project1.id = "Project 1"
        project1.title = "Project 1"
        
        var project2 = ProjectData()
        project2.id = "Project 2"
        project2.title = "Project 2"
        
        var project3 = ProjectData()
        project3.id = "Project 3"
        project3.title = "Project 3"
        
        projects = [project1, project2, project3]
    }
}

protocol EducationInstitutionData: Codable {
    var name: String { get set }
    var location: String { get set }
    var duration: String { get set }
    var score: String { get set }
    var degree: String { get set }
}

struct CollegeData: EducationInstitutionData {
    var name: String
    var location: String
    var duration: String
    var score: String
    var degree: String
    
    init() {
        name = "College Name"
        location = "College location"
        duration = "College duration"
        score = "College score"
        degree = "College degree"
    }
}

struct SchoolData: EducationInstitutionData {
    var name: String
    var location: String
    var duration: String
    var score: String
    var degree: String

    init() {
        name = "School Name"
        location = "School location"
        duration = "School duration"
        score = "School score"
        degree = "School degree"
    }
}

struct EducationData: Codable {
    var college = CollegeData()
    var school = SchoolData()
}

struct SkillData: Codable, Identifiable {
    var id: Int
    var skill: String
    var rating: Int
}

struct SkillsData: Codable {
    var skills: [SkillData]
    init() {
        let skill1 = SkillData(id: 0, skill: "Skill Level A, Skill Level A, Skill Level A", rating: 4)
        let skill2 = SkillData(id: 1, skill: "Skill Level B, Skill Level B, Skill Level B", rating: 3)
        let skill3 = SkillData(id: 2, skill: "Skill Level C, Skill Level C, Skill Level C", rating: 3)
        skills = [skill1, skill2, skill3]
    }
}

struct ResumeData: Codable {
    var header: HeaderData
    var aboutMyself: AboutMyselfData
    var companies: CompaniesData
    var education: EducationData
    var skills: SkillsData
    
    static func defaults() -> ResumeData {
        let header = HeaderData()
        let aboutMyself = AboutMyselfData()
        let companies = CompaniesData()
        let education = EducationData()
        let skills = SkillsData()
        let resumeData = ResumeData(header: header, aboutMyself: aboutMyself, companies: companies, education: education, skills: skills)
        return resumeData
    }
    
    static func fromLocalJson() -> ResumeData {
        //**For TESTING purposes only**
//        return defaults()

        
        if let jsonPath = Bundle.main.path(forResource: "sample_data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: jsonPath), options: .alwaysMapped)
//                let dictionary = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as? NSDictionary
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ResumeData.self, from: data)
                print("jsonData:\(jsonData)")
                return jsonData
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        }
        else {
            print("Invalid filename/path.")
        }
            
        
        return defaults()
    }
    
}

//MARK: Others
enum DataType {
    case AboutMe, Phone, Email, Blog, Github, Company, Education, Skills
    
    func fontIconImage(size: CGFloat = 20, color: UIColor = ThemeUIColor) -> UIImage {
        switch self {
        case .AboutMe:
            return IconFont.image(fromIcon: .aboutMe, size: size, color: color)!
        case .Phone:
            return IconFont.image(fromIcon: .mobile, size: size, color: color)!
        case .Email:
            return IconFont.image(fromIcon: .email, size: size, color: color)!
        case .Blog:
            return IconFont.image(fromIcon: .blog, size: size, color: color)!
        case .Github:
            return IconFont.image(fromIcon: .github, size: size, color: color)!
        case .Company:
            return IconFont.image(fromIcon: .company, size: size, color: color)!
        case .Education:
            return IconFont.image(fromIcon: .education, size: size, color: color)!
        case .Skills:
            return IconFont.image(fromIcon: .skills, size: size, color: color)!
        }
    }
    
    func imageBorderWidth() -> CGFloat {
        switch self {
        case .AboutMe:
            return 2.0
        case .Phone:
            return 0.0
        case .Email:
            return 0.0
        case .Blog:
            return 0.0
        case .Github:
            return 0.0
        case .Company:
            return 2.0
        case .Education:
            return 2.0
        case .Skills:
            return 2.0
        }
    }
    
    func topLabelWidth() -> CGFloat {
        if (self == .AboutMe || self == .Skills) {
            return 0.1
        }
        return DIVIDERLABELWIDTH
    }

    func topLabelHeight() -> CGFloat {
        if (self == .AboutMe) {
            return 0.1
        }
        return DIVIDERTOPLABELPADDING
    }
}
