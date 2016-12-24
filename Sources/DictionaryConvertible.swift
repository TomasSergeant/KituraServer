public protocol DictionaryConvertible {
    var dictionary: [String: Any] {get}
}

public extension Array where Element : DictionaryConvertible {
    var dictionary: [[String: Any]]{
        return self.map{$0.dictionary}
    }
}
