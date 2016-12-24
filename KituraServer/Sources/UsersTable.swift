import SwiftKuery

class UsersTable: Table {
    let tableName = "users"
    
    let id = Column("uniqueID")
    let password =  Column("password")
    let email =  Column("email")
    let firstname =  Column("firstname")
    let lastname =  Column("lastname")
    let middlename =  Column("middlename")
    let street =  Column("street")
    //Canada and UK use letters in their ZIP codes
    let zip = Column("zip")
    //appartments can use 3A
    let nr = Column("nr")
    let gender = Column("gender")
    let active = Column("active")
    let usertype = Column("usertype")
}
