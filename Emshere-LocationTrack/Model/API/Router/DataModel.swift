//
//  DataModel.swift
//  SampleCode
//
//  Created by iarianatech mac-mini on 19/01/18.
//  Copyright © 2018 iAriana Technologies Pvt. Ltd. All rights reserved.
//

import Foundation

struct DataModel {
    
    //constants
    var deviceName: String? = Const.deviceName
    var deviceOs: String? = Const.deviceOS
    var deviceType: String? = Const.deviceType
    var appVersion: String? = getBundleShortVersion
    // var token: String? = Const.deviceToken
    var lang: String? = Const.deviceLanguage
    
    //regisration
    var employeeCode: String? = nil
    var mobileNumber: String? = nil
    var companyCode: String? = nil
    var registrationType: String? = nil
    var deviceID: String? = nil
    
    
    //login
    var userName: String? = nil
    
    
    //leave application
    var token: String? = nil
    var fromDate: String? = nil
    var employeeId: String? = nil
    var toDate: String? = nil
    var isFirstHalfLeave: String? = nil
    var isSecondHalfLeave: String? = nil
    var leaveTypeID: String? = nil
    var leavetypeID: String? = nil
    var noOfLeaveDays: String? = nil
    var reasonID: String? = nil
    var reasonDescription: String? = nil
    var documentFileName:String? = nil //MARK: to solve leave appliN issue 30-April/2020
    // Appln Approval
    var LeaveAppID: String? = nil
    var LeaveAppLevelDetailID: String? = nil
    var statusID: String? = nil
    var rejectRemark: String? = nil
    var ByEmployeeID: String? = nil
    
    // licence verification
    var deviceId: String? = nil
    var licenseNumber: String? = nil
    var FCMID: String? = nil
    var monthDate: String? = nil
    
    var id: String? = nil
    var firstName:String? = nil
    var lastName:String? = nil
    var fullName:String? = nil
    var email:String? = nil
    var additionalMobileNo: String? = nil
    var password: String? = nil
    var newPassword: String? = nil
    var gender: String? = nil
    var companyName: String? = nil
    var date: String? = nil  // for getting calender data
    
    var employeeID: String? = nil
    var isFirstHalf: String? = nil
    var isSecondHalf: String? = nil
    
    //mark attandance
    var swipeTime: String? = nil
    var latitude: String? = nil
    var longitude: String? = nil
    var locationAddress: String? = nil
    var swipeImageFileName: String? = nil
    var isOnlineSwipe: String? = nil
    var remark: String? = nil
    var locationProvider: String? = nil
    var door: String? = nil
    //GetWorkFlowForLeaveApp
    var leaveTypeId: String? = nil
    
    // Attendance Regulization
    var shiftDate: String? = nil
    var NoOfDays: String? = nil
    var ShiftDateFrom: String? = nil
    var ShiftDateTo: String? = nil
    var InDate: String? = nil
    var OutDate: String? = nil
    var InTime: String? = nil
    var OutTime: String? = nil
    var shiftID: String? = nil
    var Remark: String? = nil
    var RealInDateTime: String? = nil
    var RealOutDateTime: String? = nil
    var ReasonID: String? = nil
    var RegularizationAppID: String? = nil
    var RegularizationAppLevelDetailID: String? = nil
    var DayStatusID: String? = nil
    var IsDayStatusOverride: String? = nil
    
    // comp-Off
    var takenCompOffDate: String? = nil
    var isFirstHalfCompOff: String? = nil
    var isSecondHalfCompOff: String? = nil
    var compOffAgainstDetails: String? = nil
    var compOffID: String? = nil
    var isHrsOrdays: String? = nil
    var isHalfDay: String? = nil
    var takenCODate: String? = nil
    var fromDateTime: String? = nil
    var toDateTime: String? = nil
    var AppForMultipleDays: String? = nil
    var CompensatoryOffAppID: String? = nil
    var CompensatoryOffAppLevelDetailID: String? = nil
    
    // Out Duty
    var fromTime: String? = nil
    var toTime: String? = nil
    var IsODAppInHours: String? = nil
    var outDutyAddress: String? = nil
    var OutDutyAppID: String? = nil
    var OutDutyAppLevelDetailID: String? = nil
    
    // WFH
    
    var isConsiderTimeCross: String? = nil
    var isWFHAppInHours: String? = nil
    var WorkFromHomeAppID: String? = nil
    var WorkFromHomeAppLevelDetailID: String? = nil
    
    
    // OTP
    
    var OTP: String? = nil
    
    // Shift Allocation
    var allocatedToEmployeeCode: String? = nil
    var shiftName: String? = nil
    var createdByEmployeeID: String? = nil
    
    //MARK:change Password:
    var oldPassword: String? = nil
    var newChangedPassword: String? = nil
    var confirmPassword:String? = nil
    
    init(lang: String?) {
        self.lang = lang
    }
    
    //registration
    init(employeeCode: String?, mobileNumber: String?, companyCode: String?, registrationType: String?, deviceID: String?) {
        self.employeeCode = employeeCode
        self.mobileNumber = mobileNumber
        self.companyCode = companyCode
        self.registrationType = registrationType
        self.deviceID = deviceID
    }
    
    // VerifyLicenseNumber
    init(employeeCode: String?,deviceId: String?,licenseNumber:String?,companyCode:String?,FCMID:String?) {
        self.employeeCode = employeeCode
        self.deviceId = deviceId
        self.licenseNumber = licenseNumber
        self.companyCode = companyCode
        self.FCMID = FCMID
    }
    
    // login
    init(userName: String?, password: String?, deviceId: String?, employeeCode: String?) {
        self.userName = employeeCode
        self.password = password
        self.employeeCode = employeeCode
        self.deviceId = deviceId
    }
    
    //leave application
    init(token: String?, employeeId: String?, fromDate: String?, toDate: String?, isFirstHalfLeave: String?, isSecondHalfLeave: String?, leaveTypeID: String?, noOfLeaveDays: String?, reasonID: String?, reasonDescription: String?,documentFileName:String?) {
        self.token = token
        self.employeeId = employeeId
        self.fromDate = fromDate
        self.toDate = toDate
        self.isFirstHalfLeave = isFirstHalfLeave
        self.isSecondHalfLeave = isSecondHalfLeave
        self.leaveTypeID = leaveTypeID
        self.noOfLeaveDays = noOfLeaveDays
        self.reasonID = reasonID
        self.reasonDescription = reasonDescription
        self.documentFileName = documentFileName == nil ? "" : documentFileName
    }
    
    // home calender Data
    init(token: String?, employeeId: String?, date: String?) {
        self.token = token
        self.employeeId = employeeId
        self.date = date
    }
    // for getting no of leaves count
    init(employeeID: String?, leavetypeID: String?, fromDate: String?, toDate: String?, isFirstHalf: String?, isSecondHalf: String?) {
        
        self.employeeID = employeeID
        self.leavetypeID = leavetypeID
        self.fromDate = fromDate
        self.toDate = toDate
        self.isFirstHalf = isFirstHalf
        self.isSecondHalf = isSecondHalf
    }
    // GetReasonsAccordingToLeaveType
    init(leaveTypeID: String?) {
        self.leaveTypeID = leaveTypeID
    }
    // GetLeaveApplicationForApproval  and  GetLeaveTypeByEmployeeId
    init(employeeId: String?) {
        self.employeeId = employeeId
    }
    // GetAttendanceDetails
    init(employeeID: String?, fromDate: String?) {
        self.employeeID = employeeID
        self.fromDate = fromDate
    }
    
    // GetEmployeeHoursWeekWise
    init(employeeId: String?, token:String?, monthDate: String?) {
        self.employeeId = employeeId
        self.token = token
        self.monthDate = monthDate
    }
    
    // mark attadance
    init(swipeTime: String?, latitude:String?, longitude: String?, locationAddress: String?, swipeImageFileName: String?, isOnlineSwipe: String?, remark: String?, locationProvider: String?,door:String) {
        self.swipeTime = swipeTime
        self.latitude = latitude
        self.longitude = longitude
        self.locationAddress = locationAddress
        self.swipeImageFileName = swipeImageFileName
        self.isOnlineSwipe = isOnlineSwipe
        self.remark = remark
        self.locationProvider = locationProvider
    }
    
    // GetWorkFlowForLeaveApp
    init(employeeId: String?, token:String?, leaveTypeId: String?) {
        self.employeeId = employeeId
        self.token = token
        self.leaveTypeId = leaveTypeId
    }
    //GetLeaveApplicationList
    init(employeeID: String?) {
        self.employeeID = employeeID
    }
    
    ///GetShiftForRegularizeApplication and getting reason
    init(employeeId: String?,shiftDate: String?) {
        self.employeeId = employeeId
        self.shiftDate = shiftDate
    }
    
    
    // ApplyRegularizationApp
    init(employeeId: String?, token :String?, NoOfDays: String?,shiftDate :String?,ShiftDateFrom :String?,ShiftDateTo :String?,InDate :String?,OutDate :String?,InTime :String?,OutTime :String?,shiftID :String?,Remark :String?,RealInDateTime :String?,RealOutDateTime :String?,ReasonID :String?) {
        self.employeeId = employeeId
        self.token = token
        self.shiftDate = shiftDate
        self.NoOfDays = NoOfDays
        self.ShiftDateFrom = ShiftDateFrom
        self.ShiftDateTo = ShiftDateTo
        self.InDate = InDate
        self.OutDate = OutDate
        self.InTime = InTime
        self.OutTime = OutTime
        self.shiftID = shiftID
        self.Remark = Remark
        self.RealInDateTime = RealInDateTime
        self.RealOutDateTime = RealOutDateTime
        self.ReasonID = ReasonID
    }
    
    // ApplyCompensatoryOffApp  or  GetOutDutyApplicationForApproval
    init(employeeId: String?, token :String?, takenCompOffDate: String?,isFirstHalfCompOff :String?,isSecondHalfCompOff :String?,reasonDescription :String?,reasonID:String?,compOffAgainstDetails :String?) {
        self.employeeId = employeeId
        self.token = token
        self.takenCompOffDate = takenCompOffDate
        self.isFirstHalfCompOff = isFirstHalfCompOff
        self.isSecondHalfCompOff = isSecondHalfCompOff
        self.reasonDescription = reasonDescription
        self.reasonID = reasonID
        self.compOffAgainstDetails = compOffAgainstDetails
    }
    // GetCompOffAgainstDetails
    init(compOffID: String?, takenCODate:String?, isHrsOrdays: String?,isHalfDay:String?) {
        self.compOffID = compOffID
        self.takenCODate = takenCODate
        self.isHrsOrdays = isHrsOrdays
        self.isHalfDay = isHalfDay
    }
    ////// Out Duty ////////
    
    
    // ApplyOutDutyApp
    init(employeeId: String?, token :String?, fromDate: String?,fromTime :String?,toDate :String?,toTime:String?,reasonDescription :String?,outDutyAddress:String?,IsODAppInHours:String?,reasonID:String?){
        self.token = token
        self.employeeId = employeeId
        self.fromDate = fromDate
        self.fromTime = fromTime
        self.IsODAppInHours = IsODAppInHours
        self.reasonDescription = reasonDescription
        self.outDutyAddress = outDutyAddress
        self.toDate = toDate
        self.toTime = toTime
        self.reasonID = reasonID
    }
    
    // GetNoOfOutDutyAppDays
    init(fromDate: String?,toDate :String?) {
        self.fromDate = fromDate
        self.toDate = toDate
    }
    
    ////// Work from Home /////
    
    // ApplyWorkFromHomeApp
    
    init(employeeId: String?, token :String?, fromDate: String?,fromTime :String?,toDate :String?,toTime:String?,reasonDescription :String?,reasonID:String?,isConsiderTimeCross :String?,isFirstHalf :String?,isSecondHalf :String?,isWFHAppInHours :String?){
        
        self.token = token
        self.employeeId = employeeId
        self.fromDate = fromDate
        self.fromTime = fromTime
        self.reasonDescription = reasonDescription
        self.toDate = toDate
        self.toTime = toTime
        self.isConsiderTimeCross = isConsiderTimeCross
        self.reasonID = reasonID
        self.isFirstHalf =  isFirstHalf
        self.isSecondHalf =  isSecondHalf
        self.isWFHAppInHours = isWFHAppInHours
    }
    
    // GetNoOfWorkFromHomeDays
    init(fromDate: String?,toDate :String?,isFirstHalf :String?,isSecondHalf :String?){
        self.fromDate = fromDate
        self.toDate = toDate
        self.isFirstHalf =  isFirstHalf
        self.isSecondHalf =  isSecondHalf
    }
    
    //GetDateTimeDifferenceInHoursMinForMultipleDays
    init(fromDateTime: String?,toDateTime :String?,isConsiderTimeCross :String?,appForMultipleDays :String?){
        self.fromDateTime = fromDateTime
        self.toDateTime = toDateTime
        self.isConsiderTimeCross =  isConsiderTimeCross
        self.AppForMultipleDays =  appForMultipleDays
    }
    
    ////////  Application Approvals /////////
    // leave approve or reject
    init(LeaveAppID: String?,LeaveAppLevelDetailID :String?,statusID :String?,rejectRemark :String?,ByEmployeeID :String?){
        self.LeaveAppID = LeaveAppID
        self.LeaveAppLevelDetailID = LeaveAppLevelDetailID
        self.statusID = statusID
        self.rejectRemark = rejectRemark
        self.ByEmployeeID = ByEmployeeID
    }
    
    // WFH approve or reject
    init(WorkFromHomeAppID: String?,WorkFromHomeAppLevelDetailID :String?,statusID :String?,rejectRemark :String?,ByEmployeeID :String?){
        self.WorkFromHomeAppID = WorkFromHomeAppID
        self.WorkFromHomeAppLevelDetailID = WorkFromHomeAppLevelDetailID
        self.statusID = statusID
        self.rejectRemark = rejectRemark
        self.ByEmployeeID = ByEmployeeID
    }
    
    // Attendance Reg approve or reject
    init(RegularizationAppID: String?,RegularizationAppLevelDetailID :String?,statusID :String?,rejectRemark :String?,ByEmployeeID :String?,DayStatusID :String?,IsDayStatusOverride :String?){
        
        self.RegularizationAppID = RegularizationAppID
        self.RegularizationAppLevelDetailID = RegularizationAppLevelDetailID
        self.DayStatusID = DayStatusID
        self.IsDayStatusOverride = IsDayStatusOverride
        self.statusID = statusID
        self.rejectRemark = rejectRemark
        self.ByEmployeeID = ByEmployeeID
    }
    // OutDuty approve or reject
    init(OutDutyAppID: String?, OutDutyAppLevelDetailID :String?,statusID :String?,rejectRemark :String?,ByEmployeeID :String?){
        self.OutDutyAppID = OutDutyAppID
        self.OutDutyAppLevelDetailID = OutDutyAppLevelDetailID
        self.statusID = statusID
        self.rejectRemark = rejectRemark
        self.ByEmployeeID = ByEmployeeID
    }
    
    // CompOff approve or reject
    init(CompensatoryOffAppID: String?,CompensatoryOffAppLevelDetailID :String?,statusID :String?,rejectRemark :String?,ByEmployeeID :String?){
        self.CompensatoryOffAppID = CompensatoryOffAppID
        self.CompensatoryOffAppLevelDetailID = CompensatoryOffAppLevelDetailID
        self.statusID = statusID
        self.rejectRemark = rejectRemark
        self.ByEmployeeID = ByEmployeeID
    }
    
    // Getting My Shift Data // subordinate summary
    init(employeeId: String?,fromDate: String?, toDate: String?) {
        self.employeeId = employeeId
        self.fromDate = fromDate
        self.toDate = toDate
    }
    
    // For generate OTP & For Login With OTP
    init(userName: String?, OTP: String?, deviceId: String?, employeeCode: String?) {
        self.userName = userName
        self.OTP = OTP
        self.employeeCode = employeeCode
        self.deviceId = deviceId
    }
    
    // for Allocating Shift->for Shift Allocation
    init(allocatedToEmployeeCode: String?, shiftDate: String?, shiftName: String?, createdByEmployeeID: String?, token: String?) {
        self.allocatedToEmployeeCode = allocatedToEmployeeCode
        self.shiftDate = shiftDate
        self.shiftName = createdByEmployeeID
        self.createdByEmployeeID = createdByEmployeeID
        self.token = token
    }
    //MARK:for Changed password
    init(userName: String?, employeeCode: String?,deviceId:String?,token:String?,oldPass:String?,newPass:String?,confirmPass:String?) {
        self.userName = userName
        self.employeeCode = employeeCode
        self.deviceId = deviceId
        self.token = token
        self.oldPassword = oldPass
        self.newChangedPassword = newPass
        self.confirmPassword = confirmPass
    }
    
    //MARK:for Forgot password
       init(userName: String?, employeeCode: String?,deviceId:String?) {
           self.userName = userName
           self.employeeCode = employeeCode
           self.deviceId = deviceId
        
       }
    
    //MARK:for GetLeavePolicyDetail
    init(employeeId: String?,leaveTypeID:String?,gender:String?,token:String?) {
           self.gender = gender
           self.employeeId = employeeId
           self.leavetypeID = leaveTypeID
           self.token = token
       }
    
    //MARK:LocationUpdate in tracking  code on 25-07-2021
       init(employeeId: String?, deviceid: String?,latitude:String?, longitude: String?, locationAddress: String?,locationProvider: String?) {
           self.employeeId = employeeId
           self.deviceId = deviceid
           self.latitude = latitude
           self.longitude = longitude
           self.locationAddress = locationAddress
           self.locationProvider = locationProvider
       }
    
    
    func toJSON() -> [String: Any] {
        let json = ["id": id,
                    "firstName": firstName,
                    "lastName": lastName,
                    "gender": gender,
                    "email": email,
                    "altNumber": additionalMobileNo,
                    "password": password,
                    //"deviceOs": deviceOs,
            //  "deviceType": deviceType,
            //  "appVersion": appVersion,
            //  "deviceName": deviceName,
            "token": token,
            //"lang": lang,
            "company": companyName,
            "new_password": newPassword,
            "date": date,
            "deviceId" :deviceId,
            "licenseNumber":licenseNumber,
            "FCMID":FCMID,
            "monthDate":monthDate,
            
            "employeeCode": employeeCode,
            "mobileNumber": mobileNumber,
            "companyCode": companyCode,
            "registrationType": registrationType,
            "deviceID": deviceID,
            "userName": userName,
            "employeeId": employeeId,
            "fromDate": fromDate,
            "toDate": toDate,
            "isFirstHalfLeave": isFirstHalfLeave,
            "isSecondHalfLeave": isSecondHalfLeave,
            "leaveTypeID": leaveTypeID,
            "noOfLeaveDays": noOfLeaveDays,
            "reasonID": reasonID,
            "reasonDescription": reasonDescription,
            "employeeID": employeeID,
            "leavetypeID":  leavetypeID,
            "isFirstHalf": isFirstHalf,
            "isSecondHalf": isSecondHalf,
            "leaveTypeId": leaveTypeId,
            "swipeTime":swipeTime,
            "latitude":latitude,
            "longitude":  longitude,
            "locationAddress" : locationAddress,
            "swipeImageFileName": swipeImageFileName,
            "isOnlineSwipe": isOnlineSwipe,
            "remark": remark,
            "locationProvider": locationProvider,
            "door":door,
            "shiftDate":shiftDate,
            "NoOfDays": NoOfDays,
            "ShiftDateFrom": ShiftDateFrom,
            "ShiftDateTo": ShiftDateTo,
            "InDate": InDate,
            "OutDate": OutDate,
            "InTime": InTime,
            "OutTime": OutTime,
            "shiftID": shiftID,
            "Remark": Remark,
            "RealInDateTime": RealInDateTime,
            "RealOutDateTime":RealOutDateTime,
            "ReasonID": ReasonID,
            "takenCompOffDate":takenCompOffDate,
            "isFirstHalfCompOff": isFirstHalfCompOff,
            "isSecondHalfCompOff":isSecondHalfCompOff,
            "compOffAgainstDetails":compOffAgainstDetails,
            "compOffID": compOffID,
            "isHrsOrdays": isHrsOrdays,
            "isHalfDay": isHalfDay,
            "takenCODate": takenCODate,
            "fromTime": fromTime,
            "toTime": toTime,
            "IsODAppInHours": IsODAppInHours,
            "outDutyAddress": outDutyAddress,
            "isConsiderTimeCross": isConsiderTimeCross,
            "isWFHAppInHours": isWFHAppInHours,
            "fromDateTime": fromDateTime,
            "toDateTime": toDateTime,
            "AppForMultipleDays": AppForMultipleDays,
            "LeaveAppID": LeaveAppID,
            "LeaveAppLevelDetailID": LeaveAppLevelDetailID,
            "statusID": statusID,
            "rejectRemark": rejectRemark,
            "ByEmployeeID": ByEmployeeID,
            "RegularizationAppID": RegularizationAppID,
            "RegularizationAppLevelDetailID": RegularizationAppLevelDetailID,
            "DayStatusID": DayStatusID,
            "IsDayStatusOverride": IsDayStatusOverride,
            "CompensatoryOffAppID": CompensatoryOffAppID,
            "CompensatoryOffAppLevelDetailID": CompensatoryOffAppLevelDetailID,
            "OutDutyAppID": OutDutyAppID,
            "OutDutyAppLevelDetailID": OutDutyAppLevelDetailID,
            "WorkFromHomeAppID": WorkFromHomeAppID,
            "WorkFromHomeAppLevelDetailID": WorkFromHomeAppLevelDetailID,
            "OTP":OTP,
            "allocatedToEmployeeCode":allocatedToEmployeeCode,
            "shiftName":shiftName,
            "createdByEmployeeID":createdByEmployeeID,
            "documentFileName" :documentFileName,
            
            "oldPassword":oldPassword,
            "newPassword":newChangedPassword,
            "confirmPassword":confirmPassword
        ]
        return json.filterNil()
    }
}




