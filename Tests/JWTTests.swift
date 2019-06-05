//
//  JWTTests.swift
//  JWTTests
//
//  Created by Aaron Wright on 6/5/19.
//  Copyright © 2019 Infinite Token. All rights reserved.
//

import XCTest
@testable import JWT

class JWTTests: XCTestCase {

    func testCanDecode() {
        let tokenString = """
        eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImN0eSI6IkpXVCJ9.eyJpc3MiOiJFeGFtcGxlIiwic3ViIjoiMTIzNDU2Nzg5MCIsImF1ZCI6IkV4YW1wbGUiLCJuYW1lIjoiSm9obiBEb2UiLCJleHAiOjE1MTYyMzkwMjIsImlhdCI6MTUxNjIzOTAyMiwibmJmIjoxNTE2MjM5MDIyLCJqdGkiOiIxIn0.qg7XpG3ir8PdFbY0MKBBIyYBV6sKiQolMJjJyU2PMjQ
        """
        
        do {
            let token = try JWT.decode(token: tokenString)
            
            XCTAssertEqual(token.header.alg, JWT.Alg.HS256)
            XCTAssertEqual(token.header.typ, JWT.Typ.JWT)
            XCTAssertEqual(token.header.cty, JWT.Cty.JWT)
            
            XCTAssertEqual(token.payload.iss, "Example")
            XCTAssertEqual(token.payload.sub, "1234567890")
            XCTAssertEqual(token.payload.aud, "Example")
            XCTAssertEqual(token.payload.exp, Date(timeIntervalSince1970: TimeInterval(1516239022)))
            XCTAssertEqual(token.payload.nbf, Date(timeIntervalSince1970: TimeInterval(1516239022)))
            XCTAssertEqual(token.payload.iat, Date(timeIntervalSince1970: TimeInterval(1516239022)))
            XCTAssertEqual(token.payload.jti, "1")
            
            XCTAssertEqual(token.payload.claims["name"] as? String, "John Doe")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testThrowsErrorOnDecode() {
        let badString = """
        eyJhbGcoOiJIUzI1NiIsInR5cCI6IkpXVCJ8.2133.235
        """
        
        XCTAssertThrowsError(try JWT.decode(token: badString))
    }
    
    func testErrorDescription() {
        let error = JWT.Error.decodeError
        
        XCTAssertEqual(error.localizedDescription, error.rawValue)
    }
    
}
