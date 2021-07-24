//
//  UtilityManager.swift
//  emSphere
//
//  Created by Dhiraj Chaudhari on 08/05/21.
//  Copyright © 2021 Dhiraj Chaudhari. All rights reserved.
//

import Foundation
class UtilityManager {
    
    class func didSaveConfiguartionData(dicArray:[NSDictionary]?){
        if let confiDicArray = dicArray{
            for index in 0..<confiDicArray.count {
                let  dic = confiDicArray[index]
                print("dic in loop=",dic)
                
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
        }
    }
}
