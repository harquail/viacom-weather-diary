//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse
import SpriteKit

class SplashViewController: UIViewController {
    @IBOutlet var writeButton: SFlatButton!
    @IBOutlet var readButton: SFlatButton!
    @IBOutlet var rainyView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // the SFlatButtons need this called manually, because their custom initializer is not called when initializing from storyboard
        writeButton.setupButtons()
        readButton.setupButtons()

        // Retrieve scene file path from the application bundle
        let nodePath = NSBundle.mainBundle().pathForResource("rain", ofType: "sks")
        // Unarchive the file to an SKScene object
        let data = NSData.dataWithContentsOfMappedFile(nodePath!) as! NSData
        let arch = NSKeyedUnarchiver(forReadingWithData: data)
        let node = arch.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! SKEmitterNode
        arch.finishDecoding()
        
        //put the node at the top of the view
        node.position = CGPointMake(rainyView.frame.width/2, rainyView.frame.height)
        node.targetNode = rainyView.scene

        // show the rain & correct background color
        let scene = SKScene(size: rainyView.frame.size)
        scene.backgroundColor = rainyView.backgroundColor!
        scene.addChild(node)
        rainyView.presentScene(scene)

    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

