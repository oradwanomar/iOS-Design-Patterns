import Foundation

/*:

 # Singleton Design Pattern
 
 - singleton is a design pattern used to ensure that only one instance of a class is created and that the instance can be accessed globally. It is commonly used when you need to manage a shared resource or maintain a global state throughout an application.
 
 - class that represents the singleton. The shared property is a static constant that holds the single instance of Helper. The private init() ensures that no other instance of the class can be created.
 
 - By using the shared property, you can access the singleton instance from anywhere in your code, making it easy to maintain a global state or access a shared resource.
 
 */

class Helper {
    
    var name = "name"
    
    private let name1 = "name1"
    
    static let shared = Helper()
    private init() {}
    
}

let helper1 = Helper.shared
let helper2 = Helper.shared

print(helper1 === helper2)

print(helper1.name)

helper1.name = "name 1"

print(helper2.name)


/*:
 
 # Why not struct

##### When considering whether to use a struct or a class for implementing a singleton in Swift, there are a few factors to consider. While it is technically possible to use a struct to create a singleton, there are some limitations and considerations to keep in mind:

- Reference Semantics: Classes in Swift have reference semantics, which means that multiple references to the same instance can exist. This can be beneficial for managing shared state or resources. On the other hand, structs have value semantics, which means that they are copied when assigned or passed as arguments. Using a struct as a singleton may not provide the desired behavior if you need to maintain a single shared instance throughout your application.

- Mutability: If your singleton needs to be mutable and have mutable properties, classes offer more flexibility. You can mark properties as var and modify them even after the singleton instance has been created. Structs, by default, have immutable properties and require the use of the mutating keyword to modify their properties.

- Inheritance: If you need to subclass or inherit from the singleton instance, classes are necessary since Swift doesn't support inheritance for structs.
 
 */


struct StructHelper{
    
    var name = "name"
    
    static let shared = StructHelper()
    private init() {}
    
}

var structHelper = StructHelper.shared

structHelper.name = "Ali"
print(structHelper.name)
print(StructHelper.shared.name)



/*:
 # Another implementation
 
 In this wey we can use the shared instance or we can make ower custom instance
 
 - The Singelton class has a single property called name, which is of type String. This property can be accessed and modified like any other instance variable.

- The shared property is declared as a static constant of type Singelton. It represents the singleton instance of the class. By declaring it as static, you can access it globally without needing to create an instance of the Singelton class.

- The shared property is initialized with an instance of the Singelton class using the default initializer. This ensures that only one instance of Singelton is created throughout the application.
 */

class Singelton{

    var name : String = ""
    
    static let shared = Singelton()
    
}

Singelton.shared.name = "name2"



let object = Singelton()
object.name = "newName"
print(object.name)

print(Singelton.shared.name)


/*:
 # Singelton with protocol
 
- The SharedHelper protocol declares a single property sharedName, which is a String optional and provides both a getter and a setter.

- The Helper class adopts the SharedHelper protocol by implementing the sharedName property.

- The Helper class also has its own property called name, which is a non-optional String.

- Inside the Helper class, there is a static constant named shared of type SharedHelper, which is assigned to an instance of the Helper class. This represents the shared instance of Helper.

- The private init() is a private initializer that ensures only one instance of Helper can be created.
 
 */

protocol SharedHelper{
    var sharedName: String? { get set }
}

class Helper: SharedHelper {
    
    var sharedName: String?
    var name = "name"
    
    static let shared: SharedHelper = Helper()
    private init() {}
    
}

let helper1 = Helper.shared
//helper1.name // Value of type 'SharedHelper' has no member 'name'

helper1.sharedName

//: MARK:  Change the shared

protocol APIShared{
    func requestDara(from url: String) -> String
}

extension Helper: APIShared{
    
    func requestDara(from url: String) -> String {
        return url
    }
    
    static let apiShared: APIShared = Helper()
    
}


let helper2 = Helper.apiShared
helper2.requestDara(from: "example.com")


/*:
 
# What is bad about Singelton

- Hidden dependencies: Singletons can introduce hidden dependencies because they are globally accessible and can be accessed from anywhere in the codebase. This can make it difficult to identify and manage the dependencies of a class or module.

- Class remains in memory: Once a singleton instance is created, it remains in memory throughout the lifetime of the application. This can lead to increased memory usage, especially if the singleton holds onto significant resources or data that are no longer needed.

- Difficulties in mocking or testing: Singletons can be challenging to mock or test in isolation. Since they are globally accessible, it's not straightforward to replace a singleton instance with a test double or mock object, making it harder to isolate the behavior of a specific class or module during testing.

- Violation of the Single Responsibility Principle (SRP): Singletons can violate the SRP because they often take on multiple responsibilities, such as managing shared state, handling resource access, and providing global access. This can lead to increased complexity and make the codebase less maintainable.

- Breakage of Dependency Inversion Principle (DIP): Singletons can break the DIP, which states that high-level modules should not depend on low-level modules but both should depend on abstractions. Singletons often represent concrete implementations and can create tight coupling between modules.

- Potential for unintended side effects: Since singletons are globally accessible, any part of the code can modify their state. This can lead to unexpected behavior and bugs, as changes made in one part of the code can impact the behavior of other classes or modules that rely on the singleton.

- Singletons can be thread-unsafe by default because they introduce shared mutable state, and concurrent access to that shared state can lead to race conditions and unexpected behavior
 
 */

// MARK:  Correct use it to use dependancy injection to inject the Singleton to the file

struct User{}


// MARK:  Ipml 1

//class ApiClient {
//    static let instance = ApiClient()
//    private init() {}
//
//    func login(completion: (User) -> Void){}
//    func signup(user: User, completion: () -> Void){}
//}
//
//// but this way is not the best way of make Singelton
//// there is a func that i do not need
//class LoginViewController{
//    var apiClient = ApiClient.instance
//
//    func didTapLoginButton(){
//        apiClient.login { user in
//            // Make action
//        }
//    }
//
//}
//
//class SignupViewController{
//    var apiClient = ApiClient.instance
//
//    func didTapSignupButton(){
//        apiClient.signup(user: User()) {
//            // update UI
//        }
//    }
//
//}

// MARK:  Ipml 2

// solve two problems
// 1- class only access the func they need
// 2- class do not depends on the instance

class ApiClient {
    static let instance = ApiClient()
    private init() {}
}

// but this way is not the best way of make Singelton
// there is a func that i do not need

protocol LoginApiProtocol{
    func login(completion: (User) -> Void)
}

extension ApiClient: LoginApiProtocol{
    func login(completion: (User) -> Void){}
}

class LoginViewController{
    var apiClient: LoginApiProtocol
    
    
    init(apiClient: LoginApiProtocol = ApiClient.instance){
        self.apiClient = apiClient
    }
    
    func didTapLoginButton(){
        apiClient.login { user in
            // Make action
        }
    }
    
}

protocol SignupApiProtocol{
    func signup(user: User, completion: () -> Void)
}

extension ApiClient: SignupApiProtocol{
    func signup(user: User, completion: () -> Void){}
}

class SignupViewController{
    var apiClient: SignupApiProtocol
    
    init(apiClient: SignupApiProtocol = ApiClient.instance){
        self.apiClient = apiClient
    }
    
    func didTapSignupButton(){
        apiClient.signup(user: User()) {
            // update UI
        }
    }
}

