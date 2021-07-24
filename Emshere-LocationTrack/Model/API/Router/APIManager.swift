//
//  ApiManager.swift
//  SampleCode
//
//  Created by iarianatech mac-mini on 26/12/17.
//  Copyright © 2017 iAriana Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
//import Reachability


// Internet Reachablity Test
class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

// no network error obj.
var internetError: APIError {
    let error = APIError()
    error.errorCode = "\(3060)"
    error.errorTitle = "Network error"
    error.errorDescription = "Unable to connect, please check your internet connectivity."
    return error
}

class APIManager {
    
    // registration api
    // class func loginWithUrl(param: Dictionary<String, Any>,url: String, completion: @escaping (Bool,
    class func register(param: Dictionary<String, Any>,url: String, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(url, method: .post, parameters:param  ,encoding: URLEncoding.default, headers: nil).responseJSON{ response in
            switch response.result {
            case .success(let value):
                completion(true,value as? NSDictionary, nil)
            //break
            case .failure(let encodedError):
                print(encodedError)
                let error = APIError(error: encodedError as NSError)
                completion(false,nil,error)
                //break
            }
        }
        /*
         Alamofire.request(LicenseRouter.register(param))
         .responseJSON { response in
         switch response.result {
         case .success(let value):
         completion(true,value as? NSDictionary, nil)
         //break
         case .failure(let encodedError):
         print(encodedError)
         let error = APIError(error: encodedError as NSError)
         completion(false,nil,error)
         //break
         }
         }*/
    }
    
    // verifyLicenseNumber api
    class func verifyLicenseNumber(param: Dictionary<String, Any>,url: String, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(url, method: .post, parameters:param  ,encoding: URLEncoding.default, headers: nil).responseJSON{ response in
            switch response.result {
            case .success(let value):
                completion(true,value as? NSDictionary, nil)
            //break
            case .failure(let encodedError):
                print(encodedError)
                let error = APIError(error: encodedError as NSError)
                completion(false,nil,error)
                //break
            }
        }
        /*
         Alamofire.request(LicenseRouter.verifyLicenseNumber(param))
         .responseJSON { response in
         switch response.result {
         case .success(let value):
         completion(true,value as? NSDictionary, nil)
         //break
         case .failure(let encodedError):
         print(encodedError)
         let error = APIError(error: encodedError as NSError)
         completion(false,nil,error)
         //break
         }
         }*/
        
    }
    
    
    // login api
    class func login(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        
        print("Login Parameter = ",param)
        
        Alamofire.request(LoginRouter.login(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    print( "Alomofire result = ", response.result.value!)
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print("login error",encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
        
    }
    
    // logout api
    class func logout(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        
        Alamofire.request(GeneralRouter.logout(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    // leave application api
    class func leaveApplication(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        
        Alamofire.request(GeneralRouter.leaveApplication(param))
            .responseJSON { response in
                print("response in leave appn = \(response)")
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    // changed by dhiraj 16-05-18
    
    // getNoOfLeaveDays api
    class func getNoOfLeaveDays(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        
        Alamofire.request(GeneralRouter.getNoOfLeaveDays(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    // getLeaveApplicationForApproval api
    class func getLeaveApplicationForApproval(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        
        Alamofire.request(GeneralRouter.getLeaveApplicationForApproval(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    // getReasonsAccordingToLeaveType api
    class func getReasonsAccordingToLeaveType(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        
        Alamofire.request(GeneralRouter.getReasonsAccordingToLeaveType(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    //http://192.168.1.27/Enterprise_MobileApp/app/Api/EmployeeApp/GetLeavePolicyDetail
    
    // GetLeavePolicyDetail api
    class func getLeavePolicyDetail(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        
        Alamofire.request(GeneralRouter.getLeavePolicyDetail(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    // getDayStatusForAMonthCalender api
    class func getDayStatusForAMonthCalender(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        
        Alamofire.request(GeneralRouter.getDayStatusForAMonthCalender(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    // GetAttendanceDetails
    class func getAttendanceDetails(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        
        Alamofire.request(GeneralRouter.getAttendanceDetails(param))
            .responseJSON { response in
                print("getAttendanceDetails response=",response)
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    
    // GetEmployeeHoursWeekWise
    class func getEmployeeHoursWeekWise(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        
        Alamofire.request(GeneralRouter.getEmployeeHoursWeekWise(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    // GetLeaveTypeByEmployeeId
    class func getLeaveTypeByEmployeeId(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        
        Alamofire.request(GeneralRouter.getLeaveTypeByEmployeeId(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    
    // GetLeaveBalance
    class func getLeaveBalance(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        
        Alamofire.request(GeneralRouter.getLeaveBalance(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    // Approval flow for leave appln
    class func getWorkFlowForLeaveApp(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter of approval flow=",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        
        Alamofire.request(GeneralRouter.getWorkFlowForLeaveApp(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    //
    class func getLeaveApplicationList(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter of approval flow=",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(GeneralRouter.getLeaveApplicationList(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    
    // Upaloding Image with normal method with Mark Attedance -> working
    class func uploadImageForMarkAttendanceData(param: Dictionary<String, Any>,url: String, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter Mark Attedance = \(param) \n url = \(url))")
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(url, method: .post, parameters:param  ,encoding: URLEncoding.default, headers: nil).responseJSON{ response in
            switch response.result {
            case .success(let value):
                completion(true,value as? NSDictionary, nil)
                //break
                
            case .failure(let encodedError):
                print(encodedError)
                let error = APIError(error: encodedError as NSError)
                completion(false,nil,error)
                //break
            }
        }
    }
    
    
    //  getRealInOutDateTimeForShiftDate
    class func getRealInOutDateTimeForShiftDate(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter RealInOutDateTimeForShiftDate =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(GeneralRouter.getRealInOutDateTimeForShiftDate(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    // getShiftForRegularizeApplication
    class func getShiftForRegularizeApplication(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter ShiftForRegularizeApplication =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(GeneralRouter.getShiftForRegularizeApplication(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    // getReasonsForRegularizationApp
    class func getReasonsForRegularizationApp(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter ReasonsForRegularizationApp  =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(GeneralRouter.getReasonsForRegularizationApp(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    //GetWorkFlowForRegularization
    class func getWorkFlowForRegularization(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter GetWorkFlowForRegularization  =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(GeneralRouter.getWorkFlowForRegularizationApp(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    // applyRegularizationApp
    class func applyRegularizationApp(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter ApplyRegularizationApp =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(GeneralRouter.applyRegularizationApp(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    
    // getApplicationCount or pending appln count
    class func getApplicationCount(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter getApplicationCount =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(GeneralRouter.getApplicationCount(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    // GetRegularizationApplicationList
    class func getRegularizationApplicationList(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter getRegularizationApplicationList =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(GeneralRouter.getRegularizationApplicationList(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    // GetWorkFlowForCompensatoryOffApp
    class func getWorkFlowForCompensatoryOffApp(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter getWorkFlowForCompensatoryOffApp =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(GeneralRouter.getWorkFlowForCompensatoryOffApp(param))
            .responseJSON { response in
                print("getWorkFlowForCompensatoryOffApp response = \(response)")
                switch response.result {
                    
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    // GetReasonsForCompensatoryOffApp
    class func getReasonsForCompensatoryOffApp(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter getReasonsForCompensatoryOffApp =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(GeneralRouter.getReasonsForCompensatoryOffApp(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    // GetCompensatoryOffApplicationForApproval
    
    class func getCompensatoryOffApplicationForApproval(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter GetCompensatoryOffApplicationForApproval =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(GeneralRouter.getCompensatoryOffApplicationForApproval(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    // GetEmployeeCompOffDetail
    class func getEmployeeCompOffDetail(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter LeaveApplicationForApproval =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(GeneralRouter.getEmployeeCompOffDetail(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    // GetCompensatoryOffApplicationList
    
    class func getCompensatoryOffApplicationList(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter LeaveApplicationForApproval =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(GeneralRouter.getCompensatoryOffApplicationList(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    // ApplyCompensatoryOffApp
    
    class func applyCompensatoryOffApp(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter LeaveApplicationForApproval =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(GeneralRouter.applyCompensatoryOffApp(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    //  GetCompOffAgainstDetails
    
    class func getCompOffAgainstDetails(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter LeaveApplicationForApproval =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(GeneralRouter.getCompOffAgainstDetails(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    // GetDateTimeDifferenceInHoursMinForMultipleDays
    
    class func getDateTimeDifferenceInHoursMinForMultipleDays(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter  GetDateTimeDifferenceInHoursMinForMultipleDays =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(GeneralRouter.getDateTimeDifferenceInHoursMinForMultipleDays(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    ///// Out Duty   ///////
    
    // GetOutDutyApplicationList
    
    class func getOutDutyApplicationList(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter GetOutDutyApplicationList =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(GeneralRouter.getOutDutyApplicationList(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    /////////////
    
    // GetNoOfOutDutyAppDay
    
    class func getNoOfOutDutyAppDays(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter GetNoOfOutDutyAppDay =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(GeneralRouter.getNoOfOutDutyAppDays(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    // ApplyOutDutyApp
    class func applyOutDutyApp(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter applyOutDutyApp =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(GeneralRouter.applyOutDutyApp(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    // GetOutDutyApplicationForApproval
    class func getOutDutyApplicationForApproval(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter getOutDutyApplicationForApproval =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(GeneralRouter.getOutDutyApplicationForApproval(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    // GetWorkFlowForOutDutyApp
    class func getWorkFlowForOutDutyApp(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter GetWorkFlowForOutDutyApp =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(GeneralRouter.getWorkFlowForOutDutyApp(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    // GetReasonsForOutDutyApp
    class func getReasonsForOutDutyApp(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter GetReasonsForOutDutyApp =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(GeneralRouter.getReasonsForOutDutyApp(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    
    ///////////  Work from Home ///////
    
    // GetWorkFromHomeApplicationList
    class func getWorkFromHomeApplicationList(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter GetWorkFromHomeApplicationList =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(GeneralRouter.getWorkFromHomeApplicationList(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    // GetReasonsForWorkFromHomeApp
    class func getReasonsForWorkFromHomeApp(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter GetReasonsForWorkFromHomeApp =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(GeneralRouter.getReasonsForWorkFromHomeApp(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    // GetNoOfWorkFromHomeDays
    class func getNoOfWorkFromHomeDays(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter GetNoOfWorkFromHomeDays =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(GeneralRouter.getNoOfWorkFromHomeDays(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    // ApplyWorkFromHomeApp
    class func applyWorkFromHomeApp(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter ApplyWorkFromHomeApp =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(GeneralRouter.applyWorkFromHomeApp(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    // GetWorkFromHomeApplicationForApproval
    class func getWorkFromHomeApplicationForApproval(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter GetWorkFromHomeApplicationForApproval =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(GeneralRouter.getWorkFromHomeApplicationForApproval(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    // GetWorkFlowForWorkFromHomeAppt
    class func getWorkFlowForWorkFromHomeApp(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter GetWorkFlowForWorkFromHomeApp =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(GeneralRouter.getWorkFlowForWorkFromHomeApp(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    // Drawer tab features
    
    // GetDiscrepanciesDetailList
    class func getDiscrepanciesDetailList(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter GetDiscrepanciesDetailList =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(GeneralRouter.getDiscrepanciesDetailList(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    
    // GetMobileApplicationConfiguration
    
    class func getMobileApplicationConfiguration(completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        
        //let url = UserProfile.getServiceURL()! + "/EmployeeApp/" + "GetMobileApplicationConfiguration"
        
        let url = UserProfile.getServiceURL()! + Const.appUrl.employeeApp + "GetMobileApplicationConfiguration"
        Alamofire.request(url, method: .post).responseJSON{ response in
            
            switch response.result {
            case .success(let value):
                completion(true,value as? NSDictionary, nil)
                //break
                
            case .failure(let encodedError):
                print(encodedError)
                let error = APIError(error: encodedError as NSError)
                completion(false,nil,error)
                //break
            }
        }
    }
    
    class func getSyncMobileApplicationConfiguration(completion: @escaping (Bool) -> Void) {
        
        //internet check
        if !Connectivity.isConnectedToInternet() {
            //completion(false,nil,internetError)
            return
        }
        // static let baseUrlPath = UserProfile.getServiceURL()! + "/EmployeeApp/"
        //   let url = UserProfile.getServiceURL()! + "/EmployeeApp/" + "GetMobileApplicationConfiguration"
        
        let url = UserProfile.getServiceURL()! + Const.appUrl.employeeApp + "GetMobileApplicationConfiguration"
        
        Alamofire.request(url, method: .post).responseJSON{ response in
            
            switch response.result {
            case .success:
                print("responcr=",response)
                if((response.result.value) != nil) {
                    let swiftyJsonVar = JSON(response.result.value!) .dictionaryValue
                    
                    let status = swiftyJsonVar["status"]?.intValue
                    if status == 0 {
                        completion(false)
                        return
                        
                    }
                    
                    if status == 1 {
                        
                        let webResponce = swiftyJsonVar["data"]?.arrayObject as? [NSDictionary]
                        
                     //   /*
                      //  let webResponce = swiftyJsonVar["data"] as? [NSDictionary]
                        print("webResponce = \(webResponce)")
                       // if ((webResponce) != nil){
                            
                        UtilityManager.didSaveConfiguartionData(dicArray: webResponce)
                        /*
                            for index in 0..<webResponce!.count {
                                let  dic = webResponce![index]as! NSDictionary
                                print("dic=",dic)
                                
                                if(dic["Key"]as!String == "HideLeaveApp"){
                                    UserProfile.saveIsHideLeaveApp(status:dic["Value"]as?String )
                                    
                                }
                                if(dic.value(forKey: "Key")as!String == "HideCompOffApp"){
                                    UserProfile.saveIsHideCompOffApp(status: dic.value(forKey: "Value")as?String)
                                    
                                }
                                if(dic.value(forKey: "Key")as!String == "HideRegularizationApp"){
                                    UserProfile.saveIsHideRegularizationApp(status: dic.value(forKey: "Value")as?String)
                                    
                                }
                                if(dic.value(forKey: "Key")as!String == "HideWFHApp"){
                                    UserProfile
                                        .saveIsHideWFHApp(status: dic.value(forKey: "Value")as?String)
                                    
                                }
                                if(dic.value(forKey: "Key")as!String == "HideOutDutyApp"){
                                    UserProfile.saveIsHideOutDutyApp(status:dic.value(forKey: "Value")as?String )
                                    
                                }
                                if(dic.value(forKey: "Key")as!String == "HideMarkAttendance"){
                                    UserProfile.saveIshideMarkAttendance(status: dic.value(forKey: "Value")as?String)
                                    
                                }
                                if(dic.value(forKey: "Key")as!String == "Remark"){
                                    UserProfile.saveIsRemark(status: dic.value(forKey: "Value")as?String)
                                }
                                if(dic.value(forKey: "Key")as!String == "AllowLoginUsingOTP"){
                                    UserProfile.saveIsAllowLoginUsingOTP(status:dic.value(forKey: "Value")as?String )
                                    print("AllowLoginUsingOTP=",UserProfile.getIsAllowLoginUsingOTP())
                                }
                                if(dic.value(forKey: "Key")as!String == "SendOTPThroughSMS"){
                                    UserProfile.saveIsSendOTPThroughSMS(status: dic.value(forKey: "Value")as?String)
                                }
                                if(dic.value(forKey: "Key")as!String == "SendOTPThroughEmail"){
                                    UserProfile.saveIsSendOTPThroughEmail(status: dic.value(forKey: "Value")as?String)
                                }
                                
                                //////
                                if(dic.value(forKey: "Key")as!String == "HideCameraForMarkAttendance"){
                                    UserProfile.saveIsHideCameraForMarkAttendance(status: dic.value(forKey: "Value")as?String)
                                    
                                }
                                if(dic.value(forKey: "Key")as!String == "HideShiftAllocation"){
                                    UserProfile.saveIsHideShiftAllocation(status: dic.value(forKey: "Value")as?String)
                                    
                                }
                                if(dic.value(forKey: "Key")as!String == "HideAttendanceDetails"){
                                    UserProfile.saveIsHideAttendanceDetails(status: dic.value(forKey: "Value")as?String)
                                    
                                }
                                if(dic.value(forKey: "Key")as!String == "HideApplicationStatus"){
                                    UserProfile.saveIsHideApplicationStatus(status: dic.value(forKey: "Value")as?String)
                                    
                                }
                                
                                if(dic.value(forKey: "Key")as!String == "HideDiscrepancies"){
                                    UserProfile.saveIsHideDiscrepancies(status: dic.value(forKey: "Value")as?String)
                                    
                                }
                                
                                if(dic.value(forKey: "Key")as!String == "AllowShifSelectionInAttendanceRegularizationApp"){
                                    UserProfile.saveShifSelectionInAttendanceRegularizationApp(status: dic.value(forKey: "Value")as?String)
                                    
                                }
                                if(dic.value(forKey: "Key")as!String == "RegularizationAppDayStatusAsPerShiftPolicy"){
                                    UserProfile.saveRegularizationAppDayStatusAsPerShiftPolicy(status: dic.value(forKey: "Value")as?String)
                                }
                                
                                if(dic.value(forKey: "Key")as!String == "HideBranchCategoryDesignationDeptFROMhamburgerMenu"){
                                    UserProfile.saveProfileInfoHideKeyValue(status: dic.value(forKey: "Value")as?String)
                                }
                                
                                if(dic.value(forKey: "Key")as!String == "AddReasonOnApproveApp"){
                                    UserProfile.saveAddReasonOnApproveAppKeyValue(status: dic.value(forKey: "Value")as?String)
                                }
                              //  AddReasonOnApproveApp
                                // AllowShifSelectionInAttendanceRegularizationApp
                                //////
                            }
                           */
                            NotificationCenter.default.post(name: Notification.Name(rawValue: "GetMenuItem"), object: nil)
                            completion(true)
                            return
                      //  }
                        
                        //completion(false)
                    }
                    
                } //end of success
                
                break
            case .failure(let error):
                
                print("error =",error.localizedDescription)
                completion(false)
            }
            
            completion(false)
        }
    }
    
    
    // Get list Of approval for all Application
    
    class func getApprovalApplicationList(param: Dictionary<String, Any>,url: String, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter ApprovalApplicationList =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(url, method: .post, parameters:param  ,encoding: URLEncoding.default, headers: nil).responseJSON{ response in
            switch response.result {
            case .success(let value):
                completion(true,value as? NSDictionary, nil)
                //break
                
            case .failure(let encodedError):
                print(encodedError)
                let error = APIError(error: encodedError as NSError)
                completion(false,nil,error)
                //break
            }
        }
    }
    
    // GetDayStatusForRegularizationApp
    
    class func getDayStatusForRegularizationApp(completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        
        //     let url = UserProfile.getServiceURL()! + "/EmployeeApp/" + "GetDayStatusForRegularizationApp"
        let url = UserProfile.getServiceURL()! + Const.appUrl.employeeApp + "GetDayStatusForRegularizationApp"
        Alamofire.request(url, method: .post).responseJSON{ response in
            
            switch response.result {
            case .success(let value):
                completion(true,value as? NSDictionary, nil)
                //break
                
            case .failure(let encodedError):
                print(encodedError)
                let error = APIError(error: encodedError as NSError)
                completion(false,nil,error)
                //break
            }
        }
    }
    
    ///////// Approve OR reject Api call//////
    //  ApproveOrRejectWorkFromHomeApp
    class func approveOrRejectWorkFromHomeApp(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter ApproveOrRejectWorkFromHomeApp =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(GeneralRouter.approveOrRejectWorkFromHomeApp(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    
    
    //ApproveOrRejectLeaveApp
    class func approveOrRejectLeaveApp(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter ApproveOrRejectLeaveApp =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(GeneralRouter.approveOrRejectLeaveApp(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    
    // ApproveOrRejectOutDutyApp
    
    class func approveOrRejectOutDutyApp(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter approveOrRejectOutDutyApp  =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(GeneralRouter.approveOrRejectOutDutyApp(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    
    // ApproveOrRejectCompensatoryOffApp
    
    class func approveOrRejectCompensatoryOffApp(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter approveOrRejectCompensatoryOffApp =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(GeneralRouter.approveOrRejectCompensatoryOffApp(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    
    // ApproveOrRejectRegularizationApp
    
    class func approveOrRejectRegularizationApp(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter approveOrRejectRegularizationApp =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(GeneralRouter.approveOrRejectRegularizationApp(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    
    class func getEmployeeAllocatedShift(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter getEmployeeAllocatedShift =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(GeneralRouter.getEmployeeAllocatedShift(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    class func getAttendanceDetailsForSubordinate(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter GetAttendanceDetailsForSubordinate =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(GeneralRouter.getAttendanceDetailsForSubordinate(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    // getAllocatedShiftDetailsForSubordinate api
    class func getAllocatedShiftDetailsForSubordinate(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        
        Alamofire.request(GeneralRouter.getAllocatedShiftDetailsForSubordinate(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    // allocateShift api
    class func allocateShift(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        
        Alamofire.request(GeneralRouter.allocateShift(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    // getShifts api
    class func getShifts(completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        
        let url = UserProfile.getServiceURL()! + Const.appUrl.employeeApp + "GetShifts"
        
        Alamofire.request(url, method: .post).responseJSON{ response in
            
            switch response.result {
            case .success(let value):
                completion(true,value as? NSDictionary, nil)
                //break
                
            case .failure(let encodedError):
                print(encodedError)
                let error = APIError(error: encodedError as NSError)
                completion(false,nil,error)
                //break
            }
        }
    }
    
    
    class func generateOTPForMobile(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter GenerateOTPForMobile =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(OTPRouter.generateOTPForMobile(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    class func userLoginWithOTP(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("parameter UserLoginWithOTP =",param)
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(OTPRouter.userLoginWithOTP(param))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(true,value as? NSDictionary, nil)
                    //break
                    
                case .failure(let encodedError):
                    print(encodedError)
                    let error = APIError(error: encodedError as NSError)
                    completion(false,nil,error)
                    //break
                }
        }
    }
    
    class func loginWithUrl(param: Dictionary<String, Any>,url: String, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        print("loginWithUrl =\(url) and parameter =\(param)")
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        Alamofire.request(url, method: .post, parameters:param  ,encoding: URLEncoding.default, headers: nil).responseJSON{ response in
            switch response.result {
            case .success(let value):
                completion(true,value as? NSDictionary, nil)
            //break
            case .failure(let encodedError):
                print(encodedError)
                let err = encodedError as NSError
                print("err = \(err)")
                let error = APIError(error: encodedError as NSError)
                completion(false,nil,error)
                //break
            }
        }
    }
    
    /*
     class func userLoginWithOTP(param: Dictionary<String, Any>,url: String, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
     
     print("parameter Mark Attedance =",param)
     //internet check
     if !Connectivity.isConnectedToInternet() {
     completion(false,nil,internetError)
     return
     }
     Alamofire.request(url, method: .post, parameters:param  ,encoding: URLEncoding.default, headers: nil).responseJSON{ response in
     switch response.result {
     case .success(let value):
     completion(true,value as? NSDictionary, nil)
     //break
     
     case .failure(let encodedError):
     print(encodedError)
     let error = APIError(error: encodedError as NSError)
     completion(false,nil,error)
     //break
     }
     }
     }
     
     class func generateOTPForMobile(param: Dictionary<String, Any>,url: String, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
     
     print("parameter Mark Attedance =",param)
     //internet check
     if !Connectivity.isConnectedToInternet() {
     completion(false,nil,internetError)
     return
     }
     Alamofire.request(url, method: .post, parameters:param  ,encoding: URLEncoding.default, headers: nil).responseJSON{ response in
     switch response.result {
     case .success(let value):
     completion(true,value as? NSDictionary, nil)
     //break
     
     case .failure(let encodedError):
     print(encodedError)
     let error = APIError(error: encodedError as NSError)
     completion(false,nil,error)
     //break
     }
     }
     } */
    
    // end of changed by dhiraj 16-05-18
    
    
    // register FCM token
    /*  class func registerDeviceToken(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
     //internet check
     if !Connectivity.isConnectedToInternet() {
     completion(false,nil,internetError)
     return
     }
     
     Alamofire.request(GeneralRouter.registerDeviceToken(param))
     .responseJSON { response in
     switch response.result {
     case .success(let value):
     
     completion(true,value as? NSDictionary, nil)
     //break
     
     case .failure(let encodedError):
     print(encodedError)
     let error = APIError(error: encodedError as NSError)
     completion(false,nil,error)
     //break
     }
     }
     }*/
    
    class func mulitipartDemo(param: Dictionary<String, Any>, imageData: Data?, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        //internet check
        if !Connectivity.isConnectedToInternet() {
            print("internet is not available.")
            completion(false,nil,internetError)
            return
        }
        
        let parameters = param
        
        Alamofire.upload( multipartFormData: { MultipartFormData in
            for (key, value) in parameters {
                MultipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            let url = "\(Const.appUrl())" + "/uploadProfileImage"
            print("url:\(url)")
            //let imageName = "image" + "\(Date().timeStamp)" + ".png"
            if let data = imageData {
                MultipartFormData.append(data, withName: "profileImage", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: APIConst.MediaTypes.IMAGE_JPEG)
            }//profile_img
            
        }, to: Const.appUrl.mainUrl + "/uploadProfileImage") { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print(response.result.value as Any)
                    completion(true,response.result.value as? NSDictionary, nil)
                }
                break
                
            case .failure(let encodingError):
                print(encodingError)
                let error = APIError(error: encodingError as NSError)
                completion(false,nil,error)
                break
            }
        }
    }
    
    
    class func uploadAttandanceImage(param: Dictionary<String, Any>, imageData: Data?, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        //internet check
        if !Connectivity.isConnectedToInternet() {
            print("internet is not available.")
            completion(false,nil,internetError)
            return
        }
        
        var imagesData = [Data]()
        var imageParamName = [String]()
        
        imagesData.append(imageData!)
        imageParamName.append(param["swipeImageFileName"] as! String)
        
        
        let parameters = param
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            // import image to request
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            var i = 0
            for imageData in imagesData {
                multipartFormData.append(imageData, withName: "\(imageParamName[i])", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: APIConst.MediaTypes.IMAGE_JPEG)
                i = i + 1
            }
            
        }, to: "http://seedmanagement.cloudapp.net/Enterprise_MobileApp/app/Api/EmployeeApi/AddMobileSwipes",
           
           encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print(response.result.value as Any)
                    completion(true,response.result.value as? NSDictionary, nil)
                }
                break
                
            case .failure(let error):
                print(error)
                let error = APIError(error: error as NSError)
                completion(false,nil,error)
                break
            }
        })
    }
    
    
    //MARK:new Apis for change password
    
    class func didChangePasswordApi(param: Dictionary<String, Any>, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        /*
         let passUrl = "http://emcloud.emsphere.com/Enterprise_MobileApp_Testing/app/Api/EmployeeApi/ChangePassword"
         let url = UserProfile.getServiceURL()! + "EmployeeApp" + "/ChangePassword"//Const.appUrl.mainUrl + "/ChangePassword"
         let url2 = "http://emcloud.emsphere.com/Enterprise_MobileApp_Testing/app/Api/EmployeeApi/ForgotPassword"
         let url1 = "http://emcloud.emsphere.com/Enterprise_MobileApp/app/Api/EmployeeApi" + "/ChangePassword"
         
         let workingUrl = "http://emcloud.emsphere.com/Enterprise_MobileApp_Testing/app/Api/EmployeeApi/ChangePassword"
         
         let  aa = "http://emcloud.emsphere.com/Enterprise_MobileApp_Testing/app/api/EmployeeApp/ChangePassword"
         */
        
        //Message = "No HTTP resource was found that matches the request URI 'http://emcloud.emsphere.com/Enterprise_MobileApp_Testing/app/api/EmployeeApp/ChangePassword'.";
        
        //http://emcloud.emsphere.com/Enterprise_MobileApp_Testing/app/api/EmployeeApi/ChangePassword
        var url = UserProfile.getServiceURL()! + Const.appUrl.employeeApi + "ChangePassword"
        url = url.trimmingCharacters(in: .whitespacesAndNewlines)
        print("para = \(param)and url = \(url)")
        Alamofire.request(url, method: .post, parameters:param  ,encoding: URLEncoding.default, headers: nil).responseJSON{ response in
            print("response ChangePasswordApi = \(response)")
            switch response.result {
            case .success(let value):
                completion(true,value as? NSDictionary, nil)
            //break
            case .failure(let encodedError):
                print(encodedError)
                let error = APIError(error: encodedError as NSError)
                completion(false,nil,error)
                //break
            }
        }
    }
    
    
    class func didCallForgotpassowrdApi(param: Dictionary<String, Any>,servicrUrl:String, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
        var url  = servicrUrl
        //  var url = UserProfile.getServiceURL()! + Const.appUrl.employeeApi + "ForgotPassword"
        url = url.trimmingCharacters(in: .whitespacesAndNewlines)
        print("Forgot para = \(param)and url = \(url)")
        Alamofire.request(url, method: .post, parameters:param  ,encoding: URLEncoding.default, headers: nil).responseJSON{ response in
            print("response Forgot = \(response)")
            switch response.result {
            case .success(let value):
                completion(true,value as? NSDictionary, nil)
            //break
            case .failure(let encodedError):
                print(encodedError)
                let error = APIError(error: encodedError as NSError)
                completion(false,nil,error)
                //break
            }
        }
    }
    
    class func uploadDocs(param: Dictionary<String, Any>?, imageData: Data?,fileInfo:FileInfo, completion: @escaping (Bool, NSDictionary?, APIError?) -> Void) {
        
        //internet check
        if !Connectivity.isConnectedToInternet() {
            print("internet is not available.")
            completion(false,nil,internetError)
            return
        }
        
        
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data"
        ]
        
        let baseurl = UserProfile.getServiceURL() ?? ""
        let url = baseurl + Const.appUrl.employeeApp + "/UploadFile"
        
        print("Docs Upload Url = \(url)")
        guard let imgData = imageData else {
            return
        }
        
        print("fileName = \(fileInfo.fileName),mimeType =\(fileInfo.mimeType)")
        Alamofire.upload(multipartFormData: { multipartFormData in
            // import image to request
            /*
             for (key, value) in param?.enumerated(){
             multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
             } */
            /*
             var i = 0
             for imageData in imagesData {
             multipartFormData.append(imageData, withName: "\(imageParamName[i])", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: APIConst.MediaTypes.IMAGE_JPEG)
             i = i + 1
             }*/
            
            multipartFormData.append(imgData, withName: "upload_data" , fileName: fileInfo.fileName, mimeType: fileInfo.mimeType)
            
            
        }, to: url,method: .post,
           
           encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print("uploadDocs rspo =",response.result.value as Any)
                    completion(true,response.result.value as? NSDictionary, nil)
                }
                break
                
            case .failure(let error):
                print("uploadDocs err= ",error)
                let error = APIError(error: error as NSError)
                completion(false,nil,error)
                break
            }
        })
    }
    /*
     
     class func didMakeUploadMultipart(endUrl: String, imageData: Data?,imageKey: String = "image",parameters: [String : Any], completion: @escaping (Error?, VBBaseResponseModel?,Int?) -> Void)  {
     let url = ""
     
     let headers: HTTPHeaders = [
     /* "Authorization": "your_access_token",  in case you need authorization header */
     "Content-type": "multipart/form-data"
     ]
     
     Alamofire.upload(multipartFormData: { (multipartFormData) in
     for (key, value) in parameters {
     multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
     }
     
     if let data = imageData{
     multipartFormData.append(data, withName: imageKey, fileName: "image.png", mimeType: "image/png")
     }
     
     }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers) { (result) in
     switch result{
     case .success(let upload, _, _):
     upload.responseJSON { response in
     //                    print("Succesfully uploaded")
     //                    print(response)
     //                    print("Succesfully uploaded")
     //                    print(response.value)
     //                    if let err = response.error{
     //                       // onError?(err)
     //                        return
     //                    }
     
     //onCompletion?(nil)
     if let error = response.error {
     print("Error making an API call. - \(error.localizedDescription)")
     completion(error, nil, nil)
     return
     }
     if let data = response.data {
     
     do {
     let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? AnyObject
     
     print("jsonResult = \(jsonResult)")
     
     }catch {
     print("post data error",error)
     }
     
     do {
     let model = try JSONDecoder().decode(VBBaseResponseModel.self, from: data)
     completion(nil, model, nil)
     } catch let error {
     guard let status = response.response?.statusCode else{return}
     if status == 500{
     print("internal server error")
     }else if status == 401{
     print("internal server error")
     }
     print("error status code is:\(String(describing: response.response?.statusCode))")
     print("Error decoding - \(error.localizedDescription)")
     completion(error, nil, status)
     }
     return
     }
     }
     case .failure(let error):
     print("Error in upload: \(error.localizedDescription)")
     //onError?(error)
     }
     }
     }
     
     */
    /*
     
     //MARK:for new swift alomafire
     fileprivate func uploadDocument(_ file: Data,filename : String,handler : @escaping (String) -> Void) {
     let headers: HTTPHeaders = [
     "Content-type": "multipart/form-data"
     ]
     
     AF.upload(
     multipartFormData: { multipartFormData in
     multipartFormData.append(file, withName: "upload_data" , fileName: filename, mimeType: "application/pdf")
     },
     to: "https://yourserverurl", method: .post , headers: headers)
     .response { response in
     if let data = response.data{
     //handle the response however you like
     }
     
     }
     }
     */
    
    
    
}//end of Api manager


