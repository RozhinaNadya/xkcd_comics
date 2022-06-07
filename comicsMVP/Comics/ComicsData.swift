//
//  ComicsData.swift
//  comicsMVP
//
//  Created by Надежда on 2022-06-02.
//

import Foundation
import UIKit

public final class ComicsData: Codable {
    public var month: String
    public var num: Int
    public var link: String
    public var year: String
    public var news: String
    public var safe_title: String
    public var transcript: String
    public var alt: String
    public var img: String
    public var title: String
    public var day: String
    
    public init(month: String, num: Int, link: String, year: String, news: String, safe_title: String, transcript: String, alt: String, img: String, title: String, day: String) {
        self.month = month
        self.num = num
        self.link = link
        self.year = year
        self.news = news
        self.safe_title = safe_title
        self.transcript = transcript
        self.alt = alt
        self.img = img
        self.title = title
        self.day = day
    }
}

extension ComicsData: Equatable {
    
    public static func == (lhs: ComicsData, rhs: ComicsData) -> Bool {
        lhs.month == rhs.month &&
        lhs.num == rhs.num &&
        lhs.link == rhs.link &&
        lhs.year == rhs.year &&
        lhs.news == rhs.news &&
        lhs.safe_title == rhs.safe_title &&
        lhs.transcript == rhs.transcript &&
        lhs.alt == rhs.alt &&
        lhs.img == rhs.img &&
        lhs.title == rhs.title &&
        lhs.day == rhs.day
    }
}

public final class ComicsStore {
    
    public static let shared: ComicsStore = .init()
    
    private lazy var encoder: JSONEncoder = .init()
    
    private lazy var decoder: JSONDecoder = .init()
    
    private lazy var userDefaults: UserDefaults = .standard
    
    public var comics: [ComicsData] = [] {
        didSet {
            save()
        }
    }
    
    public func save() {
        do {
            let data = try encoder.encode(comics)
            userDefaults.setValue(data, forKey: "comics")
        }
        catch {
            print("Error encoding comics to save", error)
        }
    }
    
    private init() {

        guard let data = userDefaults.data(forKey: "comics") else {
            return
        }
        do {
            comics = try decoder.decode([ComicsData].self, from: data)
        }
        catch {
            print("Stored comics Decoding Error", error)
        }
    }
}
