//
//  GameScene.swift
//  BubbleTrouble
//
//  Created by Sebastien REMY on 01/11/2022.
//

import SpriteKit

class GameScene: SKScene {
    var bubbleTextures = [SKTexture]()
    var currentBubbleTexture = 0
    var maximumNumber = 1
    var bubbles = [SKSpriteNode]()
    
     override func didMove(to view: SKView) {
         bubbleTextures.append(SKTexture(imageNamed: "bubbleBlue"))
         bubbleTextures.append(SKTexture(imageNamed: "bubbleCyan"))
         bubbleTextures.append(SKTexture(imageNamed: "bubbleGray"))
         bubbleTextures.append(SKTexture(imageNamed: "bubbleGreen"))
         bubbleTextures.append(SKTexture(imageNamed: "bubbleOrange"))
         bubbleTextures.append(SKTexture(imageNamed: "bubblePink"))
         bubbleTextures.append(SKTexture(imageNamed: "bubblePurple"))
         bubbleTextures.append(SKTexture(imageNamed: "bubbleRed"))
         
         // pysics
         physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
         physicsWorld.gravity = CGVector.zero
         
         // Create bubbles
         for _ in 1...8 {
             createBubble()
         }
    }
    
    func createBubble() {
        // 1. create a new sprite
        let bubble = SKSpriteNode(texture: bubbleTextures[currentBubbleTexture])
        // 2. give it a stringifield version of our current number
        bubble.name = String(maximumNumber)
        
        // 3. give a z position of 1 to draw it above any background
        bubble.zPosition = 1
        
        // 4. create a label nide with the current number
        let label = SKLabelNode(fontNamed: "HeleveticaNue-Light")
        label.text = bubble.name
        label.color = NSColor.white
        label.fontSize = 64
        
        // 5. make the label center it vertically and draw above the bubble
        label.verticalAlignmentMode = .center
        label.zPosition = 2
        
        // 6. add the label to the bubble then the bubble to the game scene
        bubble.addChild(label)
        addChild(bubble)
        
        // 7. add the new bubble to our array of bubbles
        bubbles.append(bubble)
        
        // 8. make it appear somewhere inside ou game scene
        let xPos = Int.random(in: 0..<800)
        let yPos = Int.random(in: 0..<600)
        bubble.position = CGPoint(x: xPos, y: yPos)
        
        // physics
        configurePhysics(for: bubble)
        
        // Next
        nextBubble()
    }
    
    
    
    func nextBubble() {
        // move on the next bubble texture
        currentBubbleTexture += 1
        
        // if we've use all the textures start at the begining
        if currentBubbleTexture == bubbleTextures.count {
            currentBubbleTexture = 0
        }
        
        // add a random number between 1 & 3 to maximumNumber
        maximumNumber += Int.random(in: 1...3)
        
        // fix the mystery problem (don't use 6 and 9 beacause they are similar when the turn
        let strMaximumNumber = String(maximumNumber)
        
        if strMaximumNumber.last! == "6" {
            maximumNumber += 1
        }
        
        if strMaximumNumber.last! == "9" {
            maximumNumber += 1
        }
    }
    
    func configurePhysics(for bubble: SKSpriteNode) {
        bubble.physicsBody = SKPhysicsBody(circleOfRadius: bubble.size.width / 2)
        bubble.physicsBody?.linearDamping = 0.0
        bubble.physicsBody?.angularDamping = 0.0
        bubble.physicsBody?.restitution = 1.0
        bubble.physicsBody?.friction = 0.0
        
        let motionX = Double.random(in: -200...200)
        let motionY = Double.random(in: -200...200)
        
        bubble.physicsBody?.velocity = CGVector(dx: motionX, dy: motionY)
        bubble.physicsBody?.angularVelocity = Double.random(in: 0...1)
        
    }
}
