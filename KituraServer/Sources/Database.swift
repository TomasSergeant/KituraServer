import Dispatch

import SwiftKuery
import SwiftKueryPostgreSQL
import MiniPromiseKit


public class Database {
    let queue = DispatchQueue(label: "com.users.database",  attributes: .concurrent)
    
    static let usersTable = UsersTable()
    
    private func createConnection() -> Connection {
        return PostgreSQLConnection(host: "localhost", port: 5432,
                                    options: [.userName("tomas"),
                                              .password(" "),
                                              .databaseName("tomas")])
    }
    
    static func allUsersPendingActivation() -> Select {
        return Select(from: Database.usersTable)
        //.where(Database.usersTable.active == UserActive.pendingActivation.rawValue)
        .where(Database.usersTable.usertype == UserType.prospect.rawValue)
    }
    
    static func userByID(id: Int) -> Select {
        return Select(from: Database.usersTable)
            .where(Database.usersTable.id == id)
    }
    
    
    func queryUsers(with selection: Select) -> Promise<[User]> {
        
        let connection = createConnection()
        
        return firstly {
            connection.connect()
            }
            .then(on: queue) { result -> Promise<QueryResult> in
                selection.execute(connection)
            }
            .then(on: queue) { result -> ResultSet in
                guard let resultSet = result.asResultSet else { throw DatabaseError.noResult }
                return resultSet
            }.then(on: queue) { resultSet -> [User] in
                let fields = resultToRows(resultSet: resultSet)
                return fields.flatMap( User.init(fields:) )
            }.always(on: queue) {
                connection.closeConnection()
        }
        
    }
    
}
