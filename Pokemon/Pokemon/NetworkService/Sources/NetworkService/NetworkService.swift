// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

public protocol NetworkServiceable {
    func fetch<T>(
        request: Request<T>
    ) async throws -> T
}

public protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol { }

open class NetworkService: NetworkServiceable {
    private let session: URLSessionProtocol
    private let decoder: JSONDecoder
    
    public init(
        session: URLSessionProtocol = URLSession.shared,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.session = session
        self.decoder = decoder
    }
    
    public func fetch<T>(
        request: Request<T>
    ) async throws -> T where T : Decodable {
        do {
            let (
                data,
                response
            ) = try await session.data(
                for: request.request
            )
            
            guard let response = response as? HTTPURLResponse else {
                throw RequestError.invalidURL
            }
            
            switch response.statusCode {
            case 200...299: break
            case 300...399: throw RequestError.redirection
            case 400...499: throw RequestError.clientError
            case 500...599: throw RequestError.serverError
            default: throw RequestError.unExpectedStatusCode
            }
            
            guard let decodedResponse = try? decoder.decode(
                request.responseType,
                from: data
            ) else {
                if data.isEmpty {
                    return String() as! T
                }
                throw RequestError.decode
            }
            
            return decodedResponse
        } catch {
            if let error = error as? RequestError {
                throw error
            }
            
            let error = error as NSError
            if error.domain == NSURLErrorDomain,
                error.code == NSURLErrorNotConnectedToInternet {
                throw RequestError.noNetwork
            } else {
                throw RequestError.unKnown
            }
        }
    }
}
