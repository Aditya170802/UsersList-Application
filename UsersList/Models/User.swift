import Foundation

struct User: Identifiable, Codable {
    let id: Int
    let firstName: String
    let lastName: String
    
    var fullName: String { "\(firstName) \(lastName)" }
    var firstLetter: String { String(firstName.prefix(1).uppercased()) }
}

struct UsersResponse: Codable {
    let users: [User]
}
