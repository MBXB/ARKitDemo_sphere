//
//  ViewController.swift
//  ARKit初体验
//
//  Created by 毕向北 on 2017/9/3.
//  Copyright © 2017年 MBXB-bifujian. All rights reserved.
//简书地址--http://www.jianshu.com/p/1a93e0e1da78
//C博客地址--http://blog.csdn.net/oboe_b/article/details/77816655
//微博--http://weibo.com/6342211709/profile?rightmod=1&wvr=6&mod=personinfo



import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    let textures = ["earth.jpg","jupiter.jpg","mars.jpg","venus.jpg"]
    private var index = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        //创建一个场景
        let scene = SCNScene()
        //创建一个球体
        let sphere = SCNSphere(radius: 0.2)
        //可以为这个空白的球体做一些事情
        //material渲染器来渲染一下
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "earth.jpg")
        sphere.materials = [material]
        //创建一个节点
        let sphereNode = SCNNode(geometry: sphere)
        //设置节点的位置
        sphereNode.position = SCNVector3(0,0,-0.5)
        //添加到根节点
        scene.rootNode.addChildNode(sphereNode)
        
        sceneView.scene = scene
        registerGestureRecognizers()

    }
    
    @objc func registerGestureRecognizers(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
   @objc func tapAction (recognizer: UIGestureRecognizer){
       let sceneView = recognizer.view as! ARSCNView
       let touchLoaction = recognizer.location(in: sceneView)
       let hitRersults = sceneView.hitTest(touchLoaction, options: [:])
       if !hitRersults.isEmpty {
        if index == self.textures.count {
            index = 0
        }
        guard let hitRersult = hitRersults.first else {
            return
        }
        let node = hitRersult.node
        node.geometry?.firstMaterial?.diffuse.contents = UIImage(named: textures[index])
        index += 1
       }
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
