////
////  PlaceTests.swift
////  Assignment2Tests
////
////  Created by Nguyen Quang Huy on 19/5/2022.
////
//
//import XCTest
//@testable import Assignment2
//import CoreData
//
//class PlaceTests: XCTestCase {
//
////    //test getter, setter for each var
////    //test all funcs
////
////    // this gets run before every test case runs
////    override class func setUp() {
////        // wipe the database so that it is empty
////    }
////
////    func test_GettersAndSetters() {
////        let place = Place(
////            name: "Brisbane",
////            location: "Queensland",
////            note: "Brisbane's note",
////            imageURL: "",
////            latitude: 0,
////            longitude: 0
////        )
////        XCTAssertEqual(person.firstName, "Callum") // test the getter of first name
////
////        person.firstName = "Rene"
////        XCTAssertEqual(person.firstName, "Callum") // test the setter of first name
////
////        //do the same with last name
////    }
////
////    func test_canCreatePerson() {
////        let person = Person(firstName: "Callum", lastname: "Mcoll")
////        XCTAssertEqual(person.firstName, "Callum")
////        XCTAssertEqual(person.lastName, "Mcoll")
////    }
////
////    do {
////        let let
////        XCTAssertEqual(<#T##() -> T#>, <#T##() -> T#>)
////    } catch {
////        XCTFail(error?.localizedDescription)
////    }
////
////
////    viewmodel test:
////    func test_canAddNEwItem() {
////        let viewModel = ViewModel(item: [])
////        let count = viewModel.items.count
////        viewModel.add()
////        XCTAssertEqual(count +1, vietModel.items.count)
////    }
//    var context: NSManagedObjectContext!
//    
//    var items: [Person] {
//        let fetchRequest = NSFetchRequest<Person>(entityName: "Person")
//        do {
//            return try context.fetch(fetchRequest)
//        } catch {
//            XCTFail(error.localizedDescription)
//            return []
//        }
//    }
//    
//    override func setUp() {
//        context = PersistenceController().container.viewContext
//        do {
//            for result in items {
//                context.delete(result)
//            }
//            try context.save()
//        } catch {
//            XCTFail(error.localizedDescription)
//        }
//    }
//    
//    func test_addPerson() {
//        do {
//            let person = try Person.add(to: context, firstName: "Callum", lastName: "McColl")
//            let results = items
//            XCTAssertFalse(results.isEmpty)
//            if results.isEmpty {
//                return
//            }
//            XCTAssertEqual(person, results[0])
//        } catch {
//            XCTFail(error.localizedDescription)
//        }
//    }
//    
//    func test_deletePerson() {
//        do {
//            let person = try Person.add(to: context, firstName: "Callum", lastName: "McColl")
//            XCTAssertFalse(items.isEmpty)
//            try person.delete()
//            XCTAssertTrue(items.isEmpty)
//        } catch {
//            XCTFail(error.localizedDescription)
//        }
//    }
//}
