//
//  GameScene.swift
//  Puppy Chow
//
//  Created by rkalvani on 9/19/16.
//  Copyright (c) 2016 rkalvani. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var apple : SKSpriteNode!
    var chocolate : SKSpriteNode!
    var banana : SKSpriteNode!
    var bread : SKSpriteNode!
    var iceCream : SKSpriteNode!
    var cheese : SKSpriteNode!
    var grapes : SKSpriteNode!
    var carrots : SKSpriteNode!
    var dogBowl : SKSpriteNode!
    var scoreLabel : SKLabelNode!
    var viewController = GameViewController()

    override func didMove(to view: SKView) {
        /* Setup your scene here */
        createBackground()
        createScore()
        createBowl()
        physicsWorld.gravity = CGVector(dx: 0, dy: -1) //creates gravity strength
        physicsWorld.contactDelegate = self
        chooseFood()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       /* Called when a touch begins */
        for touch in touches {
            dogBowl.position = CGPoint(x: touch.location(in: view).x, y: frame.height * 0.1)
        }
        //every time the screen is touched the bowl moves sideways inn the x direction to where you touched but not in the y direction up and down
            }
   
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if (contact.bodyA.node?.name == "good" && contact.bodyB.node?.name == "dogBowl") || (contact.bodyB.node?.name == "good" && contact.bodyA.node?.name == "dogBowl")
        {
            print("goodFood")
            if contact.bodyA.node?.name == "dogBowl" {
                contact.bodyB.node?.removeFromParent()
            }
            else {
                contact.bodyA.node?.removeFromParent()
            }
            scoreLabel.removeFromParent()
            viewController.scoreClass.score += 1
            createScore()
        }
        else if (contact.bodyA.node?.name == "bad" && contact.bodyB.node?.name == "dogBowl") || (contact.bodyB.node?.name == "bad" && contact.bodyA.node?.name == "dogBowl")
        {
            print("badFood")
            if contact.bodyA.node?.name == "dogBowl" {
                contact.bodyB.node?.removeFromParent()
            }
            else {
                contact.bodyA.node?.removeFromParent()
            }
            self.viewController.performSegue(withIdentifier: "gameOver", sender: viewController)
        }
    }
    func createBowl() {
        let bowlTexture = SKTexture(imageNamed: "sprite_dogBowl0")
        dogBowl = SKSpriteNode(texture: bowlTexture)
        dogBowl.zPosition = 10
        dogBowl.position = CGPoint(x: frame.midX , y: frame.height * 0.1 )
        dogBowl.physicsBody = SKPhysicsBody(rectangleOf: dogBowl.size)
        dogBowl.physicsBody?.contactTestBitMask = (dogBowl.physicsBody?.collisionBitMask)!
        dogBowl.physicsBody?.collisionBitMask = 0
        dogBowl.physicsBody?.isDynamic = true
        dogBowl.physicsBody?.affectedByGravity = false
        dogBowl.name = "dogBowl"
        addChild(dogBowl)
    }
    
    func createScore() {
        // creates the score label
        scoreLabel = SKLabelNode(fontNamed: "Marker Felt Wide")
        scoreLabel.fontSize = 25
        scoreLabel.position = CGPoint(x: frame.maxX - 20, y: frame.maxY - 40)
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.text = "SCORE: \(viewController.scoreClass.score)"
        scoreLabel.fontColor = UIColor.black
        
        addChild(scoreLabel)
    }
    
    func chooseFood() {
        let create = SKAction.run() {
        let number = Int(arc4random_uniform(UInt32(9))) //chooses a random number to pick a random food
        if number == 1 { // creates the fruit associated with the number
            self.createApple()
        }
        if number == 2 {
            self.createBread()
        }
        if number == 3 {
            self.createBanana()
        }
        if number == 4 {
            self.createCheese()
        }
        if number == 5 {
            self.createGrapes()
        }
        if number == 6 {
            self.createIceCream()
        }
        if number == 7 {
            self.createChocolate()
        }
        if number == 8 {
            self.createCarrots()
        }
        }
        let wait = SKAction.wait(forDuration: 3) // wait 3 seconds in between dropping fruit
        let sequence = SKAction.sequence([create,wait]) //creates sequence with both actions
        run(SKAction.repeatForever(sequence)) // runs the sequence
    }
    
    func createBackground() {
        //creates the upper part of the background
        let topBackground = SKSpriteNode(color: UIColor(hue: 3.59, saturation: 0.2, brightness: 1, alpha: 1), size: CGSize(width: frame.width, height: frame.height * 0.9))
        topBackground.anchorPoint = CGPoint(x: 0.5, y: 1)
      //  creates the brown bottom background
        let bottomBackground = SKSpriteNode(color: UIColor.brown, size: CGSize(width: frame.width, height: frame.height * 0.1))
        bottomBackground.anchorPoint = CGPoint(x: 0.5, y: 1)
     //   sets position and adds to screen
        topBackground.position = CGPoint(x: frame.midX, y: frame.height)
        bottomBackground.position = CGPoint(x: frame.midX, y: bottomBackground.frame.height)
        topBackground.zPosition = -40
        bottomBackground.zPosition = -40
        addChild(topBackground)
        addChild(bottomBackground)
        

            let sparkleTexture = SKTexture(imageNamed: "4spark")
            //loop to make lager sparkles at bottom
            for i in 0...2 {
                let sparkle = SKSpriteNode(texture: sparkleTexture)
                sparkle.zPosition = -30
                sparkle.anchorPoint = CGPoint.zero
                sparkle.position = CGPoint(x: (sparkleTexture.size().width * CGFloat(i))-CGFloat(1*i), y: frame.height * 0.1)
                addChild(sparkle)
                //shifts sparkles and recreates it
                let moveLeft = SKAction.moveBy( x: -sparkleTexture.size().width, y: 0, duration: 10)
                let moveReset = SKAction.moveBy(x: sparkleTexture.size().width, y: 0, duration: 0)
                let moveLoop = SKAction.sequence([moveLeft, moveReset])
                sparkle.run(SKAction.repeatForever(moveLoop))
    }
        let smallSparkleTexture = SKTexture(imageNamed: "8spark")
        //loop to make smaller sparkles
        for i in 0...2 {
            let sparkles = SKSpriteNode(texture: smallSparkleTexture)
            sparkles.zPosition = -30
            sparkles.anchorPoint = CGPoint.zero
            sparkles.position = CGPoint(x: (smallSparkleTexture.size().width * CGFloat(i))-CGFloat(1*i), y: frame.height * 0.45)
            addChild(sparkles)
            //shifts sparkles and recreates it
            let moveLeft = SKAction.moveBy( x: -smallSparkleTexture.size().width, y: 0, duration: 10)
            let moveReset = SKAction.moveBy(x: smallSparkleTexture.size().width, y: 0, duration: 0)
            let moveLoop = SKAction.sequence([moveLeft, moveReset])
            sparkles.run(SKAction.repeatForever(moveLoop))
        }
    }
    
    func createApple() {
        let appleTexture = SKTexture(imageNamed: "sprite_apple0") //sets image texture
        apple = SKSpriteNode(texture: appleTexture) //sets texture to node
        apple.zPosition = 10 //stacking order
        let rand = GKRandomDistribution(lowestValue: Int(frame.minX), highestValue: Int(frame.maxX)) //random selection of point from which to drop
        apple.position = CGPoint(x: CGFloat(rand.nextInt()) , y: frame.maxY) //location on view
        apple.physicsBody = SKPhysicsBody(rectangleOf: apple.size) // sets up physics for node
        apple.physicsBody?.contactTestBitMask = (apple.physicsBody?.collisionBitMask)! //tells us of any collisions
        apple.physicsBody?.collisionBitMask = 0 //adds the bounce off nothing
        let frame2 = SKTexture(imageNamed: "sprite_apple1")
        let frame3 = SKTexture(imageNamed: "sprite_apple2")
        let frame4 = SKTexture(imageNamed: "sprite_apple3")
        let animation = SKAction.animate(with: [appleTexture,frame2,frame3,frame4], timePerFrame: 0.5) //setting textures for an anmation loop
        let runForever = SKAction.repeatForever(animation) //sets the animation to loop over and over
        apple.run(runForever) //runs the animation on the node
        apple.name = "good"
        apple.physicsBody?.isDynamic = true //makes the fruit respond to physics
        apple.physicsBody?.affectedByGravity = true
       // name identifies as good or bad food for the contact method
        addChild(apple)
        //all same comments for the rest of the fruit below
    }
    
    func createBanana() {
        let bananaTexture = SKTexture(imageNamed: "sprite_banana0")
        banana = SKSpriteNode(texture: bananaTexture)
        banana.zPosition = 10
        let rand = GKRandomDistribution(lowestValue: Int(frame.minX), highestValue: Int(frame.maxX))
        banana.position = CGPoint(x: CGFloat(rand.nextInt()) , y: frame.maxY)
        banana.physicsBody = SKPhysicsBody(rectangleOf: banana.size)
        banana.physicsBody?.contactTestBitMask = (banana.physicsBody?.collisionBitMask)!
        banana.physicsBody?.collisionBitMask = 0
        let frame2 = SKTexture(imageNamed: "sprite_banana1")
        let frame3 = SKTexture(imageNamed: "sprite_banana2")
        let frame4 = SKTexture(imageNamed: "sprite_banana3")
        let animation = SKAction.animate(with: [bananaTexture,frame2,frame3,frame4], timePerFrame: 0.5)
        let runForever = SKAction.repeatForever(animation)
        banana.run(runForever)
        banana.physicsBody?.isDynamic = true
        banana.physicsBody?.affectedByGravity = true
        banana.name = "good"
        addChild(banana)
    }
    
    func createBread() {
        let breadTexture = SKTexture(imageNamed: "sprite_bread0")
        bread = SKSpriteNode(texture: breadTexture)
        bread.zPosition = 10
        let rand = GKRandomDistribution(lowestValue: Int(frame.minX), highestValue: Int(frame.maxX))
        bread.position = CGPoint(x: CGFloat(rand.nextInt()) , y: frame.maxY)
        bread.physicsBody = SKPhysicsBody(rectangleOf: bread.size)
        bread.physicsBody?.contactTestBitMask = (bread.physicsBody?.collisionBitMask)!
        bread.physicsBody?.collisionBitMask = 0
        let frame2 = SKTexture(imageNamed: "sprite_bread1")
        let frame3 = SKTexture(imageNamed: "sprite_bread2")
        let frame4 = SKTexture(imageNamed: "sprite_bread3")
        let animation = SKAction.animate(with: [breadTexture,frame2,frame3,frame4], timePerFrame: 0.5)
        let runForever = SKAction.repeatForever(animation)
        bread.run(runForever)
        bread.physicsBody?.isDynamic = true
        bread.physicsBody?.affectedByGravity = true
        bread.name = "good"
        addChild(bread)
    }
    
    func createChocolate() {
        let chocolateTexture = SKTexture(imageNamed: "sprite_chocolateBar0")
        chocolate = SKSpriteNode(texture: chocolateTexture)
        chocolate.zPosition = 10
        let rand = GKRandomDistribution(lowestValue: Int(frame.minX), highestValue: Int(frame.maxX))
        chocolate.position = CGPoint(x: CGFloat(rand.nextInt()) , y: frame.maxY)
        chocolate.physicsBody = SKPhysicsBody(rectangleOf: chocolate.size)
        chocolate.physicsBody?.contactTestBitMask = (chocolate.physicsBody?.collisionBitMask)!
        chocolate.physicsBody?.collisionBitMask = 0
        let frame2 = SKTexture(imageNamed: "sprite_chocolateBar1")
        let frame3 = SKTexture(imageNamed: "sprite_chocolateBar2")
        let frame4 = SKTexture(imageNamed: "sprite_chocolateBar3")
        let animation = SKAction.animate(with: [chocolateTexture,frame2,frame3,frame4], timePerFrame: 0.5)
        let runForever = SKAction.repeatForever(animation)
        chocolate.run(runForever)
        chocolate.physicsBody?.isDynamic = true
        chocolate.physicsBody?.affectedByGravity = true
        chocolate.name = "bad"
        addChild(chocolate)
    }
    
    func createIceCream() {
        let IceCreamTexture = SKTexture(imageNamed: "sprite_IceCream0")
        iceCream = SKSpriteNode(texture: IceCreamTexture)
        iceCream.zPosition = 10
        let rand = GKRandomDistribution(lowestValue: Int(frame.minX), highestValue: Int(frame.maxX))
        iceCream.position = CGPoint(x: CGFloat(rand.nextInt()) , y: frame.maxY)
        iceCream.physicsBody = SKPhysicsBody(rectangleOf: iceCream.size)
        iceCream.physicsBody?.contactTestBitMask = (iceCream.physicsBody?.collisionBitMask)!
        iceCream.physicsBody?.collisionBitMask = 0
        let frame2 = SKTexture(imageNamed: "sprite_IceCream1")
        let frame3 = SKTexture(imageNamed: "sprite_IceCream2")
        let frame4 = SKTexture(imageNamed: "sprite_IceCream3")
        let animation = SKAction.animate(with: [IceCreamTexture,frame2,frame3,frame4], timePerFrame: 0.5)
        let runForever = SKAction.repeatForever(animation)
        iceCream.run(runForever)
        iceCream.physicsBody?.isDynamic = true
        iceCream.physicsBody?.affectedByGravity = true
        iceCream.name = "bad"
        addChild(iceCream)
    }
    
    func createCheese() {
        let cheeseTexture = SKTexture(imageNamed: "sprite_cheese0")
        cheese = SKSpriteNode(texture: cheeseTexture)
        cheese.zPosition = 10
        let rand = GKRandomDistribution(lowestValue: Int(frame.minX), highestValue: Int(frame.maxX))
        cheese.position = CGPoint(x: CGFloat(rand.nextInt()) , y: frame.maxY)
        cheese.physicsBody = SKPhysicsBody(rectangleOf: cheese.size)
        cheese.physicsBody?.contactTestBitMask = (cheese.physicsBody?.collisionBitMask)!
        cheese.physicsBody?.collisionBitMask = 0
        let frame2 = SKTexture(imageNamed: "sprite_cheese1")
        let frame3 = SKTexture(imageNamed: "sprite_cheese2")
        let frame4 = SKTexture(imageNamed: "sprite_cheese3")
        let animation = SKAction.animate(with: [cheeseTexture,frame2,frame3,frame4], timePerFrame: 0.5)
        let runForever = SKAction.repeatForever(animation)
        cheese.run(runForever)
        cheese.physicsBody?.isDynamic = true
        cheese.physicsBody?.affectedByGravity = true
        cheese.name = "bad"
        addChild(cheese)
    }
    
    func createGrapes() {
        let grapesTexture = SKTexture(imageNamed: "sprite_grapes0")
        grapes = SKSpriteNode(texture: grapesTexture)
        grapes.zPosition = 10
        let rand = GKRandomDistribution(lowestValue: Int(frame.minX), highestValue: Int(frame.maxX))
        grapes.position = CGPoint(x: CGFloat(rand.nextInt()) , y: frame.maxY)
        grapes.physicsBody = SKPhysicsBody(rectangleOf: grapes.size)
        grapes.physicsBody?.contactTestBitMask = (grapes.physicsBody?.collisionBitMask)!
        grapes.physicsBody?.collisionBitMask = 0
        let frame2 = SKTexture(imageNamed: "sprite_grapes1")
        let frame3 = SKTexture(imageNamed: "sprite_grapes2")
        let frame4 = SKTexture(imageNamed: "sprite_grapes3")
        let animation = SKAction.animate(with: [grapesTexture,frame2,frame3,frame4], timePerFrame: 0.5)
        let runForever = SKAction.repeatForever(animation)
        grapes.run(runForever)
        grapes.physicsBody?.isDynamic = true
        grapes.physicsBody?.affectedByGravity = true
        grapes.name = "bad"
        addChild(grapes)
    }
    
    func createCarrots() {
        let carrotTexture = SKTexture(imageNamed: "sprite_carrot0")
        carrots = SKSpriteNode(texture: carrotTexture)
        carrots.zPosition = 10
        let rand = GKRandomDistribution(lowestValue: Int(frame.minX), highestValue: Int(frame.maxX))
        carrots.position = CGPoint(x: CGFloat(rand.nextInt()) , y: frame.maxY)
        carrots.physicsBody = SKPhysicsBody(rectangleOf: carrots.size)
        carrots.physicsBody?.contactTestBitMask = (carrots.physicsBody?.collisionBitMask)!
        carrots.physicsBody?.collisionBitMask = 0
        let frame2 = SKTexture(imageNamed: "sprite_carrot1")
        let frame3 = SKTexture(imageNamed: "sprite_carrot2")
        let frame4 = SKTexture(imageNamed: "sprite_carrot3")
        let animation = SKAction.animate(with: [carrotTexture,frame2,frame3,frame4], timePerFrame: 0.5)
        let runForever = SKAction.repeatForever(animation)
        carrots.run(runForever)
        carrots.physicsBody?.isDynamic = true
        carrots.physicsBody?.affectedByGravity = true
        carrots.name = "good"
        addChild(carrots)
    }
}




