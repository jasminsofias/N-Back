import SwiftUI
import Foundation

class NB: ObservableObject{
    @Published var count = 20
    @Published var time = 0.5
    @Published var visual = true
    @Published var audio = false
}
