import SwiftUI

struct UserListView: View {
    @StateObject private var viewModel = UserListViewModel()
    @FocusState private var isSearchFieldFocused: Bool

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if viewModel.isSearchActive {
                    SearchBar(text: $viewModel.searchText, isActive: $viewModel.isSearchActive, isFocused: _isSearchFieldFocused)
                        .transition(.move(edge: .top))
                }

                List {
                    ForEach(viewModel.sectionLetters, id: \.self) { letter in
                        Section(header: Text(letter)) {
                            ForEach(viewModel.groupedUsers[letter] ?? []) { user in
                                UserRow(user: user)
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Users List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !viewModel.isSearchActive{
                        Button(action: {
                            viewModel.isSearchActive.toggle()
                            if viewModel.isSearchActive {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    isSearchFieldFocused = true
                                }
                            }
                        }) {
                            Image(systemName: "magnifyingglass")
                        }
                    }
                }
            }
            .onChange(of: viewModel.isSearchActive) {
                if !viewModel.isSearchActive {
                    isSearchFieldFocused = false
                }
            }
        }
    }
}

#Preview {
    UserListView()
}
