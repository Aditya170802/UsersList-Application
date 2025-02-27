import Foundation
import SwiftUI

class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var filteredUsers: [User] = []
    @Published var searchText = "" {
        didSet { filterUsers() }
    }
    @Published var isSearchActive = false
    
    var groupedUsers: [String: [User]] {
        Dictionary(grouping: filteredUsers) { $0.firstLetter }
    }
    
    var sectionLetters: [String] { groupedUsers.keys.sorted() }
    
    init() {
        loadCachedUsers()
        fetchUsers()
    }
    
    func fetchUsers() {
        guard let url = URL(string: "https://dummyjson.com/users") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Error fetching users: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received.")
                return
            }
            
            do {
                let usersResponse = try JSONDecoder().decode(UsersResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.users = usersResponse.users
                    self?.filteredUsers = usersResponse.users
                    self?.cacheUsers(usersResponse.users)
                }
            } catch {
                print("Failed to decode JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    private func cacheUsers(_ users: [User]) {
        if let data = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(data, forKey: "cachedUsers")
        }
    }
    
    private func loadCachedUsers() {
        if let data = UserDefaults.standard.data(forKey: "cachedUsers"),
           let cachedUsers = try? JSONDecoder().decode([User].self, from: data) {
            self.users = cachedUsers
            self.filteredUsers = cachedUsers
        }
    }
    
    private func filterUsers() {
        if searchText.isEmpty {
            filteredUsers = users
        } else {
            filteredUsers = users.filter { $0.fullName.lowercased().contains(searchText.lowercased()) }
        }
    }
}

