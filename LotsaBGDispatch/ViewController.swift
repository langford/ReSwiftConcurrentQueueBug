//
//  ViewController.swift
//  LotsaBGDispatch
//
//  Created by Michael Langford on 12/23/16.
//  Copyright © 2016 Rowdy Labs. All rights reserved.
//

import UIKit
import ReSwift

class ViewController: UIViewController,StoreSubscriber {

    @IBOutlet weak var lastValueLabel: UILabel!
    
    @IBOutlet weak var useSerialSwitch: UISwitch!
    @IBAction func launchTapped(_ sender: Any) {
        for _ in 0...100{
            DispatchQueue.global().async{
                doExpensiveThingsThenDispatchResult()
            }
        }
    }
    
    @IBAction func switchChanged(_ serialSwitch: UISwitch) {
        useSerial = serialSwitch.isOn
    }
        
    override func viewWillAppear(_ animated: Bool) {
        reSwiftQueue().async{
            store.subscribe(self)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        reSwiftQueue().async{
            store.unsubscribe(self)
        }
    }
    
    func newState(state: LBGDState) {
        guard let lastValueLabel = lastValueLabel else{
            return
        }
        lastValueLabel.text = "\(store.state.lastNumber)"
    }
}

