////
////  GameScene.swift
////  PWB
////
////  Created by Nicholas Wei on 7/12/17.
////  Copyright © 2017 Nicholas Wei. All rights reserved.
////
////
//
//import SpriteKit
//// import GameplayKit
//// look at Tile Map Node
//
//
//
//// OUTDATED FILE
//// DO NOT USE 
//// SEE BaseLevelScene.swift
//
//class GameScene: SKScene {
//    
//    private var levelLabel : SKLabelNode?
//    private var game: PWBLevel!
//    private var allBits: [SKLabelNode] = []
//    private var previousBit: Int = -1
//    private var previousBitIndex: Int = -1
//    private var gameState: PWBLevel.GameState?
//    
//    
//    override func didMove(to view: SKView) {
//        
//        if let loadgame = constructTestLevel()
//        {
//            // setup swipe gestures
//            let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipe))
//            swipeRight.direction = UISwipeGestureRecognizerDirection.right
//            view.addGestureRecognizer(swipeRight)
//            
//            let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipe))
//            swipeLeft.direction = UISwipeGestureRecognizerDirection.left
//            view.addGestureRecognizer(swipeLeft)
//            
//            let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipe))
//            swipeUp.direction = UISwipeGestureRecognizerDirection.up
//            view.addGestureRecognizer(swipeUp)
//            
//            let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipe))
//            swipeDown.direction = UISwipeGestureRecognizerDirection.down
//            view.addGestureRecognizer(swipeDown)
//            
//            game = loadgame
//            game.start()
//            gameState = game.state
//            
//            // construct inner rectangle where problem will be displayed
//            levelLabel = SKLabelNode(fontNamed: "Helvetica Neue UltraLight")
//            levelLabel?.text = game.levelName
//            levelLabel?.fontSize = 35
//            levelLabel?.fontColor = SKColor.black
//            levelLabel?.position = CGPoint(x: frame.midX, y: frame.maxY * 0.7)
//            
//            for bit in (game.state?.currentState)!
//            {
//                allBits.append(SKLabelNode(text: bit.toStr()))
//            }
//            
//            // let rectHeightSlice = rect.frame.size.height * CGFloat(0.5)
//            let offset = 0.1
//
//            
//            for i in 0..<allBits.count
//            {
//                allBits[i].fontColor = SKColor.black
//                allBits[i].fontSize = 50
//                allBits[i].fontName = "CourierNewPSMT"
//                self.addChild(allBits[i])
//            }
//            
//            allBits[0].position = CGPoint(x: frame.midX, y: (frame.midY * CGFloat(1+offset)))
//            allBits[1].position = CGPoint(x: frame.midX, y: (frame.midY - allBits[0].frame.size.height))
//            
//            self.addChild(levelLabel!)
//            
//            let rect = SKShapeNode(rectOf: CGSize(width: allBits[0].frame.size.width * CGFloat(1.1), height: (allBits[0].frame.size.height + allBits[1].frame.size.height) * CGFloat(1.1)), cornerRadius: CGFloat(3))
//            rect.fillColor = .clear
//            rect.lineWidth = 1
//            rect.strokeColor = .black
//            rect.position = CGPoint(x: frame.midX , y: frame.midY)
//            self.addChild(rect)
//            
//            let goal = (game.state?.goal)!
//            let topAnswer = SKLabelNode(fontNamed: "Helvetica Neue Thin")
//            let botAnswer = SKLabelNode(fontNamed: "Helvetica Neue Thin")
//            let rightAnswer = SKLabelNode(fontNamed: "Helvetica Neue Thin")
//            let leftAnswer = SKLabelNode(fontNamed: "Helvetica Neue Thin")
//            if goal.topState != nil{
//                topAnswer.text = goal.topState?.toStr()
//                topAnswer.fontColor = SKColor.darkGray
//                topAnswer.fontSize = 50
//                topAnswer.position = CGPoint(x: frame.midX, y: (rect.frame.maxY + CGFloat(2)))
//                self.addChild(topAnswer)
//            }
//            if goal.bottomState != nil{
//                botAnswer.text = goal.bottomState?.toStr()
//                botAnswer.fontColor = SKColor.darkGray
//                botAnswer.fontSize = 50
//                botAnswer.position = CGPoint(x: frame.midX, y: (rect.frame.minY - CGFloat(2)))
//                botAnswer.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
//                self.addChild(botAnswer)
//            }
//            if goal.rightState != nil{
//                rightAnswer.text = goal.rightState?.toStr()
//                rightAnswer.fontColor = SKColor.darkGray
//                rightAnswer.fontSize = 50
//                rightAnswer.position = CGPoint(x: frame.midX - (rect.frame.size.width * CGFloat(0.53)), y: frame.midY)
//                rightAnswer.zRotation = CGFloat(Double.pi/2)
//                self.addChild(rightAnswer)
//            }
//            if goal.leftState != nil{
//                leftAnswer.text = goal.leftState?.toStr()
//                leftAnswer.fontColor = SKColor.darkGray
//                leftAnswer.fontSize = 50
//                leftAnswer.position = CGPoint(x: frame.midX + (rect.frame.size.width * CGFloat(0.53)), y: frame.midY)
//                leftAnswer.zRotation = CGFloat(-Double.pi/2)
//                self.addChild(leftAnswer)
//            }
//            
//            // let answerRect = SKShapeNode(rectOf: CGSize(width: , height: ), cornerRadius: CGFloat(3))
//            
//            
//            
//            
//        }
//    }
//    
//    func respondToSwipe(gesture: UIGestureRecognizer)
//    {
//        if let swipe = gesture as? UISwipeGestureRecognizer
//        {
//            switch swipe.direction
//            {
//            case UISwipeGestureRecognizerDirection.right : gameAction(rowIndex: previousBit, action: "shift-right")
//            case UISwipeGestureRecognizerDirection.left : gameAction(rowIndex: previousBit, action: "shift-left")
//            case UISwipeGestureRecognizerDirection.up : gameAction(rowIndex: previousBit, action: "flip", numIndex: previousBitIndex)
//            case UISwipeGestureRecognizerDirection.down : gameAction(rowIndex: previousBit, action: "flip", numIndex: previousBitIndex)
//            default : break
//            }
//        }
//    }
//    
//    
//    func gameAction(rowIndex: Int, action: String, numIndex: Int? = nil)
//    {
//        gameState = game.action(rowIndex: rowIndex, action: action, numIndex: numIndex)!
//    }
//    
//    func touchDown(atPoint pos : CGPoint) {
//    }
//    
//    func touchMoved(toPoint pos : CGPoint) {
//    }
//    
//    func touchUp(atPoint pos : CGPoint) {
//    }
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch = touches.first!
//        for i in 0..<allBits.count
//        {
//            if allBits[i].contains(touch.location(in: self))
//            {
//                previousBit = i
//                calculateIndex(p: touch.location(in: self))
//            }
//        }
////        if allBits[0].contains(touch.location(in: self))
////        {
////            previousBit = 0
////            calculateIndex(p: touch.location(in: self))
////        }
////        else if allBits[1].contains(touch.location(in: self))
////        {
////            previousBit = 1
////            calculateIndex(p: touch.location(in: self))
////        }
//        // print(previousBitIndex)
//        
//    }
//    
//    private func calculateIndex(p: CGPoint)
//    {
//       // print("x: \(p.x)   y: \(p.y)")
//        var strLength = gameState?.currentState[0].toStr().characters.count
//        let strFrameWidth = allBits[0].frame.size.width / CGFloat(strLength!)
//        strLength = strLength! / 2
//        if p.x.isLess(than: 0)
//        {
//            let computedIndex = Int(p.x.negated() / strFrameWidth)
//            previousBitIndex = strLength! - computedIndex - 1
//        }
//        else
//        {
//            let computedIndex = Int(p.x/strFrameWidth)
//            let shiftedIndex = computedIndex + strLength!
//            previousBitIndex = shiftedIndex
//        }
//    }
//    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
////        for t in touches
////        {
////            self.touchMoved(toPoint: t.location(in: self))
////        }
//    }
//    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        //for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
//    
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//       // for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
//    
//    
//    override func update(_ currentTime: TimeInterval) {
//        // Called before each frame is rendered
//        if let state = gameState
//        {
//            for i in 0..<allBits.count
//            {
//                allBits[i].text = state.currentState[i].toStr()
//            }
//        }
//    }
//}
