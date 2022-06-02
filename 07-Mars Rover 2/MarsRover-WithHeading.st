!classDefinition: #MarsRoverObserverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverObserverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverObserverTest methodsFor: 'initialization' stamp: 'scb 6/1/2022 22:05:02'!
initializeLoggerAndFollowPositionOf: marsRover

	^ MarsRoverLogger new followPositionOf: marsRover.! !


!MarsRoverObserverTest methodsFor: 'test' stamp: 'scb 6/1/2022 21:55:06'!
test01BothObserversCanTrackSameMarsRover

	| marsRover logger logStream window |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := self initializeLoggerAndFollowPositionOf: marsRover.
	window := MarsRoverStatusWindow follow: marsRover.
	
	marsRover process: 'f'.
	
	logStream := logger readStream.
	self assert: '1@2' equals: logStream nextLine.
	self assert: logStream atEnd.
	
	self assert: 1@2 equals: window positionField.
	self assert: nil equals: window headingField.! !


!classDefinition: #MarsRoverLoggerTest category: 'MarsRover-WithHeading'!
MarsRoverObserverTest subclass: #MarsRoverLoggerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLoggerTest methodsFor: 'initialization' stamp: 'scb 6/1/2022 21:12:09'!
initializeLoggerAndFollowHeadingOf: marsRover

	^ MarsRoverLogger new followHeadingOf: marsRover! !


!MarsRoverLoggerTest methodsFor: 'test' stamp: 'scb 6/1/2022 21:53:49'!
test01LoggerAtEndWhenMarsRoverProcessNothing

	| marsRover logger |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := self initializeLoggerAndFollowPositionOf: marsRover.
	
	marsRover process: ''.
	
	self assert: logger readStream atEnd.! !


!MarsRoverLoggerTest methodsFor: 'test - heading' stamp: 'scb 6/1/2022 21:11:37'!
test05LogRotationWhenMarsRoverTurnsEast

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := self initializeLoggerAndFollowHeadingOf: marsRover.
	
	marsRover process: 'r'.
	
	logStream := logger readStream.
	self assert: 'East' equals: logStream nextLine.
	self assert: logStream atEnd.! !

!MarsRoverLoggerTest methodsFor: 'test - heading' stamp: 'scb 6/1/2022 21:11:37'!
test06LogRotationWhenMarsRoverTurnsWest

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := self initializeLoggerAndFollowHeadingOf: marsRover.
	
	marsRover process: 'l'.
	
	logStream := logger readStream.
	self assert: 'West' equals: logStream nextLine.
	self assert: logStream atEnd.! !

!MarsRoverLoggerTest methodsFor: 'test - heading' stamp: 'scb 6/1/2022 21:11:37'!
test07LogRotationWhenMarsRoverTurnsNorth

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingWest.
	logger := self initializeLoggerAndFollowHeadingOf: marsRover.
	
	marsRover process: 'r'.
	
	logStream := logger readStream.
	self assert: 'North' equals: logStream nextLine.
	self assert: logStream atEnd.! !

!MarsRoverLoggerTest methodsFor: 'test - heading' stamp: 'scb 6/1/2022 21:11:37'!
test08LogRotationWhenMarsRoverTurnsSouth

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast.
	logger := self initializeLoggerAndFollowHeadingOf: marsRover.
	
	marsRover process: 'r'.
	
	logStream := logger readStream.
	self assert: 'South' equals: logStream nextLine.
	self assert: logStream atEnd.! !


!MarsRoverLoggerTest methodsFor: 'test - position' stamp: 'scb 6/1/2022 21:09:11'!
test02LogPositionWhenMarsRoverMovesNorth

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := self initializeLoggerAndFollowPositionOf: marsRover.
	
	marsRover process: 'f'.
	
	logStream := logger readStream.
	self assert: '1@2' equals: logStream nextLine.
	self assert: logStream atEnd.! !

!MarsRoverLoggerTest methodsFor: 'test - position' stamp: 'scb 6/1/2022 21:09:11'!
test03LogPositionWhenMarsRoverMovesSouth

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := self initializeLoggerAndFollowPositionOf: marsRover.
	
	marsRover process: 'b'.
	
	logStream := logger readStream.
	self assert: '1@0' equals: logStream nextLine.
	self assert: logStream atEnd.! !

!MarsRoverLoggerTest methodsFor: 'test - position' stamp: 'scb 6/1/2022 21:09:11'!
test04LogPositionWhenMarsRoverMovesWestAndEast

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast.
	logger := self initializeLoggerAndFollowPositionOf: marsRover.
	
	marsRover process: 'fb'.
	
	logStream := logger readStream.
	self assert: '2@1' equals: logStream nextLine.
	self assert: '1@1' equals: logStream nextLine.
	self assert: logStream atEnd.
! !


!classDefinition: #MarsRoverStatusWindowTest category: 'MarsRover-WithHeading'!
MarsRoverObserverTest subclass: #MarsRoverStatusWindowTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverStatusWindowTest methodsFor: 'test' stamp: 'scb 6/1/2022 20:29:42'!
test01WindowsPositionFieldUpdatesWhenMarsRoverProcessesNorthMovement

	| marsRover window |

	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	window := MarsRoverStatusWindow follow: marsRover.
	
	marsRover process: 'f'.

	self assert: 1@2 equals: window positionField.
	self assert: nil equals: window headingField.! !

!MarsRoverStatusWindowTest methodsFor: 'test' stamp: 'scb 6/1/2022 20:31:10'!
test02WindowsPositionFieldUpdatesWhenMarsRoverProcessesSouthMovement

	| marsRover window |

	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	window := MarsRoverStatusWindow follow: marsRover.
	
	marsRover process: 'b'.

	self assert: 1@0 equals: window positionField.
	self assert: nil equals: window headingField.! !

!MarsRoverStatusWindowTest methodsFor: 'test' stamp: 'scb 6/1/2022 20:33:15'!
test03WindowsPositionFieldUpdatesWhenMarsRoverProcessesEastMovement

	| marsRover window |

	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast.
	window := MarsRoverStatusWindow follow: marsRover.
	
	marsRover process: 'f'.

	self assert: 2@1 equals: window positionField.
	self assert: nil equals: window headingField.! !

!MarsRoverStatusWindowTest methodsFor: 'test' stamp: 'scb 6/1/2022 20:35:19'!
test04WindowsPositionFieldUpdatesWhenMarsRoverProcessesWestMovement

	| marsRover window |

	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast.
	window := MarsRoverStatusWindow follow: marsRover.
	
	marsRover process: 'b'.

	self assert: 0@1 equals: window positionField.
	self assert: nil equals: window headingField.! !

!MarsRoverStatusWindowTest methodsFor: 'test' stamp: 'scb 6/1/2022 20:49:45'!
test05WindowsHeadingFieldUpdatesWhenMarsRoverProcessesNorthRotation

	| marsRover window |

	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingWest.
	window := MarsRoverStatusWindow follow: marsRover.
	
	marsRover process: 'r'.

	self assert: nil equals: window positionField.
	self assert: 'Heading North' equals: window headingField.! !

!MarsRoverStatusWindowTest methodsFor: 'test' stamp: 'scb 6/1/2022 20:51:06'!
test06WindowsHeadingFieldUpdatesWhenMarsRoverProcessesSouthRotation

	| marsRover window |

	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingWest.
	window := MarsRoverStatusWindow follow: marsRover.
	
	marsRover process: 'l'.

	self assert: nil equals: window positionField.
	self assert: 'Heading South' equals: window headingField.! !

!MarsRoverStatusWindowTest methodsFor: 'test' stamp: 'scb 6/1/2022 20:50:30'!
test07WindowsHeadingFieldUpdatesWhenMarsRoverProcessesEastRotation

	| marsRover window |

	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	window := MarsRoverStatusWindow follow: marsRover.
	
	marsRover process: 'r'.

	self assert: nil equals: window positionField.
	self assert: 'Heading East' equals: window headingField.! !

!MarsRoverStatusWindowTest methodsFor: 'test' stamp: 'scb 6/1/2022 20:52:04'!
test08WindowsHeadingFieldUpdatesWhenMarsRoverProcessesWestRotation

	| marsRover window |

	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	window := MarsRoverStatusWindow follow: marsRover.
	
	marsRover process: 'l'.

	self assert: nil equals: window positionField.
	self assert: 'Heading West' equals: window headingField.! !


!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'heading' stamp: 'scb 6/1/2022 22:46:51'!
changeHeadingAndUpdateObserverTo: aDirection

	head updateWith: (aDirection for: self).
	head sendUpdateMessage: [ : observer | observer headingChangeTo: head value ].! !

!MarsRover methodsFor: 'heading' stamp: 'scb 6/1/2022 21:48:34'!
headEast

	self changeHeadingAndUpdateObserverTo: MarsRoverHeadingEast.! !

!MarsRover methodsFor: 'heading' stamp: 'scb 6/1/2022 21:48:43'!
headNorth
	
	self changeHeadingAndUpdateObserverTo: MarsRoverHeadingNorth! !

!MarsRover methodsFor: 'heading' stamp: 'scb 6/1/2022 21:48:52'!
headSouth
	
	self changeHeadingAndUpdateObserverTo: MarsRoverHeadingSouth! !

!MarsRover methodsFor: 'heading' stamp: 'scb 6/1/2022 21:49:02'!
headWest
	
	self changeHeadingAndUpdateObserverTo: MarsRoverHeadingWest! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	head rotateLeft! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	head rotateRight! !


!MarsRover methodsFor: 'initialization' stamp: 'scb 6/1/2022 23:00:07'!
initializeAt: aPosition heading: aHeadingType

	position := Publisher with: aPosition.
	head := Publisher with: (aHeadingType for: self).! !


!MarsRover methodsFor: 'moving' stamp: 'scb 6/1/2022 22:46:57'!
addToPositionAndUpdateObserversWith: anAdder
	
	position updateWith: (position + anAdder).
	position sendUpdateMessage: [ : observer | observer positionChangeTo: position value].! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	head moveBackward! !

!MarsRover methodsFor: 'moving' stamp: 'scb 6/1/2022 21:45:52'!
moveEast
	
	self addToPositionAndUpdateObserversWith: (1@0).! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	head moveForward! !

!MarsRover methodsFor: 'moving' stamp: 'scb 6/1/2022 21:46:01'!
moveNorth
	
	self addToPositionAndUpdateObserversWith: (0@1).! !

!MarsRover methodsFor: 'moving' stamp: 'scb 6/1/2022 21:46:10'!
moveSouth
	
	self addToPositionAndUpdateObserversWith: (0@-1).! !

!MarsRover methodsFor: 'moving' stamp: 'scb 6/1/2022 21:46:32'!
moveWest
	
	self addToPositionAndUpdateObserversWith: (-1@0).! !


!MarsRover methodsFor: 'observers' stamp: 'scb 6/1/2022 23:04:50'!
addHeadObserver: anObserver

	head add: anObserver! !

!MarsRover methodsFor: 'observers' stamp: 'scb 6/1/2022 23:05:03'!
addPositionObserver: anObserver

	position add: anObserver ! !


!MarsRover methodsFor: 'testing' stamp: 'scb 6/1/2022 22:49:08'!
isAt: aPosition heading: aHeadingType

	^ (position value) = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'converting' stamp: 'scb 6/1/2022 20:57:27'!
asString

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'visiting' stamp: 'scb 6/1/2022 20:58:29'!
accept: aVisitor

	^aVisitor visitMarsRoverHeading: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'converting' stamp: 'scb 6/1/2022 20:44:05'!
asString

	^ 'East'! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'converting' stamp: 'scb 6/1/2022 20:44:30'!
asString

	^ 'North'! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'converting' stamp: 'scb 6/1/2022 20:44:42'!
asString

	^ 'South'! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'converting' stamp: 'scb 6/1/2022 20:44:54'!
asString

	^ 'West'! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!classDefinition: #MarsRoverObserver category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverObserver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverObserver methodsFor: 'visiting' stamp: 'scb 6/1/2022 21:30:41'!
headingChangeTo: aHead

	aHead accept: self.! !

!MarsRoverObserver methodsFor: 'visiting' stamp: 'scb 6/1/2022 21:35:52'!
positionChangeTo: aPosition

	self subclassResponsibility.! !

!MarsRoverObserver methodsFor: 'visiting' stamp: 'scb 6/1/2022 21:32:11'!
visitMarsRoverHeading: aHeading

	self subclassResponsibility.! !


!classDefinition: #MarsRoverLogger category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #MarsRoverLogger
	instanceVariableNames: 'stream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogger methodsFor: 'accessing' stamp: 'lk 6/1/2022 19:02:05'!
readStream

	^ ReadStream on: stream contents.! !


!MarsRoverLogger methodsFor: 'follow' stamp: 'scb 6/1/2022 23:04:39'!
followHeadingOf: aMarsRover

	aMarsRover addHeadObserver: self.! !

!MarsRoverLogger methodsFor: 'follow' stamp: 'scb 6/1/2022 23:04:22'!
followPositionOf: aMarsRover 

	aMarsRover addPositionObserver: self.! !


!MarsRoverLogger methodsFor: 'initialization' stamp: 'scb 6/1/2022 20:27:42'!
initialize

	stream := WriteStream on: ''.! !


!MarsRoverLogger methodsFor: 'visiting' stamp: 'scb 6/1/2022 21:03:49'!
positionChangeTo: aPosition

	stream print: aPosition; newLine.! !

!MarsRoverLogger methodsFor: 'visiting' stamp: 'scb 6/1/2022 20:43:15'!
visitMarsRoverHeading: aHeading

	stream nextPutAll: aHeading asString; newLine.! !


!classDefinition: #MarsRoverStatusWindow category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #MarsRoverStatusWindow
	instanceVariableNames: 'positionField headingField'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverStatusWindow methodsFor: 'accessing' stamp: 'scb 6/1/2022 20:25:28'!
headingField

	^headingField ! !

!MarsRoverStatusWindow methodsFor: 'accessing' stamp: 'scb 6/1/2022 20:25:23'!
positionField

	^positionField ! !


!MarsRoverStatusWindow methodsFor: 'follow' stamp: 'scb 6/1/2022 23:05:34'!
follow: aMarsRover

	aMarsRover addHeadObserver: self.
	aMarsRover addPositionObserver: self.! !


!MarsRoverStatusWindow methodsFor: 'visiting' stamp: 'scb 6/1/2022 21:03:27'!
positionChangeTo: aPosition

	positionField := aPosition ! !

!MarsRoverStatusWindow methodsFor: 'visiting' stamp: 'scb 6/1/2022 20:48:21'!
visitMarsRoverHeading: aHeading

	headingField := 'Heading ', aHeading asString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverStatusWindow class' category: 'MarsRover-WithHeading'!
MarsRoverStatusWindow class
	instanceVariableNames: ''!

!MarsRoverStatusWindow class methodsFor: 'as yet unclassified' stamp: 'scb 6/1/2022 20:25:57'!
follow: aMarsRover

	^self new follow: aMarsRover 
	! !


!classDefinition: #Publisher category: 'MarsRover-WithHeading'!
Object subclass: #Publisher
	instanceVariableNames: 'value observers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Publisher methodsFor: 'error handling' stamp: 'scb 6/1/2022 22:33:14'!
doesNotUnderstand: aMessage

	^ aMessage sendTo: value
	! !


!Publisher methodsFor: 'initialization' stamp: 'scb 6/1/2022 22:25:44'!
initializeWith: aValue

	value := aValue.
	observers := OrderedCollection new.
	! !


!Publisher methodsFor: 'observers' stamp: 'scb 6/1/2022 23:02:44'!
add: anObserver

	observers add: anObserver
	! !

!Publisher methodsFor: 'observers' stamp: 'scb 6/1/2022 22:47:49'!
sendUpdateMessage: aClosure
	
	observers do: aClosure
	! !


!Publisher methodsFor: 'value' stamp: 'scb 6/1/2022 22:47:24'!
updateWith: aValue
	
	value := aValue.
	! !

!Publisher methodsFor: 'value' stamp: 'scb 6/1/2022 22:26:22'!
value

	^ value
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Publisher class' category: 'MarsRover-WithHeading'!
Publisher class
	instanceVariableNames: ''!

!Publisher class methodsFor: 'instance creation' stamp: 'scb 6/1/2022 22:24:00'!
with: aValue

	^ self new initializeWith: aValue! !
