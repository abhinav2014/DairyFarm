/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class AnimalDetailsModel {
	public var id : Int?
	public var animalCode : Int?
	public var dateOfBirth : String?
	public var currentWeight : Int?
	public var birthWeight : Int?
	public var lastHeatDate : Int?
	public var medicalNumber : String?
	public var imageName : String?
	public var ownerId : Int?
	public var type : Type?
	public var liveStockGroup : LiveStockGroup?
	public var liveStockBreed : LiveStockBreed?
	public var createdDate : Int?
	public var updatedDate : String?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let json4Swift_Base_list = Json4Swift_Base.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Json4Swift_Base Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [AnimalDetailsModel]
    {
        var models:[AnimalDetailsModel] = []
        for item in array
        {
            models.append(AnimalDetailsModel(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let json4Swift_Base = Json4Swift_Base(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Json4Swift_Base Instance.
*/
	required public init?(dictionary: NSDictionary) {

		id = dictionary["id"] as? Int
		animalCode = dictionary["animalCode"] as? Int
		dateOfBirth = dictionary["dateOfBirth"] as? String
		currentWeight = dictionary["currentWeight"] as? Int
		birthWeight = dictionary["birthWeight"] as? Int
		lastHeatDate = dictionary["lastHeatDate"] as? Int
		medicalNumber = dictionary["medicalNumber"] as? String
		imageName = dictionary["imageName"] as? String
		ownerId = dictionary["ownerId"] as? Int
		if (dictionary["type"] != nil) { type = Type(dictionary: dictionary["type"] as! NSDictionary) }
		if (dictionary["liveStockGroup"] != nil) { liveStockGroup = LiveStockGroup(dictionary: dictionary["liveStockGroup"] as! NSDictionary) }
		if (dictionary["liveStockBreed"] != nil) { liveStockBreed = LiveStockBreed(dictionary: dictionary["liveStockBreed"] as! NSDictionary) }
		createdDate = dictionary["createdDate"] as? Int
		updatedDate = dictionary["updatedDate"] as? String
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.id, forKey: "id")
		dictionary.setValue(self.animalCode, forKey: "animalCode")
		dictionary.setValue(self.dateOfBirth, forKey: "dateOfBirth")
		dictionary.setValue(self.currentWeight, forKey: "currentWeight")
		dictionary.setValue(self.birthWeight, forKey: "birthWeight")
		dictionary.setValue(self.lastHeatDate, forKey: "lastHeatDate")
		dictionary.setValue(self.medicalNumber, forKey: "medicalNumber")
		dictionary.setValue(self.imageName, forKey: "imageName")
		dictionary.setValue(self.ownerId, forKey: "ownerId")
		dictionary.setValue(self.type?.dictionaryRepresentation(), forKey: "type")
		dictionary.setValue(self.liveStockGroup?.dictionaryRepresentation(), forKey: "liveStockGroup")
		dictionary.setValue(self.liveStockBreed?.dictionaryRepresentation(), forKey: "liveStockBreed")
		dictionary.setValue(self.createdDate, forKey: "createdDate")
		dictionary.setValue(self.updatedDate, forKey: "updatedDate")

		return dictionary
	}

}
