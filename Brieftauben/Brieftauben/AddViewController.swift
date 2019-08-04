//
//  AddViewController.swift
//  Brieftauben
//
//  Created by Kilian Kellermann on 25.02.17.
//  Copyright © 2017 Kilian Kellermann. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    var zuechterliste = Zuechterliste.allContacts()
    
    @IBOutlet weak var msgField: UITextField!
    @IBOutlet weak var recipientPicker: UIPickerView!
    
    @IBAction func sendTapped(_ sender: Any) {
        // Nachricht
        guard let msg = msgField.text else {
            return
        }
        
        // Empfänger
        let recipientRow = recipientPicker.selectedRow(inComponent: 0)
        let zuechter = zuechterliste[recipientRow]
        
        let dbResource = ResourceModel.sharedInstance
        dbResource.msg(to: zuechter.name, withText: msg)
        
        // ViewController schließen.
        let _ = navigationController?.popViewController(animated: true)
    }
    
    // MARK: Picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return zuechterliste.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let zuechter = zuechterliste[row]
        
        return zuechter.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: TextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        msgField.resignFirstResponder()
        
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
