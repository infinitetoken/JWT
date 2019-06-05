//
//  JWT.swift
//  JWT
//
//  Created by Aaron Wright on 6/5/19.
//  Copyright © 2019 Infinite Token. All rights reserved.
//

import Foundation

public struct JWT {
    
    public enum Error: String, LocalizedError {
        case decodeError = "JWT | Decode Error"
        
        public var errorDescription: String? {
            return self.rawValue
        }
    }
    
    public struct Token {
        public var header: Header
        public var payload: Payload
        public var signature: String
        
        public init(header: Header, payload: Payload, signature: String) {
            self.header = header
            self.payload = payload
            self.signature = signature
        }
    }
    
    public struct Header {
        public var alg: Alg?
        public var typ: Typ?
        public var cty: Cty?
    }
    
    public struct Payload {
        public var iss: String?
        public var sub: String?
        public var aud: String?
        public var exp: Date?
        public var nbf: Date?
        public var iat: Date?
        public var jti: String?
        
        public var claims: [String : Any] = [:]
        
        public init() {}
    }
    
    public enum Typ: String {
        case JWT = "JWT"
    }
    
    public enum Cty: String {
        case JWT = "JWT"
    }
    
    public enum Alg: String {
        case HS256 = "HS256"
        case HS384 = "HS384"
        case HS512 = "HS512"
        case RS256 = "RS256"
        case RS384 = "RS384"
        case RS512 = "RS512"
        case ES256 = "ES256"
        case ES384 = "ES384"
        case ES512 = "ES512"
        case PS256 = "PS256"
        case PS384 = "PS384"
        case PS512 = "PS512"
        case none = "none"
    }
    
    // MARK: - Methods
    
    public static func decode(token: String) throws -> Token {
        let parts = token.components(separatedBy: ".")
        
        let header = try self.decodeHeader(header: parts[0])
        let payload = try self.decodePayload(payload: parts[1])
        let signature = parts[2]
        
        return Token(header: header, payload: payload, signature: signature)
    }
    
    // MARK: - Helpers
    
    private static func decodeHeader(header: String) throws -> Header {
        guard let data = Data(base64Encoded: self.padBase64String(header), options: [.ignoreUnknownCharacters]) else { throw Error.decodeError }
        guard let decoded = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else { throw Error.decodeError }
        
        var header = Header()
        
        if let algValue = decoded["alg"] as? String, let alg = Alg(rawValue: algValue) {
            header.alg = alg
        }
        if let typValue = decoded["typ"] as? String, let typ = Typ(rawValue: typValue) {
            header.typ = typ
        }
        if let ctyValue = decoded["cty"] as? String, let cty = Cty(rawValue: ctyValue) {
            header.cty = cty
        }
        
        return header
    }
    
    private static func decodePayload(payload: String) throws -> Payload {
        guard let data = Data(base64Encoded: self.padBase64String(payload), options: [.ignoreUnknownCharacters]) else { throw Error.decodeError }
        guard let decoded = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else { throw Error.decodeError }
        
        var payload = Payload()
        
        if let iss = decoded["iss"] as? String {
            payload.iss = iss
        }
        if let sub = decoded["sub"] as? String {
            payload.sub = sub
        }
        if let aud = decoded["aud"] as? String {
            payload.aud = aud
        }
        if let exp = decoded["exp"] as? Int {
            payload.exp = Date(timeIntervalSince1970: TimeInterval(exp))
        }
        if let nbf = decoded["nbf"] as? Int {
            payload.nbf = Date(timeIntervalSince1970: TimeInterval(nbf))
        }
        if let iat = decoded["iat"] as? Int {
            payload.iat = Date(timeIntervalSince1970: TimeInterval(iat))
        }
        if let jti = decoded["jti"] as? String {
            payload.jti = jti
        }
        
        payload.claims = decoded.filter({ (key, value) -> Bool in
            return !["iss", "sub", "aud", "exp", "nbf", "iat", "jti"].contains(key)
        })
        
        return payload
    }
    
    private static func padBase64String(_ base64String: String) -> String {
        var result = base64String
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        let length = Double(result.lengthOfBytes(using: String.Encoding.utf8))
        let requiredLength = 4 * ceil(length / 4.0)
        let paddingLength = requiredLength - length
        
        if paddingLength > 0 {
            let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
            result += padding
        }
        
        return result
    }
    
}
