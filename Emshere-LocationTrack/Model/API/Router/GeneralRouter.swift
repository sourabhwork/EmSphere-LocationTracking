//
//  GeneralRouter.swift
//  SampleCode
//
//  Created by iarianatech mac-mini on 21/12/17.
//  Copyright © 2017 iAriana Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire


public class APIConst {
    
    struct MediaTypes {
        static let APPLICATION_JSON = "application/json"
        static let IMAGE_JPEG       = "image/jpeg"
        static let PDF              = "application/pdf"
        static let TEXT             = "text/plain"
        static let XLS              = "application/vnd.ms-excel"
        static let doc              = "application/msword"
        static let png              = "image/png"
    }
    
    struct MediaTypesArray {
        static let jpeg = ["jpeg","jpg"]
        static let png =  ["png"]
        static let pdf   = ["pdf"]
        static let excel = ["xls,xlsx"]
        static let TEXT  = ["text","csv"]
        static let doc   = ["doc"]
    }
    struct AllSupportedMediaTypes {
        static let mediaTypes = ["jpeg","jpg","png","pdf","xls,xlsx","text","csv","doc"]
    }
    //https://gist.github.com/ngs/918b07f448977789cf69
    struct HttpHeaders {
        
        static let ACCEPT = "Accept"
        
        static let CONTENT_TYPE = "Content-Type"
        
        static let ACCEPT_LANGUAGE = "Accept-Language"
        
        static let CONTENT_LANGUAGE = "Content-Language"
        
        static let CUSTOM_USER_AGENT = "X-Device-User-Agent"
        
        static let AUTHORIZATION = "Authorization"
        
        static let DISPLAY_DENSITY = "X-Device-Display-Density"
        
        static let ETAG_REQUEST = "If-None-Match"
        
        static let ETAG_RESPONSE = "Etag"
    }
}

//Employee Licence Router
public enum LicenseRouter: URLRequestConvertible {
    
    static let baseUrlPath = Const.appUrl.licenseUrl
    static let authenticationToken = "Basic xxx"
    
    // api name
    case register(Dictionary<String,Any>)
    case verifyLicenseNumber(Dictionary<String,Any>)
    
    
    // HTTPMethod type
    var method: HTTPMethod {
        switch self {
        case .register:
            return .post
        case .verifyLicenseNumber:
            return .post
        }
    }
    
    // add path
    var path: String {
        switch self {
        case .register:
            return "/Registration"
        case .verifyLicenseNumber:
            return "/VerifyLicenseNumber"
        }
    }//com.nearme.resturantfinder
    
    // create url request
    public func asURLRequest() throws -> URLRequest {
        let parameters: [String: Any] = {
            switch self {
            case .register(let param):
                return param as [String: Any]
            case .verifyLicenseNumber(let param):
                return param as [String: Any]
            }
        }()
        
        print("param:\(parameters)")
        // var modifiedUrl =
        let url = try LicenseRouter.baseUrlPath.asURL()
        print(url)
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        // request.setValue(ImaggaRouter.authenticationToken, forHTTPHeaderField: "Authorization")
        request.timeoutInterval = TimeInterval(Const.timeOutInterval)
        return try URLEncoding.default.encode(request, with: parameters)
    }
}

//General router
public enum GeneralRouter: URLRequestConvertible {
    
    static let baseUrlPath = UserProfile.getServiceURL()! + Const.appUrl.employeeApp//"EmployeeApp"
    
    
    static let authenticationToken = "Basic xxx"
    // api name
    case register(Dictionary<String,Any>)
    case logout(Dictionary<String,Any>)
    case getLicenseNumber(Dictionary<String,Any>)
    
    // Home Calender
    case getDayStatusForAMonthCalender(Dictionary<String,Any>)
    case getEmployeeHoursWeekWise(Dictionary<String,Any>)
    case getAttendanceDetails(Dictionary<String,Any>)
    
    // Leave Application
    case leaveApplication(Dictionary<String,Any>)
    case getLeaveApplicationForApproval(Dictionary<String,Any>)
    case getNoOfLeaveDays(Dictionary<String,Any>)
    case getReasonsAccordingToLeaveType(Dictionary<String,Any>)
    case getLeaveTypeByEmployeeId(Dictionary<String,Any>)
    case getLeaveBalance(Dictionary<String,Any>)  //
    case getWorkFlowForLeaveApp(Dictionary<String,Any>)
    case getLeaveApplicationList(Dictionary<String,Any>)
    case approveOrRejectLeaveApp(Dictionary<String,Any>)
    case getLeavePolicyDetail(Dictionary<String,Any>)
    
    // Mark Attedanace
    case uploadImageWithMarkAttendance(Dictionary<String,Any>)
    
    // Attendance Regularization
    case applyRegularizationApp(Dictionary<String,Any>)
    case getWorkFlowForRegularizationApp(Dictionary<String,Any>)
    case getReasonsForRegularizationApp(Dictionary<String,Any>)
    case getShiftForRegularizeApplication(Dictionary<String,Any>)
    case getRealInOutDateTimeForShiftDate(Dictionary<String,Any>)
    case getApplicationCount(Dictionary<String,Any>)
    case getRegularizationApplicationList(Dictionary<String,Any>)
    case approveOrRejectRegularizationApp(Dictionary<String,Any>)
    
    // comp - off
    case getWorkFlowForCompensatoryOffApp(Dictionary<String,Any>)
    case getReasonsForCompensatoryOffApp(Dictionary<String,Any>)
    case getEmployeeCompOffDetail(Dictionary<String,Any>)
    case getCompensatoryOffApplicationForApproval(Dictionary<String,Any>)
    case getCompensatoryOffApplicationList(Dictionary<String,Any>)
    case applyCompensatoryOffApp(Dictionary<String,Any>)
    case getCompOffAgainstDetails(Dictionary<String,Any>)
    case approveOrRejectCompensatoryOffApp(Dictionary<String,Any>)
    
    // Out Duty
    case getOutDutyApplicationList(Dictionary<String,Any>)//
    case getNoOfOutDutyAppDays(Dictionary<String,Any>)
    case applyOutDutyApp(Dictionary<String,Any>)
    case getOutDutyApplicationForApproval(Dictionary<String,Any>)
    case getWorkFlowForOutDutyApp(Dictionary<String,Any>)
    case getReasonsForOutDutyApp(Dictionary<String,Any>)
    case approveOrRejectOutDutyApp(Dictionary<String,Any>)
    
    // Work From Home
    case getWorkFromHomeApplicationList(Dictionary<String,Any>)
    case getReasonsForWorkFromHomeApp(Dictionary<String,Any>)
    case getNoOfWorkFromHomeDays(Dictionary<String,Any>)
    
    case getWorkFromHomeApplicationForApproval(Dictionary<String,Any>)
    case getWorkFlowForWorkFromHomeApp(Dictionary<String,Any>)
    
    case applyWorkFromHomeApp(Dictionary<String,Any>)
    case getDateTimeDifferenceInHoursMinForMultipleDays(Dictionary<String,Any>)
    case approveOrRejectWorkFromHomeApp(Dictionary<String,Any>)
    
    // Drawer tab features
    case getDiscrepanciesDetailList(Dictionary<String,Any>)
    case getEmployeeAllocatedShift(Dictionary<String,Any>)
    case getAttendanceDetailsForSubordinate(Dictionary<String,Any>)
    
    // Shift Allocation
    case allocateShift(Dictionary<String,Any>)
    case getShifts(Dictionary<String,Any>)
    case getAllocatedShiftDetailsForSubordinate(Dictionary<String,Any>)
    case getChangePassword(Dictionary<String,Any>)
    case uploadFile(Dictionary<String,Any>)
    
    
    
    // HTTPMethod type
    var method: HTTPMethod {
        switch self {
        case .register:
            return .post
        case .logout:
            return .post
        case .leaveApplication:
            return .post
        case .getDayStatusForAMonthCalender:
            return .post
        case .getLeaveApplicationForApproval:
            return .post
        case .getNoOfLeaveDays:
            return .post
        case .getLicenseNumber:
            return .post
        case .getReasonsAccordingToLeaveType:
            return .post
        case .getAttendanceDetails:
            return .post
        case .getEmployeeHoursWeekWise:
            return .post
        case .getLeaveTypeByEmployeeId:
            return .post
        case .getLeaveBalance:
            return .post
        case .getWorkFlowForLeaveApp:
            return .post
        case .getLeaveApplicationList://
            return .post
        case .getLeavePolicyDetail: //MARK:added on 10-April-2021
            return .post
        case .approveOrRejectLeaveApp:
            return .post
        case .uploadImageWithMarkAttendance:
            return .post
            
        // Attendance Regularization
        case .applyRegularizationApp:
            return .post
        case .getWorkFlowForRegularizationApp:
            return .post
        case .getReasonsForRegularizationApp:
            return .post
        case .getShiftForRegularizeApplication:
            return .post
        case .getRealInOutDateTimeForShiftDate:
            return .post
        case .getRegularizationApplicationList:
            return .post
        case .approveOrRejectRegularizationApp:
            return .post
            
        // Home pending Appln
        case .getApplicationCount:
            return .post
            
        // comp off
        case .getWorkFlowForCompensatoryOffApp:
            return .post
        case .getReasonsForCompensatoryOffApp:
            return .post
        case .getCompensatoryOffApplicationForApproval:
            return .post
        case .getEmployeeCompOffDetail:
            return .post
        case .getCompensatoryOffApplicationList:
            return .post
        case .applyCompensatoryOffApp:
            return .post
        case .getCompOffAgainstDetails:
            return .post
        case .approveOrRejectCompensatoryOffApp:
            return .post
            
        // Out Duty
        case .getOutDutyApplicationList:
            return .post               ////
        case .getNoOfOutDutyAppDays:
            return .post
        case .applyOutDutyApp:
            return .post
        case .getOutDutyApplicationForApproval:
            return .post
        case .getWorkFlowForOutDutyApp:
            return .post
        case .getReasonsForOutDutyApp:
            return .post
        case .approveOrRejectOutDutyApp:
            return .post
            
        // Work From Home
        case .getWorkFromHomeApplicationList:
            return .post    //
        case .getReasonsForWorkFromHomeApp:
            return .post
        case .getNoOfWorkFromHomeDays:
            return .post
        case .getWorkFromHomeApplicationForApproval:
            return .post
        case .getWorkFlowForWorkFromHomeApp:
            return .post
        case .applyWorkFromHomeApp:
            return .post
        case .getDateTimeDifferenceInHoursMinForMultipleDays:
            return .post
        case .approveOrRejectWorkFromHomeApp:
            return .post
            
        //Drawer tab features
        case .getDiscrepanciesDetailList:
            return .post
        case .getEmployeeAllocatedShift:
            return .post
        case .getAttendanceDetailsForSubordinate:
            return .post
            
        // Shift Allocation
        case .allocateShift:
            return .post
        case .getShifts:
            return .post
        case .getAllocatedShiftDetailsForSubordinate:
            return .post
            
        //MARK:Change pasword
        case .getChangePassword:
            return .post
        case .uploadFile:
            return .post
            
        }
    }
    
    // add path
    var path: String {
        switch self {
        case .register:
            return "/register"
        case .logout:
            return "/logout"
        case .leaveApplication:
            return "/ApplyLeaveApp"
        case .getDayStatusForAMonthCalender:
            return "/DayStatusForAMonthCalender"
        case .getLeaveApplicationForApproval:
            return "/GetLeaveApplicationForApproval"
        case .getNoOfLeaveDays:
            return "/GetNoOfLeaveDays"
        case .getLicenseNumber:
            return "/ApplyLeaveApp"
        case .getReasonsAccordingToLeaveType:
            return "/GetReasonsAccordingToLeaveType"
        case .getAttendanceDetails:
            return "/GetAttendanceDetails"
        case .getEmployeeHoursWeekWise:
            return "/GetEmployeeHoursWeekWise"
        case .getLeaveTypeByEmployeeId:
            return "/GetLeaveTypeByEmployeeId"
        case .getLeaveBalance:
            return "/GetLeaveBalance"
        case .getWorkFlowForLeaveApp:
            return "/GetWorkFlowForLeaveApp"
        case .getLeaveApplicationList:
            return "/GetLeaveApplicationList"
        case .getLeavePolicyDetail:
            return "/GetLeavePolicyDetail"
            
        case .approveOrRejectLeaveApp:
            return "/ApproveOrRejectLeaveApp"
        case .uploadImageWithMarkAttendance:
            return "/AddMobileSwipes"
            
        // Attendance Regularization
        case .applyRegularizationApp:
            return "/ApplyRegularizationApp"
        case .getWorkFlowForRegularizationApp:
            return "/GetWorkFlowForRegularizationApp"
        case .getReasonsForRegularizationApp:
            return "/GetReasonsForRegularizationApp"
        case .getShiftForRegularizeApplication:
            return "/GetShiftForRegularizeApplication"
        case .getRealInOutDateTimeForShiftDate:
            return "/GetRealInOutDateTimeForShiftDate"
        case .getApplicationCount:
            return "/GetApplicationCount"
        case .getRegularizationApplicationList:
            return "/GetRegularizationApplicationList"
        case .approveOrRejectRegularizationApp:
            return "/ApproveOrRejectRegularizationApp"
            
        // comp -off
        case .getWorkFlowForCompensatoryOffApp:
            return "/GetWorkFlowForCompensatoryOffApp"
        case .getReasonsForCompensatoryOffApp:
            return "/GetReasonsForCompensatoryOffApp"
        case .getCompensatoryOffApplicationForApproval:
            return "/GetCompensatoryOffApplicationForApproval"
        case .getEmployeeCompOffDetail:
            return "/GetEmployeeCompOffDetail"
        case .getCompensatoryOffApplicationList:
            return "/GetCompensatoryOffApplicationList"
        case .applyCompensatoryOffApp:
            return "/ApplyCompensatoryOffApp"
        case .getCompOffAgainstDetails:
            return "/GetCompOffAgainstDetails"
        case . approveOrRejectCompensatoryOffApp:
            return "/ApproveOrRejectCompensatoryOffApp"
            
        // Out Duty
        case .getOutDutyApplicationList:
            return "/GetOutDutyApplicationList" //
        case .getNoOfOutDutyAppDays:
            return "/GetNoOfOutDutyAppDays"
        case .applyOutDutyApp:
            return "/ApplyOutDutyApp"
        case .getOutDutyApplicationForApproval:
            return "/GetOutDutyApplicationForApproval"
        case .getWorkFlowForOutDutyApp:
            return "/GetWorkFlowForOutDutyApp"
        case .getReasonsForOutDutyApp:
            return "/GetReasonsForOutDutyApp"
        case .approveOrRejectOutDutyApp:
            return "/ApproveOrRejectOutDutyApp"
            
        // Work From Home
        case .getWorkFromHomeApplicationList:
            return "/GetWorkFromHomeApplicationList" //
        case .getReasonsForWorkFromHomeApp:
            return "/GetReasonsForWorkFromHomeApp"
        case .getNoOfWorkFromHomeDays:
            return "/GetNoOfWorkFromHomeDays"
        case .getWorkFromHomeApplicationForApproval:
            return "/GetWorkFromHomeApplicationForApproval"
        case .getWorkFlowForWorkFromHomeApp:
            return "/GetWorkFlowForWorkFromHomeApp"
        case .applyWorkFromHomeApp:
            return "/ApplyWorkFromHomeApp"
        case .getDateTimeDifferenceInHoursMinForMultipleDays:
            return "/GetDateTimeDifferenceInHoursMinForMultipleDays"
        case .approveOrRejectWorkFromHomeApp:
            return "/ApproveOrRejectWorkFromHomeApp"
            
        // Drawer tab features
        case .getDiscrepanciesDetailList:
            return "/GetDiscrepanciesDetailList"
            
        case .getEmployeeAllocatedShift:
            return "/GetEmployeeAllocatedShift"
            
        case .getAttendanceDetailsForSubordinate:
            return "/GetAttendanceDetailsForSubordinate"
            
        // Shift Allocation
        case .allocateShift:
            return "/AllocateShift"
        case .getShifts:
            return "/GetShifts"
        case .getAllocatedShiftDetailsForSubordinate:
            return "/GetAllocatedShiftDetailsForSubordinate"
        case .getChangePassword:
            return "/ForgotPassword"//"/ChangePassword"
        
        case .uploadFile:
            return "/UploadFile"
            
            
        }
    }//com.nearme.resturantfinder
    
    // create url request
    public func asURLRequest() throws -> URLRequest {
        let parameters: [String: Any] = {
            switch self {
            case .register(let param):
                return param as [String: Any]
            case .logout(let param):
                return param as [String: Any]
            case .leaveApplication(let param):
                return param as [String: Any]
            case .getDayStatusForAMonthCalender(let param):    // changed by dhiraj 16-05-18
                return param as [String: Any]
            case .getLeaveApplicationForApproval(let param):
                return param as [String: Any]
            case .getNoOfLeaveDays(let param):
                return param as [String: Any]
            case .getLeavePolicyDetail(let param): //MARK:changed by dhiraj 10-04-2021
                return param as [String: Any]
            case .getLicenseNumber(let param):
                return param as [String: Any]
            case .getReasonsAccordingToLeaveType(let param):
                return param as [String: Any]
            case .getAttendanceDetails(let param):
                return param as [String: Any]
            case .getEmployeeHoursWeekWise(let param):
                return param as [String: Any]
            case .getLeaveTypeByEmployeeId(let param):
                return param as [String: Any]
            case .getLeaveBalance(let param):
                return param as [String: Any]
            case .getWorkFlowForLeaveApp(let param):
                return param as [String: Any]
            case .getLeaveApplicationList(let param):
                return param as [String: Any]
            case .approveOrRejectLeaveApp(let param):
                return param as [String: Any]
            case .uploadImageWithMarkAttendance(let param):
                return param as [String: Any]
                
            // Attendance Regularization
            case .applyRegularizationApp(let param):
                return param as [String: Any]
            case .getWorkFlowForRegularizationApp(let param):
                return param as [String: Any]
            case .getReasonsForRegularizationApp(let param):
                return param as [String: Any]
            case .getShiftForRegularizeApplication(let param):
                return param as [String: Any]
            case .getRealInOutDateTimeForShiftDate(let param):
                return param as [String: Any]
            case .getApplicationCount(let param):
                return param as [String: Any]
            case .getRegularizationApplicationList(let param):
                return param as [String: Any]
            case .approveOrRejectRegularizationApp(let param):
                return param as [String: Any]
                
            // comp off
            case .getWorkFlowForCompensatoryOffApp(let param):
                return param as [String: Any]
            case .getReasonsForCompensatoryOffApp(let param):
                return param as [String: Any]
            case .getCompensatoryOffApplicationForApproval(let param):
                return param as [String: Any]
            case .getEmployeeCompOffDetail(let param):
                return param as [String: Any]
            case .getCompensatoryOffApplicationList(let param):
                return param as [String: Any]
            case .applyCompensatoryOffApp(let param):
                return param as [String: Any]
            case .getCompOffAgainstDetails(let param):
                return param as [String: Any]
            case .approveOrRejectCompensatoryOffApp(let param):
                return param as [String: Any]
                
            // Out Duty
            case .getOutDutyApplicationList(let param):
                return param as [String: Any]  //
            case .getNoOfOutDutyAppDays(let param):
                return param as [String: Any]
            case .applyOutDutyApp(let param):
                return param as [String: Any]
            case .getOutDutyApplicationForApproval(let param):
                return param as [String: Any]
            case .getWorkFlowForOutDutyApp(let param):
                return param as [String: Any]
            case .getReasonsForOutDutyApp(let param):
                return param as [String: Any]
            case .approveOrRejectOutDutyApp(let param):
                return param as [String: Any]
                
            // Work From Home
            case .getWorkFromHomeApplicationList(let param):
                return param as [String: Any] //
            case .getReasonsForWorkFromHomeApp(let param):
                return param as [String: Any]
            case .getNoOfWorkFromHomeDays(let param):
                return param as [String: Any]
            case .getWorkFromHomeApplicationForApproval(let param):
                return param as [String: Any]
            case .getWorkFlowForWorkFromHomeApp(let param):
                return param as [String: Any]
            case .applyWorkFromHomeApp(let param):
                return param as [String: Any]
            case .getDateTimeDifferenceInHoursMinForMultipleDays(let param):
                return param as [String: Any]
            case .approveOrRejectWorkFromHomeApp(let param):
                return param as [String: Any]
                
            // Drawer tab features
            case .getDiscrepanciesDetailList(let param):
                return param as [String: Any]
                
            case .getEmployeeAllocatedShift(let param):
                return param as [String: Any]
                
            case .getAttendanceDetailsForSubordinate(let param):
                return param as [String: Any]
            // Shift Allocation
            case .allocateShift(let param):
                return param as [String: Any]
            case .getShifts(let param):
                return param as [String: Any]
            case .getAllocatedShiftDetailsForSubordinate(let param):
                return param as [String: Any]
                
            case .getChangePassword(let param):
                return param as [String: Any]
                
            case .uploadFile(let param):
                return param as [String: Any]
                
            }
            
        }()
        
        
        let url = try GeneralRouter.baseUrlPath.asURL()
        let finalUrl = url.appendingPathComponent(path)
        print("finalUrl:\(finalUrl)")
        print("param:::\(parameters)")
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        //request.setValue(ImaggaRouter.authenticationToken, forHTTPHeaderField: "Authorization")
        
        request.timeoutInterval = TimeInterval(Const.timeOutInterval)
        return try URLEncoding.default.encode(request, with: parameters)
    }
}


//Login router
public enum LoginRouter: URLRequestConvertible {
    
    //static let baseUrlPath = Const.appUrl.mainUrl
    
    static let baseUrlPath = UserProfile.getServiceURL()! + Const.appUrl.employeeApi//"/EmployeeApp/"
    
    
    static let authenticationToken = "Basic xxx"
    
    case login(Dictionary<String,Any>)
    
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        }
    }
    
    // add path
    var path: String {
        switch self {
        
        case .login:
            return "/UserLogin"
            
        }
    }//com.nearme.resturantfinder
    
    // create url request
    public func asURLRequest() throws -> URLRequest {
        let parameters: [String: Any] = {
            switch self {
            case .login(let param):
                return param as [String: Any]
            // up to this  dhiraj 16-05-018
            }
        }()
        
        print("param:::\(parameters)")
        
        let url = try LoginRouter.baseUrlPath.asURL()
        print("url:\(url)")
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(Const.timeOutInterval)
        return try URLEncoding.default.encode(request, with: parameters)
    }
}


//Login router
public enum OTPRouter: URLRequestConvertible {
    
    static let baseUrlPath = UserProfile.getServiceURL()! + Const.appUrl.employeeApi//"/EmployeeApi/"  //"http://125.99.69.58/ValueLab/app/api/EmployeeApi/"
    static let authenticationToken = "Basic xxx"
    
    case generateOTPForMobile(Dictionary<String,Any>)
    case userLoginWithOTP(Dictionary<String,Any>)
    // forgot password
    case forgotPassword(Dictionary<String,Any>)
    var method: HTTPMethod {
        switch self {
        case .generateOTPForMobile:
            return .post
        case .userLoginWithOTP:
            return .post
            
        case .forgotPassword(_):
            return .post
        }
    }
    
    // add path
    var path: String {
        switch self {
        
        case .generateOTPForMobile:
            return "/GenerateOTPForMobile"
            
        case .userLoginWithOTP:
            return "/UserLoginWithOTP"
            
            
        case .forgotPassword(_):
            return "/ForgotPassword"
        }
    }//com.nearme.resturantfinder
    
    // create url request
    public func asURLRequest() throws -> URLRequest {
        let parameters: [String: Any] = {
            switch self {
            case .generateOTPForMobile(let param):
                return param as [String: Any]
                
            case .userLoginWithOTP(let param):
                return param as [String: Any]
                
            case .forgotPassword(let param):
                return param as [String: Any]
            }
        }()
        
        print("param:::\(parameters)")
        
        let url = try OTPRouter.baseUrlPath.asURL()
        print("url:\(url)")
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(Const.timeOutInterval)
        return try URLEncoding.default.encode(request, with: parameters)
    }
}

