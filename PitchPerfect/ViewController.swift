//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Gaurav Saraf on 9/16/16.
//  Copyright © 2016 Gaurav Saraf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var recordingLabel: UILabel!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAction(_ sender: AnyObject) {
        print("record was pressed.")
        recordingLabel.text = "Recording in progress."
    }
    
    @IBAction func stopRecording(_ sender: AnyObject) {
        print("Stop recording button pressed")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear")
    }
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
}

