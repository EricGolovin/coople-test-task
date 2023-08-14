//
//  JobData.swift
//  coople-test-task
//
//  Created by Eric Golovin on 14/08/2023.
//

import Foundation

public struct JobList: Codable {

    public struct Item: Codable, Hashable {
        public let workAssignmentID, waReadableID: String
        public let hourlyWage, salary: HourlyWage
        public let jobSkill: JobSkill
        public let workAssignmentName: String
        public let jobLocation: JobLocation
        public let periodFrom, datePublished: Int
        public let branchLink: String

        enum CodingKeys: String, CodingKey {
            case workAssignmentID = "workAssignmentId"
            case waReadableID = "waReadableId"
            case hourlyWage, salary, jobSkill, workAssignmentName, jobLocation, periodFrom, datePublished, branchLink
        }
    }

    public struct HourlyWage: Codable, Hashable {
        public let amount: Double
        public let currencyID: Int

        enum CodingKeys: String, CodingKey {
            case amount
            case currencyID = "currencyId"
        }
    }

    public struct JobLocation: Codable, Hashable {
        public let addressStreet, extraAddress, zip, city: String
        public let countryID: Int

        enum CodingKeys: String, CodingKey {
            case addressStreet, extraAddress, zip, city
            case countryID = "countryId"
        }
    }

    public struct JobSkill: Codable, Hashable {
        let jobProfileID: Int
        let educationalLevelID: Int?

        enum CodingKeys: String, CodingKey {
            case jobProfileID = "jobProfileId"
            case educationalLevelID = "educationalLevelId"
        }
    }

    public let items: [Item]
    public let total: Int
}
