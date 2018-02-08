//
//  MerchOrder.swift
//  UCBMUNXX
//
//  Created by Steven Chen on 1/30/16.
//  Copyright © 2016 Steven Chen. All rights reserved.
//

import Foundation

class MerchOrder : PFObject {
    @NSManaged var item: String?
    @NSManaged var recipient : String?
    @NSManaged var delivered : Bool
    @NSManaged var quantity : Double
    @NSManaged var comment : String?
    @NSManaged var cost : Double
    @NSManaged var sender : String?
    @NSManaged var email : String?
    
    init(item: String?, recipient: String?, delivered: Bool?, quantity: Double?, comment: String?, cost: Int?, sender: String?, email: String?) {
        super.init()
        self.item = item
        self.recipient = recipient
        self.delivered = delivered!
        self.quantity = quantity!
        self.comment = comment
        self.cost = Double(cost!) * quantity!
        self.sender = sender
        self.email = email
    }
    
    override init() {
        super.init()
    }
    
    override class func query() -> PFQuery<PFObject>? {
        
        let query = PFQuery(className: MerchOrder.parseClassName())
        query.order(byDescending: "createdAt")
        return query
    }
}
extension MerchOrder: PFSubclassing {
    // Table view delegate methods here
    //1
    class func parseClassName() -> String {
        return "MerchOrder"
    }
    
    //2
//    override class func initialize() {
//        var onceToken: Int = 0
//        dispatch_once(&onceToken) {
//            self.registerSubclass()
//        }
//    }
}
