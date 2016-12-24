import Kitura
import HeliumLogger
import SwiftyJSON
import SwiftKueryPostgreSQL
import SwiftKuery

// Initialize HeliumLogger
HeliumLogger.use()

// Create a new router
let router = Router()


//needed to use JSON in requests
router.all("*", middleware: BodyParser())

let users = UsersTable()

let connection = PostgreSQLConnection(host: "localhost", port: 5432, options: [.databaseName("tomas"),.userName("tomas")])

let userController = UserController()
userController.makeRoutes(router: router)

// Add an HTTP server and connect it to the router
Kitura.addHTTPServer(onPort: 8090, with: router)

// Start the Kitura runloop (this call never returns)
Kitura.run()
