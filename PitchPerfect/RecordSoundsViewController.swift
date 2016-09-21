//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Gaurav Saraf on 9/16/16.
//  Copyright © 2016 Gaurav Saraf. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var startRecordButton: UIButton!
    @IBOutlet weak var stopRecordButton: UIButton!
    
    var audioRecorder:AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAction(_ sender: AnyObject) {
        print("record was pressed.")
        setButtonStates(stopRecordButtonState: true, startRecordButtonState: false)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURL(withPathComponents: pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: AnyObject) {
        print("Stop recording button pressed")
        setButtonStates(stopRecordButtonState: false, startRecordButtonState: true)
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        stopRecordButton.isEnabled = false
    }
    
    func setButtonStates(stopRecordButtonState: Bool, startRecordButtonState: Bool) {
        stopRecordButton.isEnabled = stopRecordButtonState
        startRecordButton.isEnabled = startRecordButtonState
        if (startRecordButtonState){
            recordingLabel.text = "Recording in progress."
        }
        if (stopRecordButtonState)
        {
            recordingLabel.text = "Tap to Record"
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("finished recording")
        if (flag) {
            self.performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("Saving of recording failed")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recorderAudioURL = sender as! NSURL
            playSoundsVC.recordedAudioURL = recorderAudioURL
        }
    }
}

