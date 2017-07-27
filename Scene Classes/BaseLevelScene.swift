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
    static let answerFont = "CourierNewPSMT"//"Helvetica Neue Thin"
    static let displayFontSize = CGFloat(55)
}

import SpriteKit

class BaseLevelScene: SKScene {
    
    private var levelLabel : SKLabelNode! = nil
    private var game: PWBLevel!
    private var allBits: [SKLabelNode] = []
    private var previousBit: Int = -1
    private var previousBitIndex: Int = -1
    private var gameState: PWBLevel.GameState?
    {
        return game.state
    }
    
    private var swipeRight: UISwipeGestureRecognizer! = nil
    private var swipeLeft: UISwipeGestureRecognizer! = nil
    private var swipeUp: UISwipeGestureRecognizer! = nil
    private var swipeDown: UISwipeGestureRecognizer! = nil
    
    private var continueLabel: SKLabelNode! = nil
    
    private var rect: SKShapeNode! = nil
    
    var problemContainer: SKShapeNode!
    {
        return rect
    }
    
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
        // gameState = game.state
    }
    
    func restartGame()
    {
        // print("restarting game")
        game.start()
        levelLabel.text = game.levelName
        if continueLabel != nil
        {
            continueLabel.text = ""
        }
    }
    
    // may improve this later but for now just need it working
    func addUpArrowOperation(operation: String)
    {
        let upArrow = SKSpriteNode(imageNamed: "PWBArrow")
        upArrow.zRotation = Constants.rotate45degCounter
        upArrow.position = CGPoint(x: rect.frame.minX + CGFloat(1.5), y: rect.frame.maxY + CGFloat(10))
        upArrow.size = CGSize(width: CGFloat(50), height: CGFloat(11))
        
        let topOp = SKLabelNode(fontNamed: Constants.problemFont)
        topOp.fontSize = 20
        topOp.fontColor = SKColor.darkGray
        topOp.text = operation
        topOp.position = CGPoint(x: rect.frame.minX - CGFloat(5), y: rect.frame.maxY + CGFloat(5))
        topOp.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        
        self.addChild(upArrow)
        self.addChild(topOp)
    }
    
    func addDownArrowOperation(operation: String)
    {
        let botArrow = SKSpriteNode(imageNamed: "PWBArrow")
        botArrow.zRotation = Constants.rotate45degClock
        botArrow.position = CGPoint(x: rect.frame.maxX - CGFloat(1.5), y: rect.frame.minY - CGFloat(10))
        botArrow.size = CGSize(width: CGFloat(50), height: CGFloat(11))
        
        let botOp = SKLabelNode(fontNamed: Constants.problemFont)
        botOp.fontSize = 20
        botOp.fontColor = SKColor.darkGray
        botOp.text = "ADD"
        botOp.position = CGPoint(x: rect.frame.maxX + CGFloat(5), y: rect.frame.minY - CGFloat(5))
        botOp.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        botOp.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        
        self.addChild(botArrow)
        self.addChild(botOp)
    }
    
    func addRightArrowOperation(operation: String)
    {
        
        let rightArrow = SKSpriteNode(imageNamed: "PWBArrow")
        rightArrow.position = CGPoint(x: rect.frame.maxX + CGFloat(10), y: rect.frame.maxY - CGFloat(1.5))
        rightArrow.size = CGSize(width: CGFloat(50), height: CGFloat(11))
        
        let rightOp = SKLabelNode(fontNamed: Constants.problemFont)
        rightOp.fontSize = 20
        rightOp.fontColor = SKColor.darkGray
        rightOp.text = "OR"
        rightOp.position = CGPoint(x: rect.frame.maxX + CGFloat(5), y: rect.frame.maxY + CGFloat(5))
        rightOp.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        
        self.addChild(rightArrow)
        self.addChild(rightOp)
    }
    
    func addLeftArrowOperation(operation: String)
    {
        let leftArrow = SKSpriteNode(imageNamed: "PWBArrow")
        leftArrow.zRotation = Constants.rotate45degCounter * CGFloat(2)
        leftArrow.position = CGPoint(x: rect.frame.minX - CGFloat(10), y: rect.frame.minY + CGFloat(1.5))
        leftArrow.size = CGSize(width: CGFloat(50), height: CGFloat(11))
        
        let leftOp = SKLabelNode(fontNamed: Constants.problemFont)
        leftOp.fontSize = 20
        leftOp.fontColor = SKColor.darkGray
        leftOp.text = "NOT"
        leftOp.position = CGPoint(x: rect.frame.minX - CGFloat(5), y: rect.frame.minY - CGFloat(5))
        leftOp.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        leftOp.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        
        self.addChild(leftArrow)
        self.addChild(leftOp)
    }
    
    private func testInit()
    {
       // game = constructTestLevelWithTwoBits()!
        game.start()
        // gameState = game.state
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
            allBits[i].fontSize = Constants.displayFontSize
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
        let width = allBits[0].frame.size.width * CGFloat(Constants.rectOffset + 0.05)
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
            topAnswer.fontSize = Constants.displayFontSize
            topAnswer.position = CGPoint(x: frame.midX, y: (rect.frame.maxY + Constants.answerLabelOffset))
            self.addChild(topAnswer)
        }
        if goal.bottomState != nil{
            botAnswer.text = goal.bottomState?.toStr()
            botAnswer.fontColor = SKColor.darkGray
            botAnswer.fontSize = Constants.displayFontSize
            botAnswer.position = CGPoint(x: frame.midX, y: (rect.frame.minY - Constants.answerLabelOffset))
            botAnswer.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
            self.addChild(botAnswer)
        }
        if goal.rightState != nil{
            rightAnswer.text = goal.rightState?.toStr()
            rightAnswer.fontColor = SKColor.darkGray
            rightAnswer.fontSize = Constants.displayFontSize
            rightAnswer.position = CGPoint(x: frame.midX + (rect.frame.size.width * Constants.answerWidthOffset), y: frame.midY) // CGPoint(x: frame.midX - (rect.frame.size.width * Constants.answerWidthOffset), y: frame.midY)
            rightAnswer.zRotation = Constants.rotate45degClock// Constants.rotate45degCounter
            self.addChild(rightAnswer)
        }
        if goal.leftState != nil{
            leftAnswer.text = goal.leftState?.toStr()
            leftAnswer.fontColor = SKColor.darkGray
            leftAnswer.fontSize = Constants.displayFontSize
            leftAnswer.position = CGPoint(x: frame.midX - (rect.frame.size.width * Constants.answerWidthOffset), y: frame.midY) // CGPoint(x: frame.midX + (rect.frame.size.width * Constants.answerWidthOffset), y: frame.midY)
            leftAnswer.zRotation = Constants.rotate45degCounter// Constants.rotate45degClock
            self.addChild(leftAnswer)
        }
    }
    
    private func gameAction(rowIndex: Int, action: String, numIndex: Int? = nil)
    {
        game.action(rowIndex: rowIndex, action: action, numIndex: numIndex)
        if (game.state?.completed)!
        {
            self.addNextLevelLabel()
        }
        // self.resetBits()
    }
    
    // this functionality will be moved to each individual level scene class later
    private func addNextLevelLabel()
    {
        if continueLabel == nil
        {
            continueLabel = SKLabelNode(fontNamed: Constants.displayFont)
            self.addChild(continueLabel)
        }
        continueLabel.text = "Next Level"
        continueLabel.fontSize = 30
        continueLabel.fontColor = SKColor.blue
        continueLabel.position = CGPoint(x: rect.frame.width * CGFloat(1.5), y: frame.midY)
        continueLabel.name = "continue"
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
            let location = touch.location(in: self)
            if allBits[i].contains(location)
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
            if state.completed
            {
                levelLabel.text = "Puzzle Solved!"
            }
        }
    }

    

} // class
