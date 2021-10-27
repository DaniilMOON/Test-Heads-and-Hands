// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import UIKit

enum VCFactory {
    static func buildAuthVC() -> UIViewController? {
        let vc = StoryboardScene.Auth.initialScene.instantiate()
        let authService = CoreFactory.buildAuthService()
        let snacker = CoreFactory.snacker
        vc.setup(with: authService, snacker)
        return vc
    }

    static func buildProductVC(with product: Product) -> UIViewController {
        let vc = ProductVC()
        let snacker = CoreFactory.snacker
        let catalogService = CoreFactory.buildCatalogService()
        vc.setup(with: catalogService, product, snacker)
        return vc
    }

    static func buildOrderFormVC(with product: Product) -> UIViewController {
        let vc = OrderFormVC()
        let snacker = CoreFactory.snacker
        vc.setup(with: product, snacker)
        return vc
    }

    static func buildTabBarVC() -> UIViewController? {
        let tabBarVC = StoryboardScene.TabBar.initialScene.instantiate()
        tabBarVC.viewControllers?.forEach { vc in
            guard let nvc = vc as? UINavigationController, let rootVC = nvc.viewControllers.first else {
                return
            }
            switch rootVC {
            case let vc as ProfileVC:
                vc.dataService = CoreFactory.dataService
            case let vc as HistoryVC:
                let historyService = CoreFactory.buildHistoryService()
                let snacker = CoreFactory.snacker
                vc.setup(with: historyService, snacker)
            case let vc as CatalogVC:
                let catalogService = CoreFactory.buildCatalogService()
                let snacker = CoreFactory.snacker
                vc.setup(with: catalogService, snacker)
            default:
                break
            }
        }
        return tabBarVC
    }
}
