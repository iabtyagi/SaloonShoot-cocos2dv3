//
//  ParticleEffectMuzzleFlash.m
//  SaloonShoot
//
//  Created by Abhinav Tyagi on 22/02/14.
//  Copyright (c) 2014 Abhinav Tyagi. All rights reserved.
//

#import "ParticleEffectMuzzleFlash.h"

@implementation ParticleEffectMuzzleFlash

-(id) init
{
	return [self initWithTotalParticles:200];
}

-(id) initWithTotalParticles:(NSUInteger)numParticles
{
	if ((self = [super initWithTotalParticles:numParticles]))
	{
		// DURATION
		// most effects use infinite duration
		//self.duration = kCCParticleDurationInfinity;
		// for timed effects use a number in seconds how long particles should be emitted
		self.duration = 0.05f;
		// If the particle system runs for a fixed time, this will remove the particle system node from
		// its parent once all particles have died. Has no effect for infinite particle systems.
		self.autoRemoveOnFinish = YES;
        
		// MODE
		// particles are affected by gravity
		self.emitterMode = CCParticleSystemModeGravity;
		// particles move in a circle instead
		//self.emitterMode = kCCParticleModeRadius;
		
		// some properties must only be used with a specific emitterMode!
		if (self.emitterMode == CCParticleSystemModeGravity)
		{
			// sourcePosition determines the offset where particles appear. The actual
			// center of gravity is the node's position.
			self.sourcePosition = CGPointMake(0, 0);
			// gravity determines the particle's speed in the x and y directions
			self.gravity = CGPointMake(0, 0);
			// radial acceleration affects how fast particles move depending on their distance to the emitter
			// positive radialAccel means particles speed up as they move away, negative means they slow down
			self.radialAccel = 0;
			self.radialAccelVar = 0;
			// tangential acceleration lets particles rotate around the emitter position,
			// and they speed up as they rotate around (slingshot effect)
			self.tangentialAccel = 0;
			self.tangentialAccelVar = 0;
			// speed is of course how fast particles move in general
			self.speed = 210;
			self.speedVar = 150;
		}
		else if (self.emitterMode == CCParticleSystemModeRadius)
		{
			// the distance from the emitter position that particles will be spawned and sent out
			// in a radial (circular) fashion
			self.startRadius = 100;
			self.startRadiusVar = 0;
			// the end radius the particles move towards, if less than startRadius particles will move
			// inwards, if greater than startRadius particles will move outward
			// you can use the keyword kCCParticleStartRadiusEqualToEndRadius to create a perfectly circular rotation
			self.endRadius = 10;
			self.endRadiusVar = 0;
			// how fast the particles rotate around
			self.rotatePerSecond = 180;
			self.rotatePerSecondVar = 0;
		}
        
		// EMITTER POSITION
		// emitter position is at the center of the node (default)
		// this is where new particles will appear
		self.position = CGPointZero;//CGPointMake(160, 246);
		self.posVar = CGPointZero;
		// The positionType determines if existing particles should be repositioned when the node is moving
		// (kCCPositionTypeGrouped) or if the particles should remain where they are (kCCPositionTypeFree).
		self.particlePositionType = CCParticleSystemPositionTypeFree;
		
		// PARTICLE SIZE
		// size of individual particles in pixels
		self.startSize = 30.0f;
		self.startSizeVar = 60.0f;
		self.endSize = 0;   //kCCParticleStartSizeEqualToEndSize;
		self.endSizeVar = 0;
        
		// ANGLE (DIRECTION)
		// the direction in which particles are emitted, 0 means upwards
		self.angle = 0;
		self.angleVar = 360;
		
		// PARTICLE LIFETIME
		// how long each individual particle will "life" (eg. stay on screen)
		self.life = 0.1f;
		self.lifeVar = 0.2f;
		
		// PARTICLE EMISSION RATE
		// how many particles per second are created (emitted)
		// particle creation stops if self.particleCount >= self.totalParticles
		// you can use this to create short burst effects with pauses between each burst
		self.emissionRate = 200;//30;
		// normally set with initWithTotalParticles but you can change that number
		self.totalParticles = 200;
        
		// PARTICLE COLOR
		// A valid startColor must be set! Otherwise the particles may be invisible. The other colors are optional.
		// These colors determine the color of the particle at the start and the end of its lifetime.
        CCColor* startColor = [CCColor colorWithRed:1.0f green:0.46f blue:0.0f alpha:0.5f];
		self.startColor = startColor;
        
		CCColor* startColorVar = [CCColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
		self.startColorVar = startColorVar;
        
        CCColor* endColor = [CCColor colorWithRed:1.0f green:0.46f blue:0.0f alpha:0.0f];
		self.endColor = endColor;
        
		CCColor* endColorVar =  [CCColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
		self.endColorVar = endColorVar;
		
		// BLEND FUNC
		// blend func influences how transparent colors are calculated
		// the first parameter is for the source, the second for the target
		// available blend func parameters are:
		// GL_ZERO   GL_ONE   GL_SRC_COLOR   GL_ONE_MINUS_SRC_COLOR   GL_SRC_ALPHA
		// GL_ONE_MINUS_SRC_ALPHA   GL_DST_ALPHA   GL_ONE_MINUS_DST_ALPHA
		self.blendFunc = (ccBlendFunc){GL_DST_ALPHA, GL_ONE_MINUS_SRC_ALPHA};
		// shortcut to set the blend func to: GL_SRC_ALPHA, GL_ONE
		//self.blendAdditive = YES;
		
		// PARTICLE TEXTURE
		self.texture = [CCTexture textureWithFile:@"fire.png"]; //[[CCTextureCache sharedTextureCache] addImage: @"fire.png"];
	}
	
	return self;
}


@end