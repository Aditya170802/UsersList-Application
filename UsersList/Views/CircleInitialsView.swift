import SwiftUI

struct CircleInitialsView: View {
    let name: String
    
    private var initials: String { String(name.prefix(1).uppercased()) }
    private var backgroundColor: Color {
        let colors: [Color] = [.blue, .green, .purple, .orange, .pink, .red]
        let nameValue = name.utf8.reduce(0) { $0 + Int($1) }
        return colors[nameValue % colors.count]
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(backgroundColor)
                .frame(width: 40, height: 40)
            
            Text(initials)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
        }
    }
}
#Preview {
    CircleInitialsView(name: "Aditya")
}
