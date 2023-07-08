//import Foundation
//
//protocol ListStrategy {
//    init()
//    func start(_ buffer: inout String)
//    func end(_ buffer: inout String)
//    func addListItems(buffer: inout String, item: String)
//}
//
//enum OutputFormat {
//    case markdown
//    /*
//       * omar
//       * ahmed
//     */
//    case html
//    /*
//       <ul>
//         <li>omar</li>
//         <li>ahmed</li>
//       </ul>
//     */
//}
//
//class MarkDownListStrategy: ListStrategy {
//    
//    required init() {}
//    func start(_ buffer: inout String) {}
//    func end(_ buffer: inout String) {}
//    
//    func addListItems(buffer: inout String, item: String) {
//        buffer.append("* \(item)\n")
//    }
//}
//
//class HtmlListStrategy: ListStrategy {
//    
//    required init() {}
//    func start(_ buffer: inout String) {
//        buffer.append("<ul>\n")
//    }
//    func end(_ buffer: inout String) {
//        buffer.append("</ul>\n")
//    }
//    
//    func addListItems(buffer: inout String, item: String) {
//        buffer.append(" <li>\(item)</li>\n")
//    }
//}
//
//class TextProcessor: CustomStringConvertible {
//    
//    var description: String {
//        return buffer
//    }
//    /// Priivate properties
//    private var buffer = ""
//    private var listStrategy: ListStrategy
//    
//    /// INT
//    init(_ outputFormat: OutputFormat) {
//        switch outputFormat {
//        case .markdown: listStrategy = MarkDownListStrategy()
//        case .html: listStrategy = HtmlListStrategy()
//        }
//    }
//    
//    func setOutputFormat(_ outputFormat: OutputFormat) {
//        switch outputFormat {
//        case .markdown: listStrategy = MarkDownListStrategy()
//        case .html: listStrategy = HtmlListStrategy()
//        }
//    }
//    
//    func appendList(list: [String]) {
//        listStrategy.start(&buffer)
//        list.forEach({listStrategy.addListItems(buffer: &buffer, item: $0)})
//        listStrategy.end(&buffer)
//    }
//    
//    func reset() {
//        buffer = ""
//    }
//}
