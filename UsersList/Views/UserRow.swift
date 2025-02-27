import SwiftUI

struct UserRow: View {
    let user: User
    
    var body: some View {
        HStack(spacing: 16) {
            CircleInitialsView(name: user.firstName)
            Text(user.fullName)
        }
        .padding(.vertical, 4)
    }
}

