import UIKit

class MainRouter {
    weak var viewController: UIViewController?
}

extension MainRouter: MainRouterProtocol {
}

extension MainRouter {

    static func module() -> UIViewController {
        let router = MainRouter()
        let interactor = MainInteractor()
        let presenter = MainPresenter(delegate: interactor, router: router)

        let viewControllers = [
            walletNavigation,
            transactionsNavigation,
            settingsNavigation
        ]

        let viewController = MainViewController(viewDelegate: presenter, viewControllers: viewControllers)

        interactor.presenter = presenter
        presenter.view = viewController
        router.viewController = viewController

        return viewController
    }

    private static var walletNavigation: UIViewController {
        let navigation = UINavigationController(rootViewController: WalletRouter.module())
        navigation.navigationBar.barStyle = .blackTranslucent
        navigation.navigationBar.tintColor = .cryptoYellow
        navigation.navigationBar.prefersLargeTitles = true
        return navigation
    }

    private static var transactionsNavigation: UIViewController {
        let navigation = UINavigationController(rootViewController: TransactionsRouter.module())
        navigation.navigationBar.barStyle = .blackTranslucent
        navigation.navigationBar.tintColor = .cryptoYellow
        navigation.navigationBar.prefersLargeTitles = true
        return navigation
    }

    private static var settingsNavigation: UIViewController {
        let navigation = UINavigationController(rootViewController: SettingsRouter.module())
        navigation.navigationBar.barStyle = .blackTranslucent
        navigation.navigationBar.tintColor = .cryptoYellow
        navigation.navigationBar.prefersLargeTitles = true
        return navigation
    }

}