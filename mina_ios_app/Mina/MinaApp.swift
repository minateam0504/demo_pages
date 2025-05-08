import SwiftUI

@main
struct MinaApp: App {
    // Initialize the auth manager as a StateObject to be used throughout the app
    @StateObject private var authManager = AuthManager()
    
    init() {
        // Initialize the PostgreSQL client
//        _ = PostgresClient.shared
        
        // Configure app appearance
        configureAppearance()
    }
    
    var body: some Scene {
        WindowGroup {
            WelcomeView()
                .environmentObject(authManager)
        }
    }
    
    private func configureAppearance() {
        // Configure navigation bar appearance
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = UIColor(MinaColors.cream)
        navigationBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor(MinaColors.charcoal),
            .font: UIFont.systemFont(ofSize: 18, weight: .semibold)
        ]
        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        UINavigationBar.appearance().tintColor = UIColor(MinaColors.terracotta)
        
        // Configure tab bar appearance
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(MinaColors.cream)
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        UITabBar.appearance().tintColor = UIColor(MinaColors.terracotta)
    }
}
