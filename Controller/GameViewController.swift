//
//  GameViewController.swift
//  PWB
//
//  Created by Nicholas Wei on 7/12/17.
//  Copyright © 2017 Nicholas Wei. All rights reserved.
//

import UIKit
import SpriteKit
// import GameplayKit
import AVFoundation

class GameViewController: UIViewController {
    
    // var bgMusicPlayer = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = LoadScreenScene(fileNamed: "LoadingScreen") // name will be changed
            {
//                let bgMusicURL = Bundle.main.url(forResource: "bgMusic", withExtension: "mp3")
//                
//                do {
//                    try bgMusicPlayer = AVAudioPlayer(contentsOf: bgMusicURL!)
//                } catch{
//                    print("can't play music")
//                }
//                
//                bgMusicPlayer.numberOfLoops = -1
//                bgMusicPlayer.prepareToPlay()
//                bgMusicPlayer.play()
                

                
                
                
                // Set the scale mode to scale to fit the window
                scene.backgroundColor = UIColor(hue: 0.5222, saturation: 1, brightness: 0.97, alpha: 1)
                scene.scaleMode = .resizeFill
                
                // Present the scene
                view.presentScene(scene, transition: SKTransition.fade(with: SKColor.white, duration: TimeInterval(5)))
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    


    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
