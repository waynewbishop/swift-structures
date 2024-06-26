//
//  Chain.swift
//  Structures
//
//  Created by Wayne Bishop on 8/24/20.
//  Copyright (c) 2020 Arbutus Software Inc. All rights reserved.
//

import Foundation


/**
 Generic `Linked List` algorithm used to demonstrate the hash collision technique of separate chaining.
 
 - Important: To support type comparisions, any generic type being used must conform
 to the standard Equatable protocol.
*/

public class Chain <T: Equatable> {
    
    private var head = LLNode<T>()
    private var lastvalue: T?
    
    public init() {
        //package support
    }
    
    
    var last: T? {
        return lastvalue
    }
    
    
    //returns all values - O(n)
    public var values: Array<T> {
        
        var current: LLNode? = head
        var results = Array<T>()
        
        while let item = current {
            if let tvalue = item.tvalue {
                results.append(tvalue)
            }
            current = item.next
        }
        
        return results
    }

    
    
    public func append(_ tvalue: T) {  // O(n) -  linear time
        
        guard head.tvalue != nil else {
           head.tvalue = tvalue
           lastvalue = tvalue
           return
         }
        
          let childToUse = LLNode<T>()
          childToUse.tvalue = tvalue


          var current: LLNode<T> = head

        
          //find next position - O(n)
          while let item = current.next {
            current = item
          }

          childToUse.previous = current
          current.next = childToUse
        
          lastvalue = tvalue
    }
    

    //check for existing value
    public func contains(_ tvalue: T) -> Bool {
        
        var current: LLNode<T>? = head
        
        //find possible match - O(n)
        while current != nil {
            if let item = current {
                if let chainValue = item.tvalue {
                    if chainValue == tvalue {
                        return true
                    }
                }
                current = item.next
            }
        }
        
        return false
    }

        
    
    public func printValues() {
        
        var current: LLNode? = head
        
        while current != nil {
            if let item = current {
                if let tvalue = item.tvalue {
                    print("chain item is: \(tvalue)")
                }
                current = item.next
            }
        }
        
    }

    
}
