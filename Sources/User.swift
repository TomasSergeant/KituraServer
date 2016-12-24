import Foundation

struct User {
    let id: Int
    let password: String
    let email: String
    let firstname: String
    let lastname: String
    let middlename: String
    let street: String
    //Canada and UK use letters in their ZIP codes
    let zip: String
    //appartments can use 3A
    let nr: String
    let gender: String
    let active: String
    let usertype: String
}

extension User: FieldMappable {
    init?(fields: [String:Any]) {
        if let fieldID = fields["id"] {
            id = Int(fieldID as! String)!
        } else {
            return nil
        }
        
        password =      fields["password"] as! String
        email =         fields["email"] as! String
        firstname =     fields["firstname"] as! String
        lastname =      fields["lastname"] as! String
        middlename =    fields["middlename"] as! String
        street =        fields["street"] as! String
        zip =           fields["zip"] as! String
        nr =            fields["nr"] as! String
        gender =        fields["gender"] as! String
        active =        fields["active"] as! String
        usertype =      fields["usertype"] as! String

    }
}

extension User: DictionaryConvertible {
    var dictionary: [String: Any] {
        var basicItems = [String:Any]()
        
        basicItems["id"]            = id
        basicItems["password"]      = password
        basicItems["email"]         = email
        basicItems["firstname"]     = firstname
        basicItems["lastname"]      = lastname
        basicItems["middlename"]    = middlename
        basicItems["street"]        = street
        basicItems["zip"]           = zip
        basicItems["nr"]            = nr
        basicItems["gender"]        = gender
        basicItems["active"]        = active
        basicItems["usertype"]      = usertype
        
        return basicItems
    }
}
