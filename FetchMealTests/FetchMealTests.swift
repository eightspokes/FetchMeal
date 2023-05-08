//
//  FetchMealTests.swift
//  FetchMealTests
//
//  Created by Roman on 5/3/23.
//

import XCTest
@testable import FetchMeal

final class FetchMealTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //WE should have some data coming from api
    func test_getting_data_all_success() async{
       let exp = expectation(description: "Get all meals from the API")
       let url = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
       let service = APIService()
        do{
            let data = try await service.fetch(Meal.self, urlString: url)
            exp.fulfill()
        }catch{
            
        }
        wait(for: [exp], timeout: 10)
    }
    
    func test_fetch_data_details_success() async{
       let exp = expectation(description: "Get Detailed Description by id")
       let url = "https://themealdb.com/api/json/v1/1/lookup.php?i="
       let service = APIService()
        do{
            _ = try await service.fetch(Meal.self, urlString: url, id: "53049")
            exp.fulfill()
        }catch{
            
        }
        wait(for: [exp], timeout: 10)
    }
    func test_fetch_meals_success() async{
       let exp = expectation(description: "Get Detailed Description by id")
       let url = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
       let service = APIService()
        do{
            _ = try await service.fetch(Meal.self, urlString: url)
            exp.fulfill()
        }catch{
            
        }
        wait(for: [exp], timeout: 10)
    }
    func test_fetch_meals_shouldBeTwenty() async{
       let exp = expectation(description: "Get all meals, should be 64")
       let url = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
       let service = APIService()
        do{
            let result = try await service.fetch(Meals.self, urlString: url)
            
            XCTAssertEqual(result?.meals.count, 64)
            exp.fulfill()
        }catch{
            
        }
        
        wait(for: [exp], timeout: 10)
    }
    
    func test_fetch_53049_shouldHaveNameApamBalik() async{
       let exp = expectation(description: "Check if meal id = 53049 has name Apam balik")
        let url = "https://themealdb.com/api/json/v1/1/lookup.php?i="
        let service = APIService()
         do{
             let result = try await service.fetch(Meals.self, urlString: url, id: "53049")
             XCTAssertEqual(result!.meals.first?.strMeal, "Apam balik")
             exp.fulfill()
         }catch{
             
         }
         wait(for: [exp], timeout: 10)
    }
    func test_fetch_53049_eggsShouldBeTwo() async{
       let exp = expectation(description: "Check if meal id = 53049 has two eggs in the recipe")
        let url = "https://themealdb.com/api/json/v1/1/lookup.php?i="
        let service = APIService()
         do{
             let result = try await service.fetch(Meals.self, urlString: url, id: "53049")
             XCTAssertEqual(result!.meals.first?.strIngredient3, "2")
             exp.fulfill()
         }catch{
             
         }
         wait(for: [exp], timeout: 10)
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
