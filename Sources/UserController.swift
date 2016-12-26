import Kitura
import MiniPromiseKit
import SwiftyJSON

class UserController {
    
    func makeRoutes(router : Router){
        
        router.post("/name") { request, response, next in
            guard let parsedBody = request.body else {
                next()
                return
            }
            switch(parsedBody) {
            case .json(let jsonBody):
                let name = jsonBody["name"].string ?? ""
                try response.send("Hello \(name)").end()
            default:
                break
            }
            next()
        }
        router.get("/pendingActivation", handler: pendingActivation)
        router.get("/pendingActivation2", handler: pendingActivation2)
    }
    
    func pendingActivation2(request: RouterRequest, response: RouterResponse, next: () -> Void) {
        //do query here
        let database = Database()
        firstly {
            database.queryUsers(with: Database.allUsersPendingActivation())
            }.then { users in
                print("Returned Users are \(users)")
                
        }
    }
    
    //users is not used 
    //this uses Swift Kuery but 
    // irar We don’t support that. It will be a part of the ORM layer above Swift-Kuery. For now you need to convert the rows returned from the db into your class/struct.
    func users(_ callback:@escaping (String)->Void) -> Void {
        connection.connect() { error in
            if let error = error {
                callback("Error is \(error)")
                return
            }
            else {
                // Build and execute your query here.
                // First build query
                let query = Database.allUsersPendingActivation()
                
                connection.execute(query: query) { result in
                    if let resultSet = result.asResultSet {
                        
                        var returnJSON = [String: Any]()
                        var returnJSONList = [[String: Any]]()
                        
                        var retString = ""
                        /*
                         for title in resultSet.titles {
                         
                         }
                         */
                        retString.append("\n")
                        
                        for row in resultSet.rows {
                            /*for value in row {
                             if let value = value as? String {
                             retString.append(value)
                             returnJSON["password"] = value
                             }
                             }*/
                            var count = 0
                            for value in row {
                                
                                if let value = value as? String {
                                    switch count {
                                    case 0: returnJSON["id"] = value
                                    case 1: returnJSON["password"] = value
                                    case 2: returnJSON["email"] = value
                                    case 3: returnJSON["firstname"] = value
                                    case 4: returnJSON["lastname"] = value
                                    case 5: returnJSON["middlename"] = value
                                    case 6: returnJSON["street"] = value
                                    case 7: returnJSON["zip"] = value
                                    case 8: returnJSON["nr"] = value
                                    case 9: returnJSON["gender"] = value
                                    case 10: returnJSON["active"] = value
                                    case 11:
                                        returnJSON["userType"] = value
                                        returnJSONList.append(returnJSON)
                                    default:
                                        print("im the default")
                                    }
                                }
                                count += 1
                            }
                        }
                        
                        print(returnJSONList)
                        callback(retString)
                    }
                    else if let queryError = result.asError {
                        // Something went wrong.
                        callback("Something went wrong \(queryError)")
                    }
                }
            }
        }
    }
    
    func pendingActivation(request: RouterRequest, response: RouterResponse, next: () -> Void) {
        connection.connect() { error in
            if let error = error {
                print("Error is \(error)")
                return
            }
            else {
                // Build and execute your query here.
                // First build query
                let query = Database.allUsersPendingActivation()
                
                connection.execute(query: query) { result in
                    if let resultSet = result.asResultSet {
                        
                        var returnJSON = [String : Any]()
                        var returnJSONList = [[String : Any]]()
                        
                        for row in resultSet.rows {
                            var count = 0
                            for value in row {
                                if let value = value as? String {
                                    switch count {
                                    case 0: returnJSON["id"] = value
                                    case 1: returnJSON["password"] = value
                                    case 2: returnJSON["email"] = value
                                    case 3: returnJSON["firstname"] = value
                                    case 4: returnJSON["lastname"] = value
                                    case 5: returnJSON["middlename"] = value
                                    case 6: returnJSON["street"] = value
                                    case 7: returnJSON["zip"] = value
                                    case 8: returnJSON["nr"] = value
                                    case 9: returnJSON["gender"] = value
                                    case 10: returnJSON["active"] = value
                                    case 11:
                                        returnJSON["userType"] = value
                                        returnJSONList.append(returnJSON)
                                    default:
                                        print("im the default")
                                    }
                                }
                                count += 1
                            }
                        }
                        print(returnJSONList)
                        //response.send(returnJSONList)
                    }
                    else if let queryError = result.asError {
                        // Something went wrong.
                        print("Something went wrong \(queryError)")
                    }
                }
            }
        }
        next()
        
        /*
         users() {
         resp in
         response.send(resp)
         // next()
         }
         */
        
    }
    
}
