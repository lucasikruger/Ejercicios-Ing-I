!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'initializations' stamp: 'ejfsdf 5/15/2022 19:52:02'!
initiateMarsRoverHeadingEast

	^ self initiateMarsRoverHeadingNorth process: 'r'! !

!MarsRoverTest methodsFor: 'initializations' stamp: 'ejfsdf 5/15/2022 19:46:12'!
initiateMarsRoverHeadingNorth

	^ MarsRover new! !

!MarsRoverTest methodsFor: 'initializations' stamp: 'ejfsdf 5/15/2022 19:52:02'!
initiateMarsRoverHeadingSouth

	^ (self initiateMarsRoverHeadingEast) process: 'r'! !

!MarsRoverTest methodsFor: 'initializations' stamp: 'ejfsdf 5/15/2022 19:55:38'!
initiateMarsRoverHeadingWest

	^ self initiateMarsRoverHeadingNorth process: 'l'! !


!MarsRoverTest methodsFor: 'mars rover signals' stamp: 'ejfsdf 5/15/2022 19:54:13'!
sendMoveBackwardsSignalTo: marsRover

	^ marsRover process: 'b'! !

!MarsRoverTest methodsFor: 'mars rover signals' stamp: 'ejfsdf 5/15/2022 19:53:03'!
sendMoveForwardSignalTo: marsRover

	^ marsRover process: 'f'! !

!MarsRoverTest methodsFor: 'mars rover signals' stamp: 'ejfsdf 5/15/2022 19:56:50'!
sendTurnLeftSignalTo: marsRover

	^ marsRover process: 'l'! !

!MarsRoverTest methodsFor: 'mars rover signals' stamp: 'ejfsdf 5/15/2022 19:57:26'!
sendTurnRightSignalTo: marsRover

	^ marsRover process: 'r'! !


!MarsRoverTest methodsFor: 'test - general' stamp: 'ejfsdf 5/15/2022 19:46:12'!
test01MarsRoverDoesNothingOnEmptyString
	|marsRover|
	marsRover := self initiateMarsRoverHeadingNorth.
	self assert: ((marsRover process: '') isAt: (0@0) heading: #North)! !

!MarsRoverTest methodsFor: 'test - general' stamp: 'ejfsdf 5/15/2022 19:46:12'!
test18MarsRoverRecievesMultipleCharacteredStrings
	|marsRover|
	marsRover := self initiateMarsRoverHeadingNorth.
	self assert: ((marsRover process: 'lf') isAt: (-1@0) heading: #West).
	self assert: ((marsRover process: 'rb') isAt: (-1@-1) heading: #North).
	self assert: ((marsRover process: 'frfrfrlb') isAt: (0@0) heading: #South).
	! !

!MarsRoverTest methodsFor: 'test - general' stamp: 'ejfsdf 5/15/2022 19:46:12'!
test19MarsRoverStopsProcessingAfterAnErroneousCommand
	|marsRover|
	marsRover := self initiateMarsRoverHeadingNorth.
	self assert: ((marsRover process: 'ffqfr') isAt: (0@2) heading: #North).
	! !


!MarsRoverTest methodsFor: 'test - single char - east' stamp: 'ejfsdf 5/15/2022 19:53:08'!
test06MarsRoverMovesToOneZeroFromZeroZeroWhilstHeadingEastWhileReceivingF
	|marsRover|
	marsRover := self initiateMarsRoverHeadingEast.
	self assert: ((self sendMoveForwardSignalTo: marsRover) isAt: (1@0) heading: #East)! !

!MarsRoverTest methodsFor: 'test - single char - east' stamp: 'ejfsdf 5/15/2022 19:54:13'!
test07MarsRoverMovesToMinusOneZeroFromZeroZeroWhilstHeadingEastWhenReceivingB
	|marsRover|
	marsRover := self initiateMarsRoverHeadingEast.
	self assert: ((self sendMoveBackwardsSignalTo: marsRover) isAt: (-1@0) heading: #East)! !

!MarsRoverTest methodsFor: 'test - single char - east' stamp: 'ejfsdf 5/15/2022 19:57:26'!
test08MarsRoverStaysAtZeroZeroAndRotatesSouthWhilstHeadingEastWhenReceivingR
	|marsRover|
	marsRover := self initiateMarsRoverHeadingEast.
	self assert: ((self sendTurnRightSignalTo: marsRover) isAt: (0@0) heading: #South)! !

!MarsRoverTest methodsFor: 'test - single char - east' stamp: 'ejfsdf 5/15/2022 19:56:50'!
test09MarsRoverStaysAtZeroZeroAndRotatesNorthWhilstHeadingEastWhenReceivingL
	|marsRover|
	marsRover := self initiateMarsRoverHeadingEast.
	self assert: ((self sendTurnLeftSignalTo: marsRover) isAt: (0@0) heading: #North)! !


!MarsRoverTest methodsFor: 'test - single char - north' stamp: 'ejfsdf 5/15/2022 19:53:03'!
test02MarsRoverMovesToZeroOneFromZeroZeroWhilstHeadingNorthWhileReceivingF
	|marsRover|
	marsRover := self initiateMarsRoverHeadingNorth.
	self assert: ((self sendMoveForwardSignalTo: marsRover) isAt: (0@1) heading: #North)! !

!MarsRoverTest methodsFor: 'test - single char - north' stamp: 'ejfsdf 5/15/2022 19:54:13'!
test03MarsRoverMovesToZeroMinusOneFromZeroZeroWhilstHeadingNorthWhenReceivingB
	|marsRover|
	marsRover := self initiateMarsRoverHeadingNorth.
	self assert: ((self sendMoveBackwardsSignalTo: marsRover) isAt: (0@-1) heading: #North)! !

!MarsRoverTest methodsFor: 'test - single char - north' stamp: 'ejfsdf 5/15/2022 19:57:26'!
test04MarsRoverStaysAtZeroZeroAndRotatesEastWhilstHeadingNorthWhenReceivingR
	|marsRover|
	marsRover := self initiateMarsRoverHeadingNorth.
	self assert: ((self sendTurnRightSignalTo: marsRover) isAt: (0@0) heading: #East)! !

!MarsRoverTest methodsFor: 'test - single char - north' stamp: 'ejfsdf 5/15/2022 19:56:50'!
test05MarsRoverStaysAtZeroZeroAndRotatesWestWhilstHeadingNorthWhenReceivingL
	|marsRover|
	marsRover := self initiateMarsRoverHeadingNorth.
	self assert: ((self sendTurnLeftSignalTo: marsRover) isAt: (0@0) heading: #West)! !


!MarsRoverTest methodsFor: 'test - single char - south' stamp: 'ejfsdf 5/15/2022 19:53:03'!
test10MarsRoverMovesToZeroMinusOneFromZeroZeroWhilstHeadingSouthWhileReceivingF
	|marsRover|
	marsRover := self initiateMarsRoverHeadingSouth.
	self assert: ((self sendMoveForwardSignalTo: marsRover) isAt: (0@-1) heading: #South)! !

!MarsRoverTest methodsFor: 'test - single char - south' stamp: 'ejfsdf 5/15/2022 19:54:13'!
test11MarsRoverMovesToZeroOneFromZeroZeroWhilstHeadingSouthWhenReceivingB
	|marsRover|
	marsRover := self initiateMarsRoverHeadingSouth.
	self assert: ((self sendMoveBackwardsSignalTo: marsRover) isAt: (0@1) heading: #South)! !

!MarsRoverTest methodsFor: 'test - single char - south' stamp: 'ejfsdf 5/15/2022 19:57:26'!
test12MarsRoverStaysAtZeroZeroAndRotatesWestWhilstHeadingSouthWhenReceivingR
	|marsRover|
	marsRover := self initiateMarsRoverHeadingSouth.
	self assert: ((self sendTurnRightSignalTo: marsRover) isAt: (0@0) heading: #West)! !

!MarsRoverTest methodsFor: 'test - single char - south' stamp: 'ejfsdf 5/15/2022 19:56:50'!
test13MarsRoverStaysAtZeroZeroAndRotatesEastWhilstHeadingSouthWhenReceivingL
	|marsRover|
	marsRover := self initiateMarsRoverHeadingSouth.
	self assert: ((self sendTurnLeftSignalTo: marsRover) isAt: (0@0) heading: #East)! !


!MarsRoverTest methodsFor: 'test - single char - west' stamp: 'ejfsdf 5/15/2022 19:55:38'!
test14MarsRoverMovesToMinusOneZeroFromZeroZeroWhilstHeadingWestWhileReceivingF
	|marsRover|
	marsRover := self initiateMarsRoverHeadingWest.
	self assert: ((self sendMoveForwardSignalTo: marsRover) isAt: (-1@0) heading: #West)! !

!MarsRoverTest methodsFor: 'test - single char - west' stamp: 'ejfsdf 5/15/2022 19:55:38'!
test15MarsRoverMovesToOneZeroFromZeroZeroWhilstHeadingWestWhenReceivingB
	|marsRover|
	marsRover := self initiateMarsRoverHeadingWest.
	self assert: ((self sendMoveBackwardsSignalTo: marsRover) isAt: (1@0) heading: #West)! !

!MarsRoverTest methodsFor: 'test - single char - west' stamp: 'ejfsdf 5/15/2022 19:57:26'!
test16MarsRoverStaysAtZeroZeroAndRotatesNorthWhilstHeadingWestWhenReceivingR
	|marsRover|
	marsRover := self initiateMarsRoverHeadingWest.
	self assert: ((self sendTurnRightSignalTo: marsRover) isAt: (0@0) heading: #North)! !

!MarsRoverTest methodsFor: 'test - single char - west' stamp: 'ejfsdf 5/15/2022 19:56:50'!
test17MarsRoverStaysAtZeroZeroAndRotatesSouthWhilstHeadingWestWhenReceivingL
	|marsRover|
	marsRover := self initiateMarsRoverHeadingWest.
	self assert: ((self sendTurnLeftSignalTo: marsRover) isAt: (0@0) heading: #South)! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position orientation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'ejfsdf 5/15/2022 19:30:56'!
initialize
	position := 0@0.
	orientation := North new.! !


!MarsRover methodsFor: 'movement' stamp: 'ejfsdf 5/15/2022 19:12:41'!
moveBackwards

	orientation giveMovementBackwardsTo: self.! !

!MarsRover methodsFor: 'movement' stamp: 'ejfsdf 5/15/2022 19:01:49'!
moveEast

	^ position := position + (1@0)! !

!MarsRover methodsFor: 'movement' stamp: 'ejfsdf 5/15/2022 19:12:09'!
moveForward

	orientation giveMovementForwardTo: self.! !

!MarsRover methodsFor: 'movement' stamp: 'ejfsdf 5/15/2022 18:52:52'!
moveNorth

	^ position := position + (0@1)! !

!MarsRover methodsFor: 'movement' stamp: 'ejfsdf 5/15/2022 18:52:16'!
moveSouth

	^ position := position - (0@1)! !

!MarsRover methodsFor: 'movement' stamp: 'ejfsdf 5/15/2022 18:53:22'!
moveWest

	^ position := position - (1@0)! !


!MarsRover methodsFor: 'process' stamp: 'ejfsdf 5/15/2022 18:39:34'!
process: aString
	aString do:[ :aChar | 	
		aChar = $f ifTrue: [self moveForward.] ifFalse: [
		aChar = $b ifTrue: [self moveBackwards.]  ifFalse: [
		aChar = $r ifTrue: [self turnRight.]  ifFalse: [
		aChar = $l ifTrue: [self turnLeft.] ifFalse: [
		^self.]]]]].! !


!MarsRover methodsFor: 'rotation' stamp: 'ejfsdf 5/15/2022 19:32:58'!
turnLeft

	orientation := orientation turnLeft.! !

!MarsRover methodsFor: 'rotation' stamp: 'ejfsdf 5/15/2022 19:32:54'!
turnRight

	orientation := orientation turnRight.! !


!MarsRover methodsFor: 'testing' stamp: 'ejfsdf 5/15/2022 19:04:56'!
isAt: queriedPosition heading: queriedOrientation
	
	^ queriedPosition = position and: (orientation isEqual: queriedOrientation)! !


!classDefinition: #MarsRoverOrientation category: 'MarsRover'!
Object subclass: #MarsRoverOrientation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverOrientation methodsFor: 'rotation' stamp: 'ejfsdf 5/15/2022 19:35:08'!
turnLeft

	self subclassResponsibility.! !

!MarsRoverOrientation methodsFor: 'rotation' stamp: 'ejfsdf 5/15/2022 19:31:51'!
turnRight

	self subclassResponsibility.! !


!MarsRoverOrientation methodsFor: 'testing' stamp: 'ejfsdf 5/15/2022 19:25:56'!
isEqual: queriedOrientation

	self subclassResponsibility.! !



!MarsRoverOrientation methodsFor: 'movement queries' stamp: 'ejfsdf 5/15/2022 19:36:46'!
giveMovementBackwardsTo: aMarsRover

	self subclassResponsibility.! !

!MarsRoverOrientation methodsFor: 'movement queries' stamp: 'ejfsdf 5/15/2022 19:37:07'!
giveMovementForwardTo: aMarsRover

	self subclassResponsibility.! !


!classDefinition: #East category: 'MarsRover'!
MarsRoverOrientation subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'movement queries' stamp: 'ejfsdf 5/15/2022 19:39:09'!
giveMovementBackwardsTo: aMarsRover
	
	aMarsRover moveWest! !

!East methodsFor: 'movement queries' stamp: 'ejfsdf 5/15/2022 19:39:19'!
giveMovementForwardTo: aMarsRover
	
	aMarsRover moveEast! !


!East methodsFor: 'testing' stamp: 'ejfsdf 5/15/2022 19:29:22'!
isEqual: orientation

	^orientation = #East! !


!East methodsFor: 'rotation' stamp: 'ejfsdf 5/15/2022 19:35:25'!
turnLeft

	^ North new! !

!East methodsFor: 'rotation' stamp: 'ejfsdf 5/15/2022 19:32:33'!
turnRight

	^ South new! !


!classDefinition: #North category: 'MarsRover'!
MarsRoverOrientation subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'movement queries' stamp: 'ejfsdf 5/15/2022 19:39:29'!
giveMovementBackwardsTo: aMarsRover
	
	aMarsRover moveSouth! !

!North methodsFor: 'movement queries' stamp: 'ejfsdf 5/15/2022 19:39:37'!
giveMovementForwardTo: aMarsRover
	
	aMarsRover moveNorth! !


!North methodsFor: 'testing' stamp: 'ejfsdf 5/15/2022 19:30:04'!
isEqual: orientation

	^orientation = #North! !


!North methodsFor: 'rotation' stamp: 'ejfsdf 5/15/2022 19:35:36'!
turnLeft

	^ West new! !

!North methodsFor: 'rotation' stamp: 'ejfsdf 5/15/2022 19:33:15'!
turnRight

	^ East new! !


!classDefinition: #South category: 'MarsRover'!
MarsRoverOrientation subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'movement queries' stamp: 'ejfsdf 5/15/2022 19:39:46'!
giveMovementBackwardsTo: aMarsRover
	
	aMarsRover moveNorth! !

!South methodsFor: 'movement queries' stamp: 'ejfsdf 5/15/2022 19:39:54'!
giveMovementForwardTo: aMarsRover
	
	aMarsRover moveSouth! !


!South methodsFor: 'testing' stamp: 'ejfsdf 5/15/2022 19:30:14'!
isEqual: orientation

	^orientation = #South! !


!South methodsFor: 'rotation' stamp: 'ejfsdf 5/15/2022 19:35:48'!
turnLeft

	^ East new! !

!South methodsFor: 'rotation' stamp: 'ejfsdf 5/15/2022 19:33:30'!
turnRight

	^ West new! !


!classDefinition: #West category: 'MarsRover'!
MarsRoverOrientation subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'movement queries' stamp: 'ejfsdf 5/15/2022 19:38:58'!
giveMovementBackwardsTo: aMarsRover
	
	aMarsRover moveEast! !

!West methodsFor: 'movement queries' stamp: 'ejfsdf 5/15/2022 19:38:43'!
giveMovementForwardTo: aMarsRover
	
	aMarsRover moveWest.! !


!West methodsFor: 'testing' stamp: 'ejfsdf 5/15/2022 19:30:24'!
isEqual: orientation

	^orientation = #West! !


!West methodsFor: 'rotation' stamp: 'ejfsdf 5/15/2022 19:35:56'!
turnLeft

	^ South new! !

!West methodsFor: 'rotation' stamp: 'ejfsdf 5/15/2022 19:34:10'!
turnRight

	^ North new! !
