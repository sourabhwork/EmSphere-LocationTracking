//
//  UserProfile.swift
//  GoldenSpoon
//
//  Created by IARIANA TECHNOLOGIES PVT LTD on 2/5/18.
//  Copyright © 2018 iAriana Technologies Pvt. Ltd. All rights reserved.

import Foundation
import UIKit

class UserProfile {

    
    static func saveUserName(username: String?) {
        if let uname = username{
            UserDefaults.standard.set(uname, forKey: "UserName")
            UserDefaults.standard.synchronize()
        }
    }
    
    static func getUserName()->String? {
         let userName = UserDefaults.standard.value(forKeyPath: "UserName")as? String
        return userName
       }
//Store login Token
    static func saveLoginToken(token: String?) {
        guard let userData = token else {
            print("Empty user data")
            return
        }
        // remove privious obj & add new one
        if UserDefaults.standard.value(forKey: "LOGIN_TOKEN") != nil {
            UserDefaults.standard.removeObject(forKey: "LOGIN_TOKEN")
        }
        UserDefaults.standard.set(userData, forKey: "LOGIN_TOKEN")
        UserDefaults.standard.synchronize()
    }

    static func getLoginToken() -> String? {
        guard let userInfo = UserDefaults.standard.value(forKeyPath: "LOGIN_TOKEN") else {
            print("Empty user data")
            return nil
        }
        return userInfo as? String
    }

    //store remember me details
    static func saveRememberMe(userInfo: [String: Any]?) {
        guard let userData = userInfo else {
            print("Empty user data")
            return
        }
        // remove privious obj & add new one
        if UserDefaults.standard.value(forKey: "LOGIN_DATA") != nil {
            UserDefaults.standard.removeObject(forKey: "LOGIN_DATA")
        }
        UserDefaults.standard.set(userData, forKey: "LOGIN_DATA")
        UserDefaults.standard.synchronize()
    }

    static func getRemeberMe() -> [String: Any]?{
        guard let userInfo = UserDefaults.standard.value(forKeyPath: "LOGIN_DATA") else {
            print("Empty user data")
            return nil
        }
        return userInfo as? [String : Any]
    }

    //store registration details
    static func saveRegistrationDetails(userInfo: [String: String]?) {
        guard let userData = userInfo else {
            print("Empty user data")
            return
        }
        // remove privious obj & add new one
        if UserDefaults.standard.value(forKey: "REGISTRATION_DATA") != nil {
            UserDefaults.standard.removeObject(forKey: "REGISTRATION_DATA")
        }
        UserDefaults.standard.set(userData, forKey: "REGISTRATION_DATA")
        UserDefaults.standard.synchronize()
    }

    static func getRegistrationDetails() -> [String: String]? {
        guard let userInfo = UserDefaults.standard.value(forKeyPath: "REGISTRATION_DATA") else {
            print("Empty user data")
            return nil
        }
        return userInfo as? [String : String]
    }

    //store user profile details after enter licences key
    static func saveUserProfile(userInfo: [String: Any]?) {
        guard let userData = userInfo else {
            print("Empty user data")
            return
        }
        // remove privious obj & add new one
        if UserDefaults.standard.value(forKey: "USER_PROFILE_DATA") != nil {
            UserDefaults.standard.removeObject(forKey: "USER_PROFILE_DATA")
        }
        UserDefaults.standard.set(userData, forKey: "USER_PROFILE_DATA")
        UserDefaults.standard.synchronize()
    }

    static func getUserProfile() -> [String: String]? {
        guard let userInfo = UserDefaults.standard.value(forKeyPath: "USER_PROFILE_DATA") else {
            print("Empty user data")
            return nil
        }
        return userInfo as? [String: String]
    }

    static func saveServiceURL(url: String?) {
        guard let userData = url else {
            print("Empty user data")
            return
        }
        // remove privious obj & add new one
        if UserDefaults.standard.value(forKey: "SERVICE_URL") != nil {
            UserDefaults.standard.removeObject(forKey: "SERVICE_URL")
        }
        UserDefaults.standard.set(userData, forKey: "SERVICE_URL")
        UserDefaults.standard.synchronize()
    }

    static func getServiceURL() -> String? {
        guard let userInfo = UserDefaults.standard.value(forKeyPath: "SERVICE_URL") else {
            print("Empty user data")
            return nil
        }
        return userInfo as? String
    }

    //Store dynamic ApplicationArray
    static func saveApplicationArrayDic(applicationArrayDic: [String: [String]]?) {
        guard let userData = applicationArrayDic else {
            print("Empty user data")
            return
        }
        // remove privious obj & add new one
        if UserDefaults.standard.value(forKey: "APPLICATION_ARRAY") != nil {
            UserDefaults.standard.removeObject(forKey: "APPLICATION_ARRAY")
        }
        UserDefaults.standard.set(userData, forKey: "APPLICATION_ARRAY")
        UserDefaults.standard.synchronize()
    }

    static func getApplicationArrayDic() -> [String: [String]]? {
        guard let userInfo = UserDefaults.standard.value(forKeyPath: "APPLICATION_ARRAY") else {
            print("Empty user data")
            return nil
        }
        return userInfo as? [String: [String]]
    }
    static func isUserLoggedIn() -> Bool{
        if UserDefaults.standard.value(forKey: "USER_DATA") != nil {
            return true
        } else {
            return false
        }
    }

    //Store  REMARK
    static func saveIsRemark(status: String?) {
        guard let userData = status else {
            print("Empty user data")
            return
        }
        // remove privious obj & add new one
        if UserDefaults.standard.value(forKey: "IS_HIDEREMARK") != nil {
            UserDefaults.standard.removeObject(forKey: "IS_HIDEREMARK")
        }
        UserDefaults.standard.set(userData, forKey: "IS_HIDEREMARK")
        UserDefaults.standard.synchronize()
    }
    
    static func getIsRemark() -> String? {
        guard let userInfo = UserDefaults.standard.value(forKeyPath: "IS_HIDEREMARK") else {
            print("Empty user data")
            return nil
        }
        return userInfo as? String
    }
    
    //Store Location tracking time interval minute
    static func saveLocationTrackTime(status: String?) {
        guard let userData = status else {
            print("Empty user data")
            return
        }
        // remove privious obj & add new one
        if UserDefaults.standard.value(forKey: "locationTrack") != nil {
            UserDefaults.standard.removeObject(forKey: "locationTrack")
        }
        UserDefaults.standard.set(userData, forKey: "locationTrack")
        UserDefaults.standard.synchronize()
    }

    static func getLocationTrackTime() -> String? {
        guard let trackTime = UserDefaults.standard.value(forKeyPath: "locationTrack") else {
            print("Empty user data")
            return nil
        }
        return trackTime as? String
    }

    //Store ishideMarkAttendance
    static func saveIshideMarkAttendance(status: String?) {
        guard let userData = status else {
            print("Empty user data")
            return
        }
        // remove privious obj & add new one// ishideMarkAttendance
        if UserDefaults.standard.value(forKey: "IS_HIDEMARKATTEDANCE") != nil {
            UserDefaults.standard.removeObject(forKey: "IS_HIDEMARKATTEDANCE")
        }
        UserDefaults.standard.set(userData, forKey: "IS_HIDEMARKATTEDANCE")
        UserDefaults.standard.synchronize()
    }

    static func getIshideMarkAttendance() -> String? {
        guard let userInfo = UserDefaults.standard.value(forKeyPath: "IS_HIDEMARKATTEDANCE") else {
            print("Empty user data")
            return nil
        }
        return userInfo as? String
    }

    //Store IsHideLeaveApp
    static func saveIsHideLeaveApp(status: String?) {
        guard let userData = status else {
            print("Empty user data")
            return
        }
        // remove privious obj & add new one
        if UserDefaults.standard.value(forKey: "IS_HIDELEAVEAPP") != nil {
            UserDefaults.standard.removeObject(forKey: "IS_HIDELEAVEAPP")
        }
        UserDefaults.standard.set(userData, forKey: "IS_HIDELEAVEAPP")
        UserDefaults.standard.synchronize()
    }

    static func getIsHideLeaveApp() -> String? {
        guard let userInfo = UserDefaults.standard.value(forKeyPath: "IS_HIDELEAVEAPP") else {
            print("Empty user data")
            return nil
        }
        return userInfo as? String
    }

    //Store IsHideCompOffApp
    static func saveIsHideCompOffApp(status: String?) {
        guard let userData = status else {
            print("Empty user data")
            return
        }
        // remove privious obj & add new one
        if UserDefaults.standard.value(forKey: "IS_HIDECOMPOFF") != nil {
            UserDefaults.standard.removeObject(forKey: "IS_HIDECOMPOFF")
        }
        UserDefaults.standard.set(userData, forKey: "IS_HIDECOMPOFF")
        UserDefaults.standard.synchronize()
    }

    static func getIsHideCompOffApp() -> String? {
        guard let userInfo = UserDefaults.standard.value(forKeyPath: "IS_HIDECOMPOFF") else {
            print("Empty user data")
            return nil
        }
        return userInfo as? String
    }

    //Store IsHideRegularizationApp
    static func saveIsHideRegularizationApp(status: String?) {
        guard let userData = status else {
            print("Empty user data")
            return
        }
        // remove privious obj & add new one
        if UserDefaults.standard.value(forKey: "IS_HIDEATTEDANCEREG") != nil {
            UserDefaults.standard.removeObject(forKey: "IS_HIDEATTEDANCEREG")
        }
        UserDefaults.standard.set(userData, forKey: "IS_HIDEATTEDANCEREG")
        UserDefaults.standard.synchronize()
    }

    static func getIsHideRegularizationApp() -> String? {
        guard let userInfo = UserDefaults.standard.value(forKeyPath: "IS_HIDEATTEDANCEREG") else {
            print("Empty user data")
            return nil
        }
        return userInfo as? String
    } // 4


    //Store IsHideWFHApp
    static func saveIsHideWFHApp(status: String?) {
        guard let userData = status else {
            print("Empty user data")
            return
        }
        // remove privious obj & add new one
        if UserDefaults.standard.value(forKey: "IS_HIDEWFH") != nil {
            UserDefaults.standard.removeObject(forKey: "IS_HIDEWFH")
        }
        UserDefaults.standard.set(userData, forKey: "IS_HIDEWFH")
        UserDefaults.standard.synchronize()
    }

    static func getIsHideWFHApp() -> String? {
        guard let userInfo = UserDefaults.standard.value(forKeyPath: "IS_HIDEWFH") else {
            print("Empty user data")
            return nil
        }
        return userInfo as? String
    }

    //Store IsHideOutDutyApp
    static func saveIsHideOutDutyApp(status: String?) {
        guard let userData = status else {
            print("Empty user data")
            return
        }
        // remove privious obj & add new one
        if UserDefaults.standard.value(forKey: "IS_HIDEOUTDUTY") != nil {
            UserDefaults.standard.removeObject(forKey: "IS_HIDEOUTDUTY")
        }
        UserDefaults.standard.set(userData, forKey: "IS_HIDEOUTDUTY")
        UserDefaults.standard.synchronize()
    }

    static func getIsHideOutDutyApp() -> String? {
        guard let userInfo = UserDefaults.standard.value(forKeyPath: "IS_HIDEOUTDUTY") else {
            print("Empty user data")
            return nil
        }
        return userInfo as? String
    }

    //Store IsAllowLoginUsingOTP
    static func saveIsAllowLoginUsingOTP(status: String?) {
        guard let userData = status else {
            print("Empty user data")
            return
        }
        // remove privious obj & add new one
        if UserDefaults.standard.value(forKey: "Is_AllowLoginUsingOTP") != nil {
            UserDefaults.standard.removeObject(forKey: "Is_AllowLoginUsingOTP")
        }
        UserDefaults.standard.set(userData, forKey: "Is_AllowLoginUsingOTP")
        UserDefaults.standard.synchronize()
    }

    static func getIsAllowLoginUsingOTP() -> String? {
        guard let userInfo = UserDefaults.standard.value(forKeyPath: "Is_AllowLoginUsingOTP") else {
            print("Empty user data")
            return nil
        }
        return userInfo as? String
    }

    //Store IsSendOTPThroughSMS
    static func saveIsSendOTPThroughSMS(status: String?) {
        guard let userData = status else {
            print("Empty user data")
            return
        }
        // remove privious obj & add new one
        if UserDefaults.standard.value(forKey: "Is_SendOTPThroughSMS") != nil {
            UserDefaults.standard.removeObject(forKey: "Is_SendOTPThroughSMS")
        }
        UserDefaults.standard.set(userData, forKey: "Is_SendOTPThroughSMS")
        UserDefaults.standard.synchronize()
    }

    static func getIsSendOTPThroughSMS() -> String? {
        guard let userInfo = UserDefaults.standard.value(forKeyPath: "Is_SendOTPThroughSMS") else {
            print("Empty user data")
            return nil
        }
        return userInfo as? String
    }

    //Store IsSendOTPThroughEmail
    static func saveIsSendOTPThroughEmail(status: String?) {
        guard let userData = status else {
            print("Empty user data")
            return
        }
        // remove privious obj & add new one
        if UserDefaults.standard.value(forKey: "Is_SendOTPThroughEmail") != nil {
            UserDefaults.standard.removeObject(forKey: "Is_SendOTPThroughEmail")
        }
        UserDefaults.standard.set(userData, forKey: "Is_SendOTPThroughEmail")
        UserDefaults.standard.synchronize()
    }

    static func getIsSendOTPThroughEmail() -> String? {
        guard let userInfo = UserDefaults.standard.value(forKeyPath: "Is_SendOTPThroughEmail") else {
            print("Empty user data")
            return nil
        }
        return userInfo as? String
    }
    //Store IsSendOTPThroughEmail
    static func saveIsLogin(status: String?) {
        guard let userData = status else {
            print("Empty user data")
            return
        }
        // remove privious obj & add new one
        if UserDefaults.standard.value(forKey: "IS_LOGINBYOTP") != nil {
            UserDefaults.standard.removeObject(forKey: "IS_LOGINBYOTP")
        }
        UserDefaults.standard.set(userData, forKey: "IS_LOGINBYOTP")
        UserDefaults.standard.synchronize()
    }

    //Store Is_HideCameraForMarkAttendance
    static func saveIsHideCameraForMarkAttendance(status: String?) {
        guard let userData = status else {
            print("Empty user data")
            return
        }
        // remove privious obj & add new one
        if UserDefaults.standard.value(forKey: "Is_HideCameraForMarkAttendance") != nil {
            UserDefaults.standard.removeObject(forKey: "Is_HideCameraForMarkAttendance")
        }
        UserDefaults.standard.set(userData, forKey: "Is_HideCameraForMarkAttendance")
        UserDefaults.standard.synchronize()
    }

    static func getIsHideCameraForMarkAttendance() -> String? {
        guard let userInfo = UserDefaults.standard.value(forKeyPath: "Is_HideCameraForMarkAttendance") else {
            print("Empty user data")
            return nil
        }
        return userInfo as? String
    }// 1

    //Store Is_HideShiftAllocation
    static func saveIsHideShiftAllocation(status: String?) {
        guard let userData = status else {
            print("Empty user data")
            return
        }
        // remove privious obj & add new one
        if UserDefaults.standard.value(forKey: "Is_HideShiftAllocation") != nil {
            UserDefaults.standard.removeObject(forKey: "Is_HideShiftAllocation")
        }
        UserDefaults.standard.set(userData, forKey: "Is_HideShiftAllocation")
        UserDefaults.standard.synchronize()
    }

    static func getIsHideShiftAllocation() -> String? {
        guard let userInfo = UserDefaults.standard.value(forKeyPath: "Is_HideShiftAllocation") else {
            print("Empty user data")
            return nil
        }
        return userInfo as? String
    }// 2

    //Store Is_HideAttendanceDetails
    static func saveIsHideAttendanceDetails(status: String?) {
        guard let userData = status else {
            print("Empty user data")
            return
        }
        // remove privious obj & add new one
        if UserDefaults.standard.value(forKey: "Is_HideAttendanceDetails") != nil {
            UserDefaults.standard.removeObject(forKey: "Is_HideAttendanceDetails")
        }
        UserDefaults.standard.set(userData, forKey: "Is_HideAttendanceDetails")
        UserDefaults.standard.synchronize()
    }

    static func getIsHideAttendanceDetails() -> String? {
        guard let userInfo = UserDefaults.standard.value(forKeyPath: "Is_HideAttendanceDetails") else {
            print("Empty user data")
            return nil
        }
        return userInfo as? String
    } //3



    //Store Is_HideApplicationStatus
    static func saveIsHideApplicationStatus(status: String?) {
        guard let userData = status else {
            print("Empty user data")
            return
        }
        // remove privious obj & add new one
        if UserDefaults.standard.value(forKey: "Is_HideApplicationStatus") != nil {
            UserDefaults.standard.removeObject(forKey: "Is_HideApplicationStatus")
        }
        UserDefaults.standard.set(userData, forKey: "Is_HideApplicationStatus")
        UserDefaults.standard.synchronize()
    }

    static func getIsHideApplicationStatus() -> String? {
        guard let userInfo = UserDefaults.standard.value(forKeyPath: "Is_HideApplicationStatus") else {
            print("Empty user data")
            return nil
        }
        return userInfo as? String
    }//4


    static func saveIsHideDiscrepancies(status: String?) {
        guard let userData = status else {
            print("Empty user data")
            return
        }
        // remove privious obj & add new one
        if UserDefaults.standard.value(forKey: "Is_HideDiscrepancies") != nil {
            UserDefaults.standard.removeObject(forKey: "Is_HideDiscrepancies")
        }
        UserDefaults.standard.set(userData, forKey: "Is_HideDiscrepancies")
        UserDefaults.standard.synchronize()
    }
    
    static func saveShifSelectionInAttendanceRegularizationApp(status: String?) {
        guard let userData = status else {
            print("Empty user data")
            return
        }
        // remove privious obj & add new one
        if UserDefaults.standard.value(forKey: "AllowShifSelectionInAttendanceRegularizationApp") != nil {
            UserDefaults.standard.removeObject(forKey: "AllowShifSelectionInAttendanceRegularizationApp")
        }
        UserDefaults.standard.set(userData, forKey: "AllowShifSelectionInAttendanceRegularizationApp")
        UserDefaults.standard.synchronize()
    }
    
    static func getShifSelectionInAttendanceRegularizationApp() -> String? {
           guard let userInfo = UserDefaults.standard.value(forKeyPath: "AllowShifSelectionInAttendanceRegularizationApp") else {
               print("Empty user data")
               return nil
           }
           return userInfo as? String
       }//5
    
    
    //Store Is_HideDiscrepancies
    static func saveRegularizationAppDayStatusAsPerShiftPolicy(status: String?) {
        guard let userData = status else {
            print("Empty user data")
            return
        }
        // remove privious obj & add new one
        if UserDefaults.standard.value(forKey: "RegularizationAppDayStatusAsPerShiftPolicy") != nil {
            UserDefaults.standard.removeObject(forKey: "RegularizationAppDayStatusAsPerShiftPolicy")
        }
        UserDefaults.standard.set(userData, forKey: "RegularizationAppDayStatusAsPerShiftPolicy")
        UserDefaults.standard.synchronize()
    }
    
    static func getRegularizationAppDayStatusAsPerShiftPolicy() -> String? {
           guard let userInfo = UserDefaults.standard.value(forKeyPath: "RegularizationAppDayStatusAsPerShiftPolicy") else {
               print("Empty user data")
               return nil
           }
           return userInfo as? String
       }//5
    
  
    static func getIsHideDiscrepancies() -> String? {
        guard let userInfo = UserDefaults.standard.value(forKeyPath: "Is_HideDiscrepancies") else {
            print("Empty user data")
            return nil
        }
        return userInfo as? String
    }//5


    static func getIsLogin() -> String? {
        guard let userInfo = UserDefaults.standard.value(forKeyPath: "IS_LOGINBYOTP") else {
            print("Empty user data")
            return nil
        }
        return userInfo as? String
    }

    static func saveIsLogoutByOTP(status: String?) {
        guard let userData = status else {
            print("Empty user data")
            return
        }
        // remove privious obj & add new one
        if UserDefaults.standard.value(forKey: "IS_LOGOUTBYOTP") != nil {
            UserDefaults.standard.removeObject(forKey: "IS_LOGOUTBYOTP")
        }
        UserDefaults.standard.set(userData, forKey: "IS_LOGOUTBYOTP")
        UserDefaults.standard.synchronize()
    }

    //MARK:code on 01-05-2021 for hiding  barnc category,department,designation
    static func saveProfileInfoHideKeyValue(status: String?) {
        guard let userData = status else {
            print("Empty user data")
            return
        }
        // remove privious obj & add new one
        if UserDefaults.standard.value(forKey: "HideBranchCategoryDesignationDeptFROMhamburgerMenu") != nil {
            UserDefaults.standard.removeObject(forKey: "HideBranchCategoryDesignationDeptFROMhamburgerMenu")
        }
        UserDefaults.standard.set(userData, forKey: "HideBranchCategoryDesignationDeptFROMhamburgerMenu")
        UserDefaults.standard.synchronize()
    }
    
    static func getProfileInfoHideKeyValue() -> String? {
           guard let userInfo = UserDefaults.standard.value(forKeyPath: "HideBranchCategoryDesignationDeptFROMhamburgerMenu") else {
               print("Empty user data")
               return nil
           }
           return userInfo as? String
       }

    //MARK:code on 08-05-2021 for show and hide reason pop up on accpct butn of approvals vcs
    static func saveAddReasonOnApproveAppKeyValue(status: String?) {
        guard let userData = status else {
            print("Empty user data")
            return
        }
        // remove privious obj & add new one
        if UserDefaults.standard.value(forKey: "AddReasonOnApproveApp") != nil {
            UserDefaults.standard.removeObject(forKey: "AddReasonOnApproveApp")
        }
        UserDefaults.standard.set(userData, forKey: "AddReasonOnApproveApp")
        UserDefaults.standard.synchronize()
    }
    //MARK:Hide = 0 and show = 1 code on 08-05-2021
    static func getAddReasonOnApproveAppKeyValue() -> String? {
           guard let userInfo = UserDefaults.standard.value(forKeyPath: "AddReasonOnApproveApp") else {
               print("Empty user data")
               return nil
           }
           return userInfo as? String
       }
    
    ///
    static func getIsLogoutByOTP() -> String? {
        guard let userInfo = UserDefaults.standard.value(forKeyPath: "IS_LOGOUTBYOTP") else {
            print("Empty user data")
            return nil
        }
        return userInfo as? String
    }
    /////
    static func saveIsManager(status: String?) {
        guard let userData = status else {
            print("Empty user data")
            return
        }
        // remove privious obj & add new one
        if UserDefaults.standard.value(forKey: "IS_MANAGER") != nil {
            UserDefaults.standard.removeObject(forKey: "IS_MANAGER")
        }
        UserDefaults.standard.set(userData, forKey: "IS_MANAGER")
        UserDefaults.standard.synchronize()
    }

    static func getIsManager() -> String? {
        guard let userInfo = UserDefaults.standard.value(forKeyPath: "IS_MANAGER") else {
            print("Empty user data")
            return nil
        }
        return userInfo as? String
    }
    static func clearIsManager(){
        UserDefaults.standard.synchronize()
        if UserDefaults.standard.value(forKey: "IS_MANAGER") != nil {
            UserDefaults.standard.removeObject(forKey: "IS_MANAGER")
        }
        UserDefaults.standard.synchronize()
    }

    static func saveIsVisitToLocationVC(status: Bool?) {
        guard let userData = status else {
            print("Empty user data")
            return
        }
        // remove privious obj & add new one
        if UserDefaults.standard.value(forKey: "IS_VISITTOLOCATIONVC") != nil {
            UserDefaults.standard.removeObject(forKey: "IS_VISITTOLOCATIONVC")
        }
        UserDefaults.standard.set(userData, forKey: "IS_VISITTOLOCATIONVC")
        UserDefaults.standard.synchronize()
    }

    static func isVisitToLocationVC() -> Bool? {
        guard let userInfo = UserDefaults.standard.value(forKeyPath: "IS_VISITTOLOCATIONVC") else {
            print("Empty user data")
            return nil
        }
        return userInfo as? Bool
    }

    static func clearBadgeCount() {
        let defaults = UserDefaults.standard
        if((defaults.value(forKey: "NOTIFICATION_COUNT")) != nil) {
            defaults.removeObject(forKey: "NOTIFICATION_COUNT")
            defaults.set(nil, forKey: "NOTIFICATION_COUNT")
            defaults.synchronize()
        }
    }
    static func clearIsloginByOTP(){
        UserDefaults.standard.synchronize()
        if UserDefaults.standard.value(forKey: "IS_LOGOUTBYOTP") != nil {
        UserDefaults.standard.removeObject(forKey: "IS_LOGOUTBYOTP")
        }
        UserDefaults.standard.synchronize()
    }


    static func saveNotificatonConunt(status: String?) {
        guard let userData = status else {
            print("Empty user data")
            return
        }
        // remove privious obj & add new one
        if UserDefaults.standard.value(forKey: "NOTIFICATION_COUNT") != nil {
            UserDefaults.standard.removeObject(forKey: "NOTIFICATION_COUNT")
        }
        UserDefaults.standard.set(userData, forKey: "NOTIFICATION_COUNT")
        UserDefaults.standard.synchronize()
    }

    static func getNotificatonConunt() -> String? {
        guard let userInfo = UserDefaults.standard.value(forKeyPath: "NOTIFICATION_COUNT") else {
            print("Empty user data")
            return nil
        }
        return userInfo as? String
    }


    static func saveUDID(status: String?) {
        guard let userData = status else {
            print("Empty user data")
            return
        }
        // remove privious obj & add new one
        if UserDefaults.standard.value(forKey: "IS_UDID") != nil {
            UserDefaults.standard.removeObject(forKey: "IS_UDID")
        }
        UserDefaults.standard.set(userData, forKey: "IS_UDID")
        UserDefaults.standard.synchronize()
    }

    static func getUDID() -> String? {
        guard let userInfo = UserDefaults.standard.value(forKeyPath: "IS_UDID") else {
            print("Empty user data")
            return nil
        }
        return userInfo as? String
    }//NOTIFICATION_COUNT
    static func removeUserDetails() {
        if (UserProfile.getIsAllowLoginUsingOTP() != "1"){
        if UserDefaults.standard.value(forKey: "DEVICE_TOKEN") != nil {
            UserDefaults.standard.removeObject(forKey: "DEVICE_TOKEN")
        }
        UserDefaults.standard.synchronize()

        if UserDefaults.standard.value(forKey: "USER_DATA") != nil {
            UserDefaults.standard.removeObject(forKey: "USER_DATA")
        }
        UserDefaults.standard.synchronize()

        if UserDefaults.standard.value(forKey: "NOTIFICATION_COUNT") != nil {
            UserDefaults.standard.removeObject(forKey: "NOTIFICATION_COUNT")
        }
        UserDefaults.standard.synchronize()

        if UserDefaults.standard.value(forKey: "LOGIN_TOKEN") != nil {
            UserDefaults.standard.removeObject(forKey: "LOGIN_TOKEN")
        }
        UserDefaults.standard.synchronize()

        if UserDefaults.standard.value(forKey: "LOGIN_DATA") != nil {
            UserDefaults.standard.removeObject(forKey: "LOGIN_DATA")
        }
        UserDefaults.standard.synchronize()

            if UserDefaults.standard.value(forKey: "USER_PROFILE_DATA") != nil {
                UserDefaults.standard.removeObject(forKey: "USER_PROFILE_DATA")
            }
            UserDefaults.standard.synchronize()

            if UserDefaults.standard.value(forKey: "REGISTRATION_DATA") != nil {
                UserDefaults.standard.removeObject(forKey: "REGISTRATION_DATA")
                
            }
            UserDefaults.standard.synchronize()
            if UserDefaults.standard.value(forKey: "IS_UDID") != nil {
                UserDefaults.standard.removeObject(forKey: "IS_UDID")
            }
            UserDefaults.standard.synchronize()



        if UserDefaults.standard.value(forKey: "APPLICATION_ARRAY") != nil {
            UserDefaults.standard.removeObject(forKey: "APPLICATION_ARRAY")
        }
        UserDefaults.standard.synchronize()

        if UserDefaults.standard.value(forKey: "USER_DATA") != nil {
            UserDefaults.standard.removeObject(forKey: "USER_DATA")
        }
        UserDefaults.standard.synchronize()

        if UserDefaults.standard.value(forKey: "IS_HIDEREMARK") != nil {
            UserDefaults.standard.removeObject(forKey: "IS_HIDEREMARK")
        }
        UserDefaults.standard.synchronize()

        if UserDefaults.standard.value(forKey: "IS_HIDEMARKATTEDANCE") != nil {
            UserDefaults.standard.removeObject(forKey: "IS_HIDEMARKATTEDANCE")
        }
        UserDefaults.standard.synchronize()

        if UserDefaults.standard.value(forKey: "IS_HIDELEAVEAPP") != nil {
            UserDefaults.standard.removeObject(forKey: "IS_HIDELEAVEAPP")
        }
        UserDefaults.standard.synchronize()

        if UserDefaults.standard.value(forKey: "IS_HIDECOMPOFF") != nil {
            UserDefaults.standard.removeObject(forKey: "IS_HIDECOMPOFF")
        }
        UserDefaults.standard.synchronize()

        if UserDefaults.standard.value(forKey: "IS_HIDEATTEDANCEREG") != nil {
            UserDefaults.standard.removeObject(forKey: "IS_HIDEATTEDANCEREG")
        }
        UserDefaults.standard.synchronize()

        if UserDefaults.standard.value(forKey: "IS_HIDEWFH") != nil {
            UserDefaults.standard.removeObject(forKey: "IS_HIDEWFH")
        }
        UserDefaults.standard.synchronize()

        if UserDefaults.standard.value(forKey: "IS_HIDEOUTDUTY") != nil {
            UserDefaults.standard.removeObject(forKey: "IS_HIDEOUTDUTY")
        }
        UserDefaults.standard.synchronize()

        if UserDefaults.standard.value(forKey: "Is_SendOTPThroughEmail") != nil {
            UserDefaults.standard.removeObject(forKey: "Is_SendOTPThroughEmail")
        }

        UserDefaults.standard.synchronize()
        if UserDefaults.standard.value(forKey: "Is_AllowLoginUsingOTP") != nil {
            UserDefaults.standard.removeObject(forKey: "Is_AllowLoginUsingOTP")
        }
        UserDefaults.standard.synchronize()
        if UserDefaults.standard.value(forKey: "Is_SendOTPThroughSMS") != nil {
            UserDefaults.standard.removeObject(forKey: "Is_SendOTPThroughSMS")
        }

        UserDefaults.standard.synchronize()
        if UserDefaults.standard.value(forKey: "IS_LOGINBYOTP") != nil {
            UserDefaults.standard.removeObject(forKey: "IS_LOGINBYOTP")
        }
        UserDefaults.standard.synchronize()
        if UserDefaults.standard.value(forKey: "IS_VISITTOLOCATIONVC") != nil {
            UserDefaults.standard.removeObject(forKey: "IS_VISITTOLOCATIONVC")
        }
        UserDefaults.standard.synchronize()
            if UserDefaults.standard.value(forKey: "IS_LOGOUTBYOTP") != nil {
                UserDefaults.standard.removeObject(forKey: "IS_LOGOUTBYOTP")
            }
            UserDefaults.standard.synchronize()
           
    }
        if UserDefaults.standard.value(forKey: "SERVICE_URL") != nil {
            UserDefaults.standard.removeObject(forKey: "SERVICE_URL")
        }
        UserDefaults.standard.synchronize()

  }
    
    static func userIsLogin(value: Bool) {
        let userDefault = UserDefaults.standard
        userDefault.bool(forKey: "isUserLogin")
        userDefault.synchronize()
    }
    
    static func getUserIsLogin()->Bool {
        var value = false
        let userDefaults = UserDefaults.standard
        value = userDefaults.bool(forKey: "isUserLogin")
        userDefaults.synchronize()
        return value
    }
}
