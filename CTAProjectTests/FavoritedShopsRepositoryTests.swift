//
//  FavoritedShopsRepositoryTests.swift
//  CTAProjectTests
//
//  Created by Tomoya Tanaka on 2022/03/25.
//

@testable import CTAProject
@testable import RealmSwift
@testable import RxRelay
@testable import RxSwift
@testable import RxTest
import XCTest

class FavoritedShopsRepositoryTests: XCTestCase {

    override func setUp() {
        super.setUp()
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    }

    func test_checkIfShopFavoritedSuccess() throws {
        let dependency = Dependency(withInitialData: true)
        let result = dependency.testTarget.checkIfShopFavorited(dependency.favoriteShop.id)
        XCTAssertEqual(result, true)
    }

    func test_checkIfShopFavoritedFailure() throws {
        let dependency = Dependency(withInitialData: false)
        let result = dependency.testTarget.checkIfShopFavorited("notFoundID")
        XCTAssertEqual(result, false)
    }

    func test_addFavoriteShopSuccess() throws {
        let dependency = Dependency(withInitialData: false)
        let addFavoriteShop = WatchStream(dependency.testTarget.addFavoriteShop(dependency.favoriteShop).asObservable())
        XCTAssertEqual(addFavoriteShop.result.first??.id, dependency.favoriteShop.id)
    }

    func test_addFavoriteShopFailure() throws {
        let dependency = Dependency(withInitialData: true)
        let addFavoriteShop = WatchStream(dependency.testTarget.addFavoriteShop(dependency.favoriteShop).asObservable())
        XCTAssertEqual(addFavoriteShop.errors.first??.localizedDescription, RealmError.idIsAlreadyTaken.localizedDescription)
    }

    func test_removeFavoriteShopSuccess() throws {
        let dependency = Dependency(withInitialData: true)
        let removeFavoriteShop = WatchStream(dependency.testTarget.removeFavoriteShop(dependency.favoriteShop.id).asObservable())
        XCTAssertEqual(removeFavoriteShop.result.count, 2)
    }

    func test_removeFavoriteShopFailure() throws {
        let dependency = Dependency(withInitialData: false)
        let removeFavoriteShop = WatchStream(dependency.testTarget.removeFavoriteShop(dependency.favoriteShop.id).asObservable())
        XCTAssertEqual(removeFavoriteShop.errors.first??.localizedDescription, RealmError.objectIsNotFound.localizedDescription)
    }
}

extension FavoritedShopsRepositoryTests {
    struct Dependency {
        let realm: Realm
        let testScheduler: TestScheduler
        let testTarget: FavoritedShopsRepository
        let favoriteShop: FavoriteShop

        init(withInitialData: Bool) {
            realm = try! Realm()
            testScheduler = TestScheduler(initialClock: 0)
            testTarget = FavoritedShopsRepository(realm: realm)
            favoriteShop = FavoriteShop.exampleInstance
            if withInitialData {
                addExampleData()
            }
        }

        private func addExampleData() {
            try! realm.write {
                realm.create(FavoriteShop.self, value: FavoriteShop.exampleInstance, update: .modified)
            }
        }
    }
}
