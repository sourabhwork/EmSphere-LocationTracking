//
//  DataBaseHandler.swift
//  FMDB_Demoa-swift4
//
//  Created by Dhiraj Chaudhari on 18/04/18.
//  Copyright © 2018 Dhiraj Chaudhari. All rights reserved.
//

import UIKit
import Foundation
import FMDB
class DataBaseHandler: NSObject {
    
    
    static let shared: DataBaseHandler = DataBaseHandler()
    
    let databaseFileName = "EmsphereDatabase.sqlite"
    
    var pathToDatabase: String!
    
    var database: FMDatabase!
    
    
    override init() {
        super.init()
        
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        pathToDatabase = documentsDirectory.appending("/\(databaseFileName)")
    }
    
    
    func deleteData(query:String)->Bool {
        var updated = false
        if openDatabase() {
            
            // var query=""
            if !database.executeStatements(query) {
                print("Failed to insert initial data into the database.")
                print(database.lastError(), database.lastErrorMessage())
            }else{
                
                print("Successfully Deleted")
                updated = true
            }
            
            
            database.close()
        }
        return updated
    }
    func createTable(query:String) -> Bool {
        var created = false
        
        // if !FileManager.default.fileExists(atPath: pathToDatabase) {
        database = FMDatabase(path: pathToDatabase!)
        
        if database != nil {
            // Open the database.
            if database.open() {
                let createMoviesTableQuery = query
                
                do {
                    try database.executeUpdate(createMoviesTableQuery, values: nil)
                    created = true
                }
                catch {
                    print("Could not create table.")
                    print(error.localizedDescription)
                }
                
                database.close()
            }
            else {
                print("Could not open the database.")
            }
        }
        // }
        
        return created
    }
    
    
    func openDatabase() -> Bool {
        if database == nil {
            if FileManager.default.fileExists(atPath: pathToDatabase) {
                database = FMDatabase(path: pathToDatabase)
            }
        }
        
        if database != nil {
            if database.open() {
                return true
            }
        }
        
        return false
    }
    
    
    func insertData(query:String)->Bool {
        var inserted = false
        if openDatabase() {
            
            // let query=("insert into IMAGES(name,image) VALUES (?,?)", "Dhiraj chaudhari", imageData)
            // let result = DataBaseHandler.shared.insertData(query: query)
            // var query=""
            if !database.executeStatements(query) {
                print("Failed to insert initial data into the database.")
                print(database.lastError(), database.lastErrorMessage())
                
            }else{
                
                print("Successfully inserted")
                inserted = true
            }
            
            
            database.close()
        }
        return inserted
    }
    
    
    func updateData(query:String)->Bool {
        var updated = false
        if openDatabase() {
            
            // var query=""
            if !database.executeStatements(query) {
                print("Failed to insert initial data into the database.")
                print(database.lastError(), database.lastErrorMessage())
            }else{
                
                print("Successfully Upadted")
                updated = true
            }
            
            
            database.close()
        }
        return updated
    }
    func fetchData(query:String)->Bool  {
        var fetched=false
        print("fetch query = ",query)
        if openDatabase() {
            //let query = query
            
            //"select * from movies order by \(field_MovieYear) asc"
            
            do {
                print(database)
                let results = try database.executeQuery(query, values: nil)
                
                while results.next() {
                    let id = results.string(forColumn: "id")
                    let name = results.string(forColumn: "Name")
                    let marks = results.string(forColumn: "Marks")
                    
                    print("id='\(id)',name='\(name)',marks='\(marks)'")
                }
                fetched=true
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
        return fetched
        
    }
    
    
    func fetchImageData(query: String)-> UIImage?  {
        // var fetched=false
        var image:UIImage?=nil
        print("fetch query = ",query)
        if openDatabase() {
            //let query = query
            
            //"select * from movies order by \(field_MovieYear) asc"
            
            do {
                print(database)
                let results = try database.executeQuery(query, values: nil)
                
                while results.next() {
                    let name = results.string(forColumn: "name")
                    let imagedata = results.string(forColumn: "image")
                    print("name",name)
                    print("imageData=",imagedata)
                    if ((imagedata) != nil)
                    {
                        print("Image data is not nil")
                    }
                    else
                    {
                        print("Image data is  nil")
                    }
                    
                    let datas = Data(base64Encoded: imagedata!, options: .ignoreUnknownCharacters)
                    if((datas) != nil)
                    {
                        print(" datas is not nil")
                        image=UIImage(data:datas!)
                    }
                    else{
                        print(" datas is nil")
                    }
                    
                    print("image=",image)
                    print("name='\(name)',imagedata='\(imagedata)'")
                }
                return image
            }
            catch {
                print("fetch error=",error.localizedDescription)
            }
            
            database.close()
        }
        return image
        
    }
    
    func deleteMovie(withID ID: Int) -> Bool {
        var deleted = false
        
        if openDatabase() {
            let query = ""
            //"delete from movies where \(field_MovieID)=?"
            
            do {
                try database.executeUpdate(query, values: [ID])
                deleted = true
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
        
        return deleted
    }
    
    
    
    func addMarkAttendanceData(_ MarkAttendanceInfo: MarkAttendanceInfo) -> Bool {
        
        var inserted = false
        
        if openDatabase() {
            
            //"delete from movies where \(field_MovieID)=?"
            
            //  do {
            
            let isInserted = database!.executeUpdate("INSERT INTO OfflineAttendanceMark(swipeTime, latitude,longitude,locationAddress,swipeImageFileName,isOnlineSwipe,remark,locationProvider,door) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)", withArgumentsIn: [MarkAttendanceInfo.swipeTime, MarkAttendanceInfo.latitude,MarkAttendanceInfo.longitude,MarkAttendanceInfo.locationAddress,MarkAttendanceInfo.swipeImageFileName,MarkAttendanceInfo.isOnlineSwipe,MarkAttendanceInfo.remark,MarkAttendanceInfo.locationProvider,MarkAttendanceInfo.door])
            
            print("isInserted=",isInserted)
            inserted = isInserted
            //}
            /*
             catch {
             print(error.localizedDescription)
             return inserted
             }
             */
            database.close()
        }
        
        return inserted
    }
    
    
    func addMarkAttendanceHistryData(_ OfflineMarkAttendanceInfo: MarkAttendanceInfo) -> Bool {
        
        var inserted = false
        if openDatabase() {
            
            
            //do {
            let offlineMarId = OfflineMarkAttendanceInfo.id  //MARK:code on 20-March-2021 for saving mark id and server updated status just like whats if it is sync or updated to server then accoroding it set values
            let serverSatus = OfflineMarkAttendanceInfo.isOnlineSwipe == "True" ? "1":"0"
            //  attendanceId TEXT,serverSyncStatus TEXT"
            let isInserted = database!.executeUpdate("INSERT INTO MarkAttendanceHistory(markAttendanceEmpId, markDate,markTime,markStatus,attendanceId,serverSyncStatus) VALUES (?, ?, ?, ?,?,?)", withArgumentsIn: [OfflineMarkAttendanceInfo.markAttendanceEmpId, OfflineMarkAttendanceInfo.markDate,OfflineMarkAttendanceInfo.markTime,OfflineMarkAttendanceInfo.markStatus,offlineMarId,serverSatus])
            
            print("isInserted=",isInserted)
            inserted = isInserted
            //}
            /*
             catch {
             print(error.localizedDescription)
             return inserted
             } */
            
            database.close()
        }
        
        return inserted
    }
    
    
    func getOfflineAttendanceMarkData(query : String) -> NSMutableArray {
        
        let markAttedanceInfoArray : NSMutableArray = NSMutableArray()
        
        if openDatabase() {
            
            
            do {
                
                // let results = try database.executeQuery("SELECT * FROM OfflineAttendanceMark", value: nil)
                let results = try database.executeQuery(query, values: nil)
                
                //let results = database!.executeQuery("SELECT * FROM OfflineAttendanceMark", withArgumentsIn: nil)
                
                while results.next() {
                    
                    let attedanceInfo : MarkAttendanceInfo =  MarkAttendanceInfo()
                    attedanceInfo.id = results.string(forColumn: "id") ?? ""
                    attedanceInfo.swipeTime = results.string(forColumn: "swipeTime")!
                    print("swipe time =",attedanceInfo.swipeTime)
                    attedanceInfo.latitude = results.string(forColumn: "latitude")!
                    //attedanceInfo.Marks = results.string(forColumn: "Marks")!
                    
                    attedanceInfo.longitude = results.string(forColumn: "longitude")!
                    
                    attedanceInfo.locationAddress = results.string(forColumn: "locationAddress")!
                    
                    attedanceInfo.swipeImageFileName = results.string(forColumn: "swipeImageFileName")!
                    
                    attedanceInfo.isOnlineSwipe = results.string(forColumn: "isOnlineSwipe")!
                    attedanceInfo.remark = results.string(forColumn: "remark")!
                    attedanceInfo.locationProvider = results.string(forColumn: "locationProvider")!
                    attedanceInfo.door = results.string(forColumn: "door")!
                    
                    print("attendancec locationProdier=",attedanceInfo.locationProvider)
                     print("attedanceInfo.id = \(attedanceInfo.id)")
                    
                    markAttedanceInfoArray.add(attedanceInfo)
                    
                }
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
        
        return markAttedanceInfoArray
        
    }
    
    /////////
    
    
    func getPunchHistoryData(query: String) -> NSMutableArray {
        
        let markAttedanceInfoArray : NSMutableArray = NSMutableArray()
        
        if openDatabase() {
            
            //"delete from movies where \(field_MovieID)=?"
            
            do {
                
                // let results = try database.executeQuery("SELECT * FROM OfflineAttendanceMark", value: nil)
                let results = try database.executeQuery(query, values: nil)
                
                //let results = database!.executeQuery("SELECT * FROM OfflineAttendanceMark", withArgumentsIn: nil)
                //  attendanceId TEXT,serverSyncStatus TEXT"
                while results.next() {
                    
                    let attedanceInfo : MarkAttendanceInfo =  MarkAttendanceInfo()
                    
                    attedanceInfo.markAttendanceEmpId = results.string(forColumn: "markAttendanceEmpId") ?? ""
                    print("markAttendanceEmpId =",attedanceInfo.markAttendanceEmpId)
                    attedanceInfo.markDate = results.string(forColumn: "markDate")!
                    //attedanceInfo.Marks = results.string(forColumn: "Marks")!
                    attedanceInfo.markTime = results.string(forColumn: "markTime")!
                    attedanceInfo.markStatus = results.string(forColumn: "markStatus")!
                    //MARK:code chnaged on 20-March-2021
                    attedanceInfo.id = results.string(forColumn: "attendanceId") ?? ""
                    attedanceInfo.serverSyncStatus = results.string(forColumn: "serverSyncStatus") ?? ""
                    print("attedanceInfo.serverSyncStatus =\(attedanceInfo.serverSyncStatus) and attedanceInfo.id \(attedanceInfo.id)")
                    markAttedanceInfoArray.add(attedanceInfo)
                    
                }
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
        
        
        return markAttedanceInfoArray
        
    }
    
    
    
    
}
