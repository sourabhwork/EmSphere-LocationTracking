//
//  APIError.swift
//  SampleCode
//
//  Created by iarianatech mac-mini on 08/01/18.
//  Copyright © 2018 iAriana Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Alamofire

class APIError: NSObject {
    var errorCode: String
    var errorTitle: String
    var errorDescription: String
    var errorCodeInt:Int?
    override init() {
        errorCode = ""
        errorTitle = ""
        errorDescription = ""
      
        
        super.init()
    }
    
    init(error: NSError) {
        errorCode = ""
        errorTitle = ""
        errorDescription = ""
        errorCodeInt = error.code
        
        if let data = error.userInfo as? Data {
            do {
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as? [String:Any] {
                    if let errors = parsedData["errors"] as? [String:Any]{
                        for key in errors.keys{
                            if let errorArray = errors[key] as? [String]{
                                errorDescription.append(errorArray.joined(separator: "\n"))
                            }
                        }
                    } else if let errors = parsedData["errors"] as? String {
                        errorDescription.append(errors)
                    }
                }
            }
        }
        errorDescription = errorDescription.isEmpty ? error.localizedDescription : errorDescription
    }
}
