/*
 # Proxy design pattern
 
 - Intent: It provides a surrogate or a placeholder for another object, to control access to it (the original object)
 
 - Types:
        - Virtual proxy (Lazy initialization). This is when you have a heavyweight service object that wastes system resources by being always up, even though you only need it from time to time.
        - Protection proxy(as in Spotify for subscribers content). This is when you want only specific clients to be able to use the service object; for instance, when your objects are crucial parts of an operating system and clients are various launched applications (including malicious ones).
        - Caching proxy (like kingfisher as an example).
        - Logging proxy. This is when you want to keep a history of requests to the service object.
        - etc.

 - Implementation: - Create the Service Interface (protocol) 
                   - Conform to this interface in both the original service and the proxy that controls access to it
                   - Give the proxy reference to the original service via the constructor (init)
 */

// MARK: - Caching proxy example

protocol ImageLoader {
    func load(with url: String) async -> Data
}

class DefaultImageLoader: ImageLoader {
    func load(with url: String) async -> Data {
        // Sending some api request with given url
        return Data()
    }
}

class CachingProxy: ImageLoader {
    
    private var realService: ImageLoader
    private var cache: [String:Data] = [:]
    
    init(realService: ImageLoader) {
        self.realService = realService
    }
    
    func load(with url: String) async -> Data {
        // If the url in cache then we have the data already loaded and we return it, else we call the real service
        // to load the image for us then we cache it and return it
        guard let cachedImageData = cache[url] else {
            let loadedImageData = await realService.load(with: url)
            cache[url] = loadedImageData
            return loadedImageData
        }
        
        return cachedImageData
    }
}

// MARK: - Protection proxy example

protocol SongsService {
    func play()
}

class DefaultSongsService: SongsService {
    func play() {
        print("Playing a song")
    }
}

class PremiumSongsProxy: SongsService {
    
    private var realService: SongsService
    private var userID: String
    
    init(realService: SongsService, userID: String) {
        self.realService = realService
        self.userID = userID
    }
    
    func play() {
        guard isUserHasAccess() else { return }
        realService.play()
    }
    
    private func isUserHasAccess() -> Bool {
        // very minimal access logic for the sake of example
        return (userID.count % 2) == 0
    }
}

/*
    - All types of proxies behave the same way all share the intent of controlling access to another object
    - it's a good way to introduce multiple proxies without changing the real service. So we don't violate OCP.
*/
