//
//  State.swift
//  LotsaBGDispatch
//
//  Created by Michael Langford on 12/23/16.
//  Copyright © 2016 Rowdy Labs. All rights reserved.
//

import Foundation
import ReSwift


struct LBGDState: StateType {
    var lastNumber = -1
}

var useSerial = true
let reSwiftGCDQueueSerial = DispatchQueue.main
let reSwiftGCDQueueConcurrent = DispatchQueue.global()
func reSwiftQueue()->DispatchQueue {
    return useSerial ? reSwiftGCDQueueSerial : reSwiftGCDQueueConcurrent
}


struct LotsaReducer: Reducer {
    
    func handleAction(action: Action, state: LBGDState?) -> LBGDState {
        guard let _ = state else{
            return LBGDState()
        }
        
        guard let action = action as? NewExpensiveValueAvailable else {
            fatalError()
        }
        
        return LBGDState(lastNumber: action.expensiveValue)
    }
}

let store = Store<LBGDState>(reducer: LotsaReducer(), state: nil)

struct NewExpensiveValueAvailable: Action{
    let expensiveValue:Int
}

func expensiveOperation()->Int{
    let v = sqrt(sqrt(sqrt(sqrt(sqrt(sqrt(sqrt(sqrt(sqrt(sqrt(Double(arc4random_uniform(100000000))+1.0))))))))))
    return Int(100000.0/(1.0+v))
}

func doExpensiveThingsThenDispatchResult(){
    let numberTimes = Int(arc4random_uniform(1000) + 1)
    var lastCalc = -1
    for _  in 0...numberTimes {
        lastCalc = expensiveOperation()
    }
    
    reSwiftQueue().async{
        print("async: \(lastCalc)")
        store.dispatch(NewExpensiveValueAvailable(expensiveValue:lastCalc))
    }
    
}
