//
//  MarkAttendanceInfo.swift
//  emSphere
//
//  Created by Dhiraj Chaudhari on 25/05/18.
//  Copyright © 2018 Dhiraj Chaudhari. All rights reserved.
//

import UIKit

class MarkAttendanceInfo: NSObject {
   // Mark Attendance Deatils

    var swipeTime = ""
    var latitude = ""
    var longitude = ""
    var locationAddress = ""
    var swipeImageFileName = ""
    var isOnlineSwipe = ""
    var remark:  String = ""
    var locationProvider = ""
    var door = ""
    var employeeId = ""
    var deviceId = ""
    var id = "" //its used for offline db purpose
    // MarkAttendanceHistoryTable
    var markAttendanceEmpId = ""
    var markDate = ""
    var markTime = ""
    var markStatus = ""
    var serverSyncStatus = ""


    func getInfoObjectFromDictionary(parameterDic:[String:String])-> MarkAttendanceInfo
    {
        let attedanceInfo = MarkAttendanceInfo()
        attedanceInfo.swipeTime = parameterDic["swipeTime"]! //"25-may-2016"
        attedanceInfo.latitude = parameterDic["latitude"]!  //"18.507399"
        attedanceInfo.longitude = parameterDic["longitude"]!//"73.807650"
        attedanceInfo.locationAddress = parameterDic["locationAddress"]!//"Pune"
        attedanceInfo.swipeImageFileName = parameterDic["swipeImageFileName"]!//encodedImageData!
        attedanceInfo.isOnlineSwipe = parameterDic["isOnlineSwipe"]!//"True"
        attedanceInfo.remark = parameterDic["remark"]!//"IN"
        attedanceInfo.locationProvider = parameterDic["locationProvider"]!//"GPS"
        attedanceInfo.door = parameterDic["door"]!///"1"

        return attedanceInfo
    }

    // getDictinary fron info object
    func getParameterDictionaryFromInfoObject(attedanceInfo:MarkAttendanceInfo)-> [String:String]
    {
        var parameterDic = [String:String]()


        parameterDic["swipeTime"] = attedanceInfo.swipeTime
        parameterDic["latitude"] = attedanceInfo.latitude
        parameterDic["longitude"] =  attedanceInfo.longitude
        parameterDic["locationAddress"] =  attedanceInfo.locationAddress
        parameterDic["swipeImageFileName"] = attedanceInfo.swipeImageFileName
        parameterDic["isOnlineSwipe"] = attedanceInfo.isOnlineSwipe
        parameterDic["remark"] = attedanceInfo.remark
        parameterDic["locationProvider"] = attedanceInfo.locationProvider
        parameterDic["door"] = attedanceInfo.door

        return parameterDic
    }

   
}
