//
//  SSOexample.swift
//  SSOExample
//
//  Created by GrupoSti on 16/10/22.
//

import Foundation
import AuthenticationServices
public class AuthSSO {
    var shimController = ShimViewController()
    var scheme=""
    var language=""
    var clientId=""
    var clientSecret=""
    public init() {}

    
    public func signIn(completion: @escaping (String, Error?) -> ()) {
        let authUrlString = "https://auth-test.doters.io/?clientId=\(clientId)&clientSecret=\(clientSecret)&language=\(language)&redirectUri=\(scheme)://login&state=A245FG"
        print(authUrlString)
        guard let url = URL(string: authUrlString) else { return }
        let session = ASWebAuthenticationSession(
            url: url,
            callbackURLScheme: scheme,
            completionHandler: { callback, error in
                guard error == nil, let successURL = callback else { return }
                let access_token = NSURLComponents(string: (successURL.absoluteString))?.queryItems?.filter({ $0.name == "access_token" }).first
                completion("\(String(describing: access_token))",error)
        })
        
        session.presentationContextProvider = shimController // << then reference it here
        
        session.start()
    }
    public func logOut(completion: @escaping (String, Error?) -> ()) {
        let authUrlString = "https://auth-api-gw-test.doters.io/v1/logout?post_logout_redirect_uri=\(scheme)://logout&client_id=\(clientId)"
        print(authUrlString)
        guard let url = URL(string: authUrlString) else { return }
        let session = ASWebAuthenticationSession(
            url: url,
            callbackURLScheme: scheme,
            completionHandler: { callback, error in
                guard error == nil, let successURL = callback else { return }
//                let access_token = NSURLComponents(string: (successURL.absoluteString))?.queryItems?.filter({ $0.name == "access_token" }).first
//                let id_token = NSURLComponents(string: (successURL.absoluteString))?.queryItems?.filter({ $0.name == "id_token" }).first
                completion("\(successURL)",error)
        })
        
        session.presentationContextProvider = shimController // << then reference it here
        
        session.start()
    }
    
}


var globalPresentationAnchor: ASPresentationAnchor? = nil
class ShimViewController: UIViewController, ASWebAuthenticationPresentationContextProviding {
  func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
    return globalPresentationAnchor ?? ASPresentationAnchor()
  }
}
