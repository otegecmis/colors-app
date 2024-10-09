import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        
        configAppearance()
        
        window?.windowScene = windowScene
        window?.rootViewController = MainTabController()
        window?.makeKeyAndVisible()
    }
    
    func configAppearance() {
        UITabBar.appearance().tintColor = .label
        UITabBar.appearance().barTintColor = .white
        
        UINavigationBar.appearance().tintColor = .label
        UINavigationBar.appearance().barTintColor = .label
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.label]
        
        UIBarButtonItem.appearance().tintColor = .label
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}
