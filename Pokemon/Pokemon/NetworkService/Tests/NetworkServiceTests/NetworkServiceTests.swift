import XCTest
@testable import NetworkService

final class NetworkServiceTests: XCTestCase {

    func testHTTPMethodString() {
        ///Assert
        XCTAssertEqual(HTTPMethod.get.string, "get")
    }
    
    func testRequestInitialization() {
        ///Arrange
        let url = URL(string: "https://example.com")!
        
        ///Act
        let request = Request<String>(url: url, httpMethod: .get)
        
        ///Assert
        XCTAssertEqual(request.request.url, url)
        XCTAssertEqual(request.request.httpMethod, "GET")
        XCTAssert(request.responseType == String.self)
    }
    
    func testFetchSuccess() async throws {
        ///Arrange
        let session = URLSessionMock()
        session.nextData = "{\"key\":\"value\"}".data(using: .utf8)
        session.nextResponse = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        let service = NetworkService(session: session)
        let request = Request<[String: String]>(url: URL(string: "https://example.com")!, httpMethod: .get)
        
        ///Act
        let result = try await service.fetch(request: request)
        
        ///Assert
        XCTAssertEqual(result["key"], "value")
    }
    
    func testFetchStatusCodes() async throws {
        ///Arrange
        let session = URLSessionMock()
        let statusCodesAndErrors: [(Int, RequestError)] = [
            (301, .redirection),
            (401, .clientError),
            (501, .serverError),
            (600, .unExpectedStatusCode)
        ]
        
        for (statusCode, expectedError) in statusCodesAndErrors {
            session.nextResponse = HTTPURLResponse(
                url: URL(string: "https://example.com")!,
                statusCode: statusCode,
                httpVersion: nil,
                headerFields: nil
            )
            
            let service = NetworkService(session: session)
            let request = Request<String>(url: URL(string: "https://example.com")!, httpMethod: .get)
            
            do {
                ///Act
                _ = try await service.fetch(request: request)
                XCTFail("Expected to throw \(expectedError), but did not throw.")
            } catch let error as RequestError {
                ///Assert
                XCTAssertEqual(error, expectedError)
            }
        }
    }
    
    func testFetchDecodeError() async throws {
        ///Arrange
        let session = URLSessionMock()
        session.nextData = "invalid json".data(using: .utf8)
        session.nextResponse = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        let service = NetworkService(session: session)
        let request = Request<String>(url: URL(string: "https://example.com")!, httpMethod: .get)
        
        do {
            ///Act
            _ = try await service.fetch(request: request)
            XCTFail("Expected to throw decode error, but did not throw.")
        } catch let error as RequestError {
            ///Assert
            XCTAssertEqual(error, .decode)
        }
    }
    
    func testFetchNoNetworkError() async throws {
        ///Arrange
        let session = URLSessionMock()
        session.nextError = NSError(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet, userInfo: nil)
        let service = NetworkService(session: session)
        let request = Request<String>(url: URL(string: "https://example.com")!, httpMethod: .get)
        
        do {
            ///Act
            _ = try await service.fetch(request: request)
            XCTFail("Expected to throw noNetwork error, but did not throw.")
        } catch let error as RequestError {
            ///Assert
            XCTAssertEqual(error, .noNetwork)
        }
    }
    
    func testFetchUnknownError() async throws {
        ///Arrange
        let session = URLSessionMock()
        session.nextError = NSError(domain: NSCocoaErrorDomain, code: NSFeatureUnsupportedError, userInfo: nil)
        
        let service = NetworkService(session: session)
        let request = Request<String>(url: URL(string: "https://example.com")!, httpMethod: .get)
        
        do {
            ///Act
            _ = try await service.fetch(request: request)
            XCTFail("Expected to throw unKnown error, but did not throw.")
        } catch let error as RequestError {
            ///Assert
            XCTAssertEqual(error, .unKnown)
        }
    }
    
    func testFetchInvalidURLResponse() async throws {
        ///Arrange
        let session = URLSessionMock()
        session.nextResponse = URLResponse( // This is not an HTTPURLResponse
            url: URL(string: "https://example.com")!,
            mimeType: nil,
            expectedContentLength: 0,
            textEncodingName: nil
        )
        
        let service = NetworkService(session: session)
        let request = Request<String>(url: URL(string: "https://example.com")!, httpMethod: .get)
        
        do {
            ///Act
            _ = try await service.fetch(request: request)
            XCTFail("Expected to throw invalidURL error, but did not throw.")
        } catch let error as RequestError {
            ///Assert
            XCTAssertEqual(error, .invalidURL)
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
    }
    
    func testFetchEmptyData() async throws {
        ///Arrange
        let session = URLSessionMock()
        session.nextData = Data()
        session.nextResponse = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        let service = NetworkService(session: session)
        let request = Request<String>(url: URL(string: "https://example.com")!, httpMethod: .get)
        
        ///Act
        let result = try await service.fetch(request: request)
        
        ///Assert
        XCTAssertEqual(result, "")
    }
}
