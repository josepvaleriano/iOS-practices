//
//  SecondViewController.swift
//  VideoyAudio
//
//  Created by Infraestructura on 22/10/16.
//  Copyright © 2016 Valeriano Lopez. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit // para utilizar avplayerviewcontroler

class SecondViewController: UIViewController  {
    
    var videoPlayer: AVPlayer?
    var visto:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let urlDelVideo = NSBundle.mainBundle().URLForResource("Comex-Omnilife", withExtension: "mp4")
        self.videoPlayer = AVPlayer(URL: urlDelVideo!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if !visto {
            self.muestraVideo()
        }
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.videoPlayer!.pause()
    }
    
    func muestraVideo() {
        let videoPlayerControler = AVPlayerViewController()
        // para mostrar el video en la pantalla
        videoPlayerControler.player = self.videoPlayer!
        //verifica el tipo de dispositivo
        if UIDevice.currentDevice().userInterfaceIdiom ==
        UIUserInterfaceIdiom.Phone {
            self.presentViewController(videoPlayerControler, animated: true, completion:{
                self.videoPlayer!.play()
                self.visto = true
            })
        }
        else{ // es una tableta
            let framePantalla = UIScreen.mainScreen().bounds
            let anchoPantalla = CGRectGetWidth(framePantalla)
            let altoPantalla = CGRectGetHeight(framePantalla)
            videoPlayerControler.view.frame = CGRectMake(anchoPantalla/4, altoPantalla/4, anchoPantalla/2, altoPantalla/2)
            self.view.addSubview(videoPlayerControler.view)
            self.addChildViewController(videoPlayerControler)
            self.videoPlayer!.play()
            self.visto = true
        }
        
    }
    
}

