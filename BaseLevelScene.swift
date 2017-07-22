//
//  BaseLevelScene.swift
//  PWB
//
//  Created by Nicholas Wei on 7/21/17.
//  Copyright © 2017 Nicholas Wei. All rights reserved.
//

struct Constants
{
    static let rectOffset = 1.1
    static let twoCountOffset = 1.1
    static let threeCountOffset = 2.0
    static let levelLabelOffset = 0.7
    
    static let rectCornerRadius = CGFloat(3)
    static let answerLabelOffset = CGFloat(2)
    static let answerWidthOffset = CGFloat(0.53)
    static let rotate45degCounter = CGFloat(Double.pi/2)
    static let rotate45degClock = CGFloat(-Double.pi/2)
    
    static let displayFont = "Helvetica Neue UltraLight"
    static let problemFont = "CourierNewPSMT"
    static let answerFont = "Helvetica Neue Thin"
}

import SpriteKit

class BaseLevelScene: SKScene {
    
    private var levelLabel : SKLabelNode! = nil
    private var game: PWBLevel!
    private var allBits: [SKLabelNode] = []
    private var previousBit: Int = -1
    private var previousBitIndex: Int = -1
    private var gameState: PWBLevel.GameState?
    
    private var swipeRight: UISwipeGestureRecognizer! = nil
    private var swipeLeft: UISwipeGestureRecognizer! = nil
    private var swipeUp: UISwipeGestureRecognizer! = nil
    private var swipeDown: UISwipeGestureRecognizer! = nil
    
    private var rect: SKShapeNode! = nil
    
    override func didMove(to view: SKView) {    // almost equivalent of init(), game MUST be initialized with self.initGame() before calling this method

        // recommended order to initialize everything, the placement of some nodes depends on the placement of previously initialized nodes
        // self.testInit()
        self.setupSwipeGestures(ofView: view)
        self.setupLevelLabel()
        self.setupProblemLabels()
        self.setupContainerRect()
        self.setupProblemPositions()
        self.setupAnswerLabels()

    }
    
    func initLevel(fromLevel: PWBLevel) // MUST BE CALLED BEFORE super.didMoveToView() in whatever class subclasses this class
    {
        game = fromLevel
        game.start()
        gameState = game.state
    }
    
    private func testInit()
    {
       // game = constructTestLevelWithTwoBits()!
        game.start()
        gameState = game.state
    }
    
    private func setupSwipeGestures(ofView view: SKView)
    {
        swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipe))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        view.addGestureRecognizer(swipeRight)
        
        swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipe))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        view.addGestureRecognizer(swipeLeft)
        
        swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipe))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        view.addGestureRecognizer(swipeUp)
        
        swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipe))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        view.addGestureRecognizer(swipeDown)
    }
    
    @objc private func respondToSwipe(gesture: UIGestureRecognizer)
    {
        if let swipe = gesture as? UISwipeGestureRecognizer
        {
            switch swipe.direction
            {
            case UISwipeGestureRecognizerDirection.right : if previousBit != -1 { gameAction(rowIndex: previousBit, action: "shift-right") }
            case UISwipeGestureRecognizerDirection.left : if previousBit != -1 {gameAction(rowIndex: previousBit, action: "shift-left") }
            case UISwipeGestureRecognizerDirection.up : if previousBitIndex !=  -1 {gameAction(rowIndex: previousBit, action: "flip", numIndex: previousBitIndex) }
            case UISwipeGestureRecognizerDirection.down : if previousBitIndex != -1 {gameAction(rowIndex: previousBit, action: "flip", numIndex: previousBitIndex) }
            default : break
            }
        }
    }
    
    private func setupLevelLabel()  // where the level name will be displayed on screen to user
    {
        levelLabel = SKLabelNode(fontNamed: Constants.displayFont)
        levelLabel.text = game.levelName
        levelLabel.fontSize = 35
        levelLabel.fontColor = SKColor.black
        levelLabel.position = CGPoint(x: frame.midX, y: frame.maxY * CGFloat(Constants.levelLabelOffset))
        self.addChild(levelLabel)
    }
    
    private func setupProblemLabels()   // construct labels that will be manipulated
    {
        for bit in (game.state?.currentState)!
        {
            allBits.append(SKLabelNode(text: bit.toStr()))
        }
        
        for i in 0..<allBits.count
        {
            allBits[i].fontColor = SKColor.black
            allBits[i].fontSize = 50
            allBits[i].fontName = Constants.problemFont  // this is the only monospaced font that will work with SKLabelNode askdlsakdlas;kd;lsad;sakdsa
            self.addChild(allBits[i])
        }
        
    }
    
    private func setupProblemPositions()
    {
        // print(rect.frame.size.height)
        let textStartOffset = CGFloat(0.9)
        let startPos = (rect.frame.size.height * CGFloat(0.5)) * textStartOffset
        let textHeight = allBits[0].frame.size.height
        
        for i in 0..<allBits.count
        {
            allBits[i].position = CGPoint(x: frame.midX, y: (startPos - (textHeight * CGFloat(i))))
            allBits[i].verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        }
    }
    
    private func setupContainerRect()   // construct rectangle that will surround the problem labels
    {
        let width = allBits[0].frame.size.width * CGFloat(Constants.rectOffset)
        let height = allBits.reduce(CGFloat(0), {return $0 + $1.frame.size.height})
        rect = SKShapeNode(rectOf: CGSize(width: width,
                                              height: height * CGFloat(Constants.rectOffset)), cornerRadius: Constants.rectCornerRadius)
        rect.fillColor = .clear
        rect.lineWidth = 1
        rect.strokeColor = .black
        rect.position = CGPoint(x: frame.midX , y: frame.midY)
        self.addChild(rect)
    }
    
    private func setupAnswerLabels()
    {
        let goal = (game.state?.goal)!
        let topAnswer = SKLabelNode(fontNamed: Constants.answerFont)
        let botAnswer = SKLabelNode(fontNamed: Constants.answerFont)
        let rightAnswer = SKLabelNode(fontNamed: Constants.answerFont)
        let leftAnswer = SKLabelNode(fontNamed: Constants.answerFont)
        if goal.topState != nil{
            topAnswer.text = goal.topState?.toStr()
            topAnswer.fontColor = SKColor.darkGray
            topAnswer.fontSize = 50
            topAnswer.position = CGPoint(x: frame.midX, y: (rect.frame.maxY + Constants.answerLabelOffset))
            self.addChild(topAnswer)
        }
        if goal.bottomState != nil{
            botAnswer.text = goal.bottomState?.toStr()
            botAnswer.fontColor = SKColor.darkGray
            botAnswer.fontSize = 50
            botAnswer.position = CGPoint(x: frame.midX, y: (rect.frame.minY - Constants.answerLabelOffset))
            botAnswer.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
            self.addChild(botAnswer)
        }
        if goal.rightState != nil{
            rightAnswer.text = goal.rightState?.toStr()
            rightAnswer.fontColor = SKColor.darkGray
            rightAnswer.fontSize = 50
            rightAnswer.position = CGPoint(x: frame.midX - (rect.frame.size.width * Constants.answerWidthOffset), y: frame.midY)
            rightAnswer.zRotation = Constants.rotate45degCounter
            self.addChild(rightAnswer)
        }
        if goal.leftState != nil{
            leftAnswer.text = goal.leftState?.toStr()
            leftAnswer.fontColor = SKColor.darkGray
            leftAnswer.fontSize = 50
            leftAnswer.position = CGPoint(x: frame.midX + (rect.frame.size.width * Constants.answerWidthOffset), y: frame.midY)
            leftAnswer.zRotation = Constants.rotate45degClock
            self.addChild(leftAnswer)
        }
    }
    
    private func gameAction(rowIndex: Int, action: String, numIndex: Int? = nil)
    {
        gameState = game.action(rowIndex: rowIndex, action: action, numIndex: numIndex)!
        // self.resetBits()
    }
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        self.resetBits()
        for i in 0..<allBits.count
        {
            if allBits[i].contains(touch.location(in: self))
            {
                previousBit = i
                calculateIndex(p: touch.location(in: self))
            }
        }
    }
    
    private func resetBits()
    {
        previousBit = -1
        previousBitIndex = -1
    }
    
    private func calculateIndex(p: CGPoint)
    {
        // print("x: \(p.x)   y: \(p.y)")
        var strLength = gameState?.currentState[0].toStr().characters.count
        let strFrameWidth = allBits[0].frame.size.width / CGFloat(strLength!)
        strLength = strLength! / 2
        if p.x.isLess(than: 0)
        {
            let computedIndex = Int(p.x.negated() / strFrameWidth)
            previousBitIndex = strLength! - computedIndex - 1
        }
        else
        {
            let computedIndex = Int(p.x/strFrameWidth)
            let shiftedIndex = computedIndex + strLength!
            previousBitIndex = shiftedIndex
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        for t in touches
        //        {
        //            self.touchMoved(toPoint: t.location(in: self))
        //        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        // for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if let state = gameState
        {
            for i in 0..<allBits.count
            {
                allBits[i].text = state.currentState[i].toStr()
            }
        }
    }

    

} // class
