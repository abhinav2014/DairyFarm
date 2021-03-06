/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class User {
	public var id : Int?
	public var username : String?
	public var email : String?
	public var name : String?
	public var lastName : String?
	public var token : String?
	public var token_updateTime : Int?
	public var active : Int?
	public var admin : Bool?
	public var schoolAdmin : Bool?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let user_list = User.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of User Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [User]
    {
        var models:[User] = []
        for item in array
        {
            models.append(User(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let user = User(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: User Instance.
*/
	required public init?(dictionary: NSDictionary) {

		id = dictionary["id"] as? Int
		username = dictionary["username"] as? String
		email = dictionary["email"] as? String
		name = dictionary["name"] as? String
		lastName = dictionary["lastName"] as? String
		token = dictionary["token"] as? String
		token_updateTime = dictionary["token_updateTime"] as? Int
		active = dictionary["active"] as? Int
		admin = dictionary["admin"] as? Bool
		schoolAdmin = dictionary["schoolAdmin"] as? Bool
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.id, forKey: "id")
		dictionary.setValue(self.username, forKey: "username")
		dictionary.setValue(self.email, forKey: "email")
		dictionary.setValue(self.name, forKey: "name")
		dictionary.setValue(self.lastName, forKey: "lastName")
		dictionary.setValue(self.token, forKey: "token")
		dictionary.setValue(self.token_updateTime, forKey: "token_updateTime")
		dictionary.setValue(self.active, forKey: "active")
		dictionary.setValue(self.admin, forKey: "admin")
		dictionary.setValue(self.schoolAdmin, forKey: "schoolAdmin")

		return dictionary
	}

}