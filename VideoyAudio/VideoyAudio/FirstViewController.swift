//
//  FirstViewController.swift
//  VideoyAudio
//
//  Created by Infraestructura on 22/10/16.
//  Copyright © 2016 Valeriano Lopez. All rights reserved.
//

import UIKit
import AVFoundation

class FirstViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var btnPlay: UIButton!
    
    @IBOutlet weak var btnStop: UIButton!
    
    @IBOutlet weak var sliderVol: UISlider!
    
    @IBOutlet weak var sliderProgress: UISlider!
    
    var audioPlayer : AVAudioPlayer!
    
    var timer: NSTimer?
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // Do any additional setup after loading the view, typically from a nib.
        let strPath = NSBundle.mainBundle().pathForResource("Enigma - Return To Innocence", ofType: "mp3")
        let urlAudio = NSURL.fileURLWithPath(strPath!)
        self.cargarArchivo(urlAudio)
        
    }
    // Se pone este codigo para que funcione en el cambio del tab bar
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.btnPlayTouch(self.btnStop)
        self.btnStopTouch(self.btnPlay)
        self.pauseUX()
    }
    
    
    func cargarArchivo(url: NSURL) {
        do {
            try self.audioPlayer = AVAudioPlayer(contentsOfURL: url)
            print("Audio url: \(url)")
            self.audioPlayer!.delegate = self
            self.audioPlayer!.prepareToPlay()
            self.inicializaUX()
        }
        catch{
            let ac = UIAlertController(title: "Error", message: "Archivo de audio inexistente",
                                           preferredStyle: .Alert )
            let ab = UIAlertAction(title: "ya que ..", style: .Default, handler: nil)
            ac.addAction(ab)
            self.presentViewController(ac, animated: true, completion: nil)
        }
        
    }
    
    func inicializaUX() {
        self.btnStop.enabled = false
        self.sliderVol.minimumValue = 0.0
        self.sliderVol.maximumValue = 10.0
        self.sliderVol.value = 5.0
        self.audioPlayer!.volume = self.sliderVol.value
        self.audioPlayer!.currentTime = 0.0
        self.sliderProgress.minimumValue = 0.0
        let duracion:Double = self.audioPlayer!.duration
        self.sliderProgress.maximumValue = Float(duracion)
        self.sliderProgress.value = 0.0
    }

    func pauseUX() {
        self.btnStop.enabled = false
        self.btnPlay.enabled = true
        self.audioPlayer!.volume = self.sliderVol.value
        
        let duracion:Double = self.audioPlayer!.duration
        self.sliderProgress.maximumValue = Float(duracion)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnPlayTouch(sender: AnyObject) {
        self.audioPlayer!.play()
        self.btnPlay.enabled = false
        self.btnStop.enabled = true
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(FirstViewController.actualizaSlider), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func btnStopTouch(sender: AnyObject) {
        self.audioPlayer!.stop()
        self.btnPlay.enabled = true
        self.btnStop.enabled = false
    }
    
    @IBAction func sliderVolChange(sender: AnyObject) {
        self.audioPlayer!.volume = self.sliderVol.value
    }
    // para el audio
    @IBAction func sliderProgressChange(sender: AnyObject) {
        self.audioPlayer.currentTime = Double(self.sliderProgress.value)
    }
    // para mostrar el progreso del audio
    func actualizaSlider() {
        let pos:Double = self.audioPlayer!.currentTime
        self.sliderProgress.value = Float(pos)
    }

}

