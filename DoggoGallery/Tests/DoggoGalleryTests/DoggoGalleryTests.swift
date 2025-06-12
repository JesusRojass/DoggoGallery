//
//  DoggoGalleryTests.swift
//  DoggoGalleryTests
//
//  Created by Jesus Rojas on 11/06/25.
//

import XCTest
import Combine
@testable import DoggoGallery

final class DoggoGalleryTests: XCTestCase {

    final class MockDogStore: DogStoring {
        var savedDogs: [Dog] = []
        var shouldReturnDogs: [Dog] = []

        func saveDogs(_ dogs: [Dog]) {
            savedDogs = dogs
        }

        func loadDogs() -> [Dog] {
            return shouldReturnDogs
        }

        func clearDogs() {
            savedDogs = []
        }
    }

    final class MockDogFetcher: DogFetching {
        var shouldReturnDogs: [Dog] = []
        var shouldFail = false

        func fetchDogs() -> AnyPublisher<[Dog], Error> {
            if shouldFail {
                return Fail(error: URLError(.badServerResponse))
                    .eraseToAnyPublisher()
            } else {
                return Just(shouldReturnDogs)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
        }
    }

    @MainActor func test_loadData_loadsFromStoreIfAlreadyLoaded() {
        let store = MockDogStore()
        let expected = [Dog(name: "Chief", description: "Test", age: 3, image: "url")]
        store.shouldReturnDogs = expected
        UserDefaults.standard.set(true, forKey: "HasLoadedDogs")

        let sut = DoggoListViewModel(dogFetcher: MockDogFetcher(), dogStore: store)

        XCTAssertEqual(sut.dogs, expected)
    }

    @MainActor func test_loadData_fetchesFromAPIIfNotLoaded() {
        let store = MockDogStore()
        let fetcher = MockDogFetcher()
        let expected = [Dog(name: "Spots", description: "Brave", age: 4, image: "url")]
        fetcher.shouldReturnDogs = expected
        UserDefaults.standard.set(false, forKey: "HasLoadedDogs")

        let expectation = XCTestExpectation(description: "Fetch completes")

        let sut = DoggoListViewModel(dogFetcher: fetcher, dogStore: store)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(sut.dogs, expected)
            XCTAssertEqual(store.savedDogs, expected)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }

    @MainActor func test_refreshData_resetsCacheAndFetchesAgain() async {
        let store = MockDogStore()
        let fetcher = MockDogFetcher()
        fetcher.shouldReturnDogs = [Dog(name: "Boss", description: "Mascot", age: 2, image: "img")]

        let sut = DoggoListViewModel(dogFetcher: fetcher, dogStore: store)

        await sut.refreshData()

        XCTAssertEqual(sut.dogs, fetcher.shouldReturnDogs)
        XCTAssertEqual(store.savedDogs, fetcher.shouldReturnDogs)
        XCTAssertTrue(UserDefaults.standard.bool(forKey: "HasLoadedDogs"))
    }

    @MainActor func test_fetchDogs_handlesFailureGracefully() {
        let fetcher = MockDogFetcher()
        fetcher.shouldFail = true
        let sut = DoggoListViewModel(dogFetcher: fetcher, dogStore: MockDogStore())

        let expectation = XCTestExpectation(description: "Handle error")

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotNil(sut.error)
            XCTAssertEqual(sut.dogs.count, 0)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }
}
