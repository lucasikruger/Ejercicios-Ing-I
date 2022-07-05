!classDefinition: #GameTest category: 'ISW1-2022-1C-2doParcial'!
TestCase subclass: #GameTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-2doParcial'!

!GameTest methodsFor: 'tests' stamp: 'lk 7/4/2022 20:43:16'!
test01CantCreateGameIfThereIsNotAnStartFloor
	| floorOne floorTwo playerOne playerTwo |
	floorOne := Floor withExtension: 5@5 withShortcut: {}.
	floorTwo := EndFloor withFloor: (Floor withExtension: 3@3 withShortcut: {}) andEndPosition: self endPosition .
	playerOne := Player new.
	playerTwo := Player new.
	
	
	self should: [Game withFloors: {floorOne. floorTwo} andPlayers: {playerOne. playerTwo}]
	raise: Error - MessageNotUnderstood 
	withMessageText: Game noStartFloorErrorDescription. 
! !

!GameTest methodsFor: 'tests' stamp: 'lk 7/4/2022 20:43:16'!
test02CantCreateGameIfThereIsNotAnEndFloor
	| floorOne floorTwo playerOne playerTwo |
	floorOne := StartFloor  withFloor: (Floor withExtension: 3@3 withShortcut: {}) andStartPosition: self startPosition .
	floorTwo := Floor withExtension: 5@5 withShortcut: {}. 
	playerOne := Player new.
	playerTwo := Player new.
	
	
	self should: [Game withFloors: {floorOne. floorTwo} andPlayers: {playerOne. playerTwo}]
	raise: Error - MessageNotUnderstood 
	withMessageText: Game noEndFloorErrorDescription. 
! !

!GameTest methodsFor: 'tests' stamp: 'lk 7/4/2022 20:43:16'!
test03CanCreateGame
	| floorOne floorTwo playerOne playerTwo game |
	floorOne := StartFloor  withFloor:(Floor withExtension: 3@3 withShortcut: {}) andStartPosition: self startPosition .
	floorTwo := EndFloor withFloor: (Floor withExtension: 3@3 withShortcut: {}) andEndPosition: self endPosition .
	playerOne := Player new.
	playerTwo := Player new.
	
	
	game := Game withFloors: {floorOne. floorTwo} andPlayers: {playerOne. playerTwo}.
	
	self assert: floorOne equals: game startFloor.
	self assert: self startPosition equals: game startPosition.
	
	self assert: floorTwo equals: game endFloor.
	self assert: self endPosition equals: game endPosition.
	! !


!GameTest methodsFor: 'vars' stamp: 'lk 7/4/2022 19:26:17'!
endPosition
	^2@2! !

!GameTest methodsFor: 'vars' stamp: 'lk 7/4/2022 19:01:34'!
startPosition
	^ 1@1! !


!classDefinition: #ShortcutsTests category: 'ISW1-2022-1C-2doParcial'!
TestCase subclass: #ShortcutsTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-2doParcial'!

!ShortcutsTests methodsFor: 'tests' stamp: 'lk 7/4/2022 21:03:08'!
test01CantCreateAStairFromToSameFloor
	self should: [Stair fromPoint: 1@1 toPoint: 1@1 fromFloor: 1 to: 1]  raise: Error- MessageNotUnderstood withMessageText: Stair invalidFromToFloorErrorDescription ! !

!ShortcutsTests methodsFor: 'tests' stamp: 'lk 7/4/2022 21:03:48'!
test02CantCreateAStairFromAFloorToAnotherBelow
	self should: [Stair fromPoint: 1@1 toPoint: 1@1 fromFloor: 2 to: 1]  raise: Error- MessageNotUnderstood withMessageText: Stair invalidFromToFloorErrorDescription ! !

!ShortcutsTests methodsFor: 'tests' stamp: 'lk 7/4/2022 21:12:54'!
test03CantCreateASlideFromToSameFloor
	self should: [Slide fromPoint: 1@1 toPoint: 1@1 fromFloor: 1 to: 1]  raise: Error- MessageNotUnderstood withMessageText: Slide invalidFromToFloorErrorDescription ! !

!ShortcutsTests methodsFor: 'tests' stamp: 'lk 7/4/2022 21:13:13'!
test04CantCreateASlideFromAFloorToAnotherBelow
	self should: [Slide fromPoint: 1@1 toPoint: 1@1 fromFloor: 1 to: 2]  raise: Error- MessageNotUnderstood withMessageText: Slide invalidFromToFloorErrorDescription ! !


!classDefinition: #Floors category: 'ISW1-2022-1C-2doParcial'!
Object subclass: #Floors
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-2doParcial'!


!classDefinition: #Floor category: 'ISW1-2022-1C-2doParcial'!
Floors subclass: #Floor
	instanceVariableNames: 'extension collectionOfShortCuts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-2doParcial'!

!Floor methodsFor: 'initialization' stamp: 'lk 7/4/2022 20:44:49'!
initializeWithExtension: aPoint withShortCuts: aCollectionOfShortcuts  
	collectionOfShortCuts := aCollectionOfShortcuts .
	extension := aPoint.! !


!Floor methodsFor: 'test' stamp: 'lk 7/4/2022 20:10:34'!
isEndFloor
^ false! !

!Floor methodsFor: 'test' stamp: 'lk 7/4/2022 20:04:15'!
isStartFloor
^ false.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Floor class' category: 'ISW1-2022-1C-2doParcial'!
Floor class
	instanceVariableNames: ''!

!Floor class methodsFor: 'instance creation' stamp: 'lk 7/4/2022 20:44:33'!
withExtension: aPoint withShortcut: aCollectionOfShortcuts  

	^self new initializeWithExtension: aPoint withShortCuts: aCollectionOfShortcuts ! !


!classDefinition: #SpecialFloor category: 'ISW1-2022-1C-2doParcial'!
Floors subclass: #SpecialFloor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-2doParcial'!


!classDefinition: #EndFloor category: 'ISW1-2022-1C-2doParcial'!
SpecialFloor subclass: #EndFloor
	instanceVariableNames: 'floor endPosition'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-2doParcial'!

!EndFloor methodsFor: 'initializaion' stamp: 'lk 7/4/2022 20:34:03'!
initializeWithFloor: aFloor andEndPosition: anEndPoint 
	floor := aFloor.
	endPosition := anEndPoint.! !


!EndFloor methodsFor: 'test' stamp: 'lk 7/4/2022 20:28:17'!
endPosition
^endPosition ! !

!EndFloor methodsFor: 'test' stamp: 'lk 7/4/2022 20:10:41'!
isEndFloor
^ true! !

!EndFloor methodsFor: 'test' stamp: 'lk 7/4/2022 20:04:04'!
isStartFloor
^ false.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EndFloor class' category: 'ISW1-2022-1C-2doParcial'!
EndFloor class
	instanceVariableNames: ''!

!EndFloor class methodsFor: 'instance creation' stamp: 'lk 7/4/2022 21:25:34'!
withFloor: aFloor andEndPosition: anEndPoint 
	
	^self new initializeWithFloor: aFloor andEndPosition: anEndPoint ! !


!classDefinition: #StartFloor category: 'ISW1-2022-1C-2doParcial'!
SpecialFloor subclass: #StartFloor
	instanceVariableNames: 'floor startPosition'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-2doParcial'!

!StartFloor methodsFor: 'test' stamp: 'lk 7/4/2022 20:10:22'!
isEndFloor
^ false! !

!StartFloor methodsFor: 'test' stamp: 'lk 7/4/2022 20:10:14'!
isStartFloor
^ true! !

!StartFloor methodsFor: 'test' stamp: 'lk 7/4/2022 20:27:57'!
startPosition
^startPosition ! !


!StartFloor methodsFor: 'initialization' stamp: 'lk 7/4/2022 20:34:57'!
initializeWithFloor: aFloor andStartPosition: anStartPoint 
	floor := aFloor.
	startPosition := anStartPoint.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StartFloor class' category: 'ISW1-2022-1C-2doParcial'!
StartFloor class
	instanceVariableNames: ''!

!StartFloor class methodsFor: 'instance creation' stamp: 'lk 7/4/2022 20:34:47'!
withFloor: anExtensionPoint andStartPosition: anStartPoint 
	^self new initializeWithFloor: anExtensionPoint andStartPosition: anStartPoint ! !


!classDefinition: #Game category: 'ISW1-2022-1C-2doParcial'!
Object subclass: #Game
	instanceVariableNames: 'collectionOfFloors collectionOfPlayers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-2doParcial'!

!Game methodsFor: 'initialization' stamp: 'lk 7/4/2022 19:42:31'!
initializeWithFloors: aCollectionOfFloors andPlayers: aCollectionOfPlayers 
	collectionOfFloors := aCollectionOfFloors.
	collectionOfPlayers := aCollectionOfPlayers.! !


!Game methodsFor: 'test' stamp: 'lk 7/4/2022 20:26:43'!
endFloor
	^ collectionOfFloors detect:[:floor| floor isEndFloor.].! !

!Game methodsFor: 'test' stamp: 'lk 7/4/2022 20:28:36'!
endPosition
	^ self endFloor endPosition.! !

!Game methodsFor: 'test' stamp: 'lk 7/4/2022 20:26:35'!
startFloor
	^ collectionOfFloors detect:[:floor| floor isStartFloor.].! !

!Game methodsFor: 'test' stamp: 'lk 7/4/2022 20:27:22'!
startPosition
	^ self startFloor startPosition.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Game class' category: 'ISW1-2022-1C-2doParcial'!
Game class
	instanceVariableNames: ''!

!Game class methodsFor: 'error' stamp: 'lk 7/4/2022 21:21:20'!
invalidShortcutErrorDescription
	^ 'invalid shortcut'! !

!Game class methodsFor: 'error' stamp: 'lk 7/4/2022 20:12:40'!
noEndFloorErrorDescription
	^ 'there is no end floor'! !

!Game class methodsFor: 'error' stamp: 'lk 7/4/2022 20:07:02'!
noStartFloorErrorDescription
	^ 'there is no start floor'! !


!Game class methodsFor: 'instance creation' stamp: 'lk 7/4/2022 21:26:12'!
withFloors: aCollectionOfFloors andPlayers: aCollectionOfPlayers
	
	(aCollectionOfFloors anySatisfy: [:floor| floor isStartFloor]) ifFalse: [(self error: self noStartFloorErrorDescription)].
	(aCollectionOfFloors anySatisfy: [:floor| floor isEndFloor]) ifFalse: [(self error: self noEndFloorErrorDescription)].
	
	^self new initializeWithFloors: aCollectionOfFloors andPlayers: aCollectionOfPlayers ! !


!classDefinition: #Player category: 'ISW1-2022-1C-2doParcial'!
Object subclass: #Player
	instanceVariableNames: 'position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-2doParcial'!


!classDefinition: #Shortcuts category: 'ISW1-2022-1C-2doParcial'!
Object subclass: #Shortcuts
	instanceVariableNames: 'startPoint endPoint fromFloor toFloor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-2doParcial'!

!Shortcuts methodsFor: 'as yet unclassified' stamp: 'lk 7/4/2022 21:13:50'!
initializeFromPoint: aStartPoint toPoint: anEndPoint fromFloor: aFromFloor to: aToFloor 

	startPoint := aStartPoint.
	endPoint := anEndPoint.
	fromFloor := aFromFloor.
	toFloor:= aToFloor.! !


!classDefinition: #Slide category: 'ISW1-2022-1C-2doParcial'!
Shortcuts subclass: #Slide
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-2doParcial'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Slide class' category: 'ISW1-2022-1C-2doParcial'!
Slide class
	instanceVariableNames: ''!

!Slide class methodsFor: 'instance creation' stamp: 'lk 7/4/2022 21:11:54'!
fromPoint: anStartPoint toPoint: anEndPoint fromFloor: aFromFloor to: aToFloor 
	(aFromFloor = aToFloor or: [aFromFloor < aToFloor]) ifTrue: [self error: self invalidFromToFloorErrorDescription ].
	^self new initializeFromPoint: anStartPoint toPoint: anEndPoint fromFloor: aFromFloor to: aToFloor ! !


!Slide class methodsFor: 'as yet unclassified' stamp: 'lk 7/4/2022 21:10:57'!
invalidFromToFloorErrorDescription
	^'invalid from to Floor'! !


!classDefinition: #Stair category: 'ISW1-2022-1C-2doParcial'!
Shortcuts subclass: #Stair
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-2doParcial'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Stair class' category: 'ISW1-2022-1C-2doParcial'!
Stair class
	instanceVariableNames: ''!

!Stair class methodsFor: 'instance creation' stamp: 'lk 7/4/2022 21:07:56'!
fromPoint: anStartPoint toPoint: anEndPoint fromFloor: aFromFloor to: aToFloor 
	(aFromFloor = aToFloor or: [aFromFloor > aToFloor]) ifTrue: [self error: self invalidFromToFloorErrorDescription ].
	^self new initializeFromPoint: anStartPoint toPoint: anEndPoint fromFloor: aFromFloor to: aToFloor ! !


!Stair class methodsFor: 'error' stamp: 'lk 7/4/2022 20:55:35'!
invalidFromToFloorErrorDescription
	^'invalid from to Floor'! !
