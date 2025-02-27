import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @Binding var isActive: Bool
    @FocusState var isFocused: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.leading, 8)
                    
                    TextField("Search", text: $text)
                        .padding(.vertical, 8)
                        .focused($isFocused)
                    
                    if !text.isEmpty {
                        Button(action: { text = "" }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                        .padding(.trailing, 8)
                    }
                }
                .background(Color(.systemGray6))
                .cornerRadius(10)
                
                if isActive {
                    Button("Cancel") {
                        isActive = false
                        text = ""
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            
            Divider()
        }
        .background(Color(.systemBackground))
    }
}

#Preview {
    ContentView()
}
