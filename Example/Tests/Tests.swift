import XCTest
import CKVersion

class Tests: XCTestCase {
    
    func test_version_init() {
        let version = Version.from(string: "1.2.3")
        XCTAssertEqual(version!.major, 1)
        XCTAssertEqual(version!.minor, 2)
        XCTAssertEqual(version!.patch, 3)
    }
    
    func test_version_init_zero() {
        let version = Version.from(string: "0.0.0")
        XCTAssertEqual(version!.major, 0)
        XCTAssertEqual(version!.minor, 0)
        XCTAssertEqual(version!.patch, 0)
    }

    func test_version_init_zero_padding() {
        let version = Version.from(string: "10.02.003")
        XCTAssertEqual(version!.major, 10)
        XCTAssertEqual(version!.minor, 2)
        XCTAssertEqual(version!.patch, 3)
    }
    
    func test_version_fail() {
        let version1 = Version.from(string: "1")
        let version2 = Version.from(string: "1.2")
        let version3 = Version.from(string: "1.2.3.4")
        let version4 = Version.from(string: "a")
        let version5 = Version.from(string: "a.b.c")
        let version6 = Version.from(string: "12.aur.!@")
        XCTAssertNil(version1)
        XCTAssertNil(version2)
        XCTAssertNil(version3)
        XCTAssertNil(version4)
        XCTAssertNil(version5)
        XCTAssertNil(version6)
    }
    
    func test_version_compare() {
        let version1 = Version.from(string: "1.2.3")
        let version2 = Version.from(string: "1.2.3")
        XCTAssertEqual(version1, version2)
    }
    
    func test_version_compare_equal() {
        let version1 = Version.from(string: "1.2.3")
        let version2 = Version.from(string: "01.02.3")
        XCTAssertEqual(version1, version2)
    }

    func test_version_compare_greater() {
        let version1 = Version.from(string: "1.2.3")!
        let version2 = Version.from(string: "1.2.4")!
        XCTAssertTrue(version1 < version2)
        
        let version3 = Version.from(string: "1.3.3")!
        let version4 = Version.from(string: "1.2.3")!
        XCTAssertTrue(version3 > version4)
        
        let version5 = Version.from(string: "2.2.3")!
        let version6 = Version.from(string: "1.2.3")!
        XCTAssertTrue(version5 > version6)
    }
    
    func test_version_to_string() {
        let version = Version.from(2, 10, 1)
        XCTAssertEqual(version?.toString, "2.10.1")
    }
}
