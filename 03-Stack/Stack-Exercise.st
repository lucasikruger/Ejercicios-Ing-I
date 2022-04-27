!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test-auxiliaries' stamp: 'lk 4/26/2022 20:19:46'!
emptyStackCantDo: closure
self
		should: closure
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]! !

!OOStackTest methodsFor: 'test-auxiliaries' stamp: 'lk 4/26/2022 20:30:47'!
pushSomethingAndPopIn: stack 

	self pushSomethingIn: stack.
	stack pop.! !

!OOStackTest methodsFor: 'test-auxiliaries' stamp: 'lk 4/26/2022 20:22:40'!
pushSomethingIn: stack
	
	stack push: 'something'.
	! !

!OOStackTest methodsFor: 'test-auxiliaries' stamp: 'lk 4/26/2022 20:35:08'!
pushSomethingIn: stack andAssert: closure

	self pushSomethingIn: stack.
	self assert: closure value = 'something'.! !


!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'lk 4/26/2022 20:33:45'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	self pushSomethingIn: stack.
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'lk 4/26/2022 20:33:38'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	self pushSomethingAndPopIn: stack.
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'lk 4/26/2022 20:33:13'!
test04PopReturnsLastPushedObject

	| stack |
	
	stack := OOStack new.
	self pushSomethingIn: stack andAssert: [stack pop].! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'lk 4/26/2022 20:34:25'!
test06TopReturnsLastPushedObject

	| stack |
	
	stack := OOStack new.
	self pushSomethingIn: stack andAssert: [stack top].! !

!OOStackTest methodsFor: 'test' stamp: 'lk 4/26/2022 20:24:31'!
test07TopDoesNotRemoveObjectFromStack

	| stack |
	
	stack := OOStack new.
	self pushSomethingIn: stack.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'lk 4/26/2022 20:20:57'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self emptyStackCantDo: [ stack pop ]! !

!OOStackTest methodsFor: 'test' stamp: 'lk 4/26/2022 20:32:12'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	self pushSomethingAndPopIn: stack .
	
	self emptyStackCantDo: [ stack pop ]
! !

!OOStackTest methodsFor: 'test' stamp: 'lk 4/26/2022 20:20:17'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self emptyStackCantDo: [ stack top ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'finder'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'lk 4/27/2022 19:44:45'!
test01shouldReturnEmptyCollectionOnEmptyStack

	|stack finders|
	finders:= SentenceFinderByPrefix new.
	stack:= OOStack new.
	
	self assert: ((finders findInStack: stack thePrefix: 'something' )= OrderedCollection new).
	 ! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'lk 4/27/2022 19:56:01'!
test02shouldReturnEmptyCollectionWhenNotFoundInStackWithOneElement

	|stack finders|
	finders:= SentenceFinderByPrefix new.
	stack:= OOStack new.
	stack push: 'notSomething'.
	
	self assert: ((finders findInStack: stack thePrefix: 'something' )= OrderedCollection new).
	 ! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'lk 4/27/2022 19:51:54'!
test03shouldReturnEmptyCollectionWhenNotFoundInStackWithMoreThanOneElement

	|stack finders|
	finders:= SentenceFinderByPrefix new.
	stack:= OOStack new.
	stack push: 'notSomething'.
	stack push: 'notSomethingElse'.	
	self assert: ((finders findInStack: stack thePrefix: 'something' )= OrderedCollection new).
	 ! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'lk 4/27/2022 19:58:50'!
test04shouldReturnCollectionWhenFoundInStackWithOneElement

	|stack finders collection|
	finders:= SentenceFinderByPrefix new.
	stack:= OOStack new.
	collection:= OrderedCollection new.
	stack push: 'something'.
	collection  add: 'something'.
	
	self assert: (finders findInStack: stack thePrefix: 'something') = collection .! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'lk 4/27/2022 19:58:14'!
test05shouldReturnCollectionWhenFoundInStackWithMoreThanOneElement

	|stack finders collection|
	finders:= SentenceFinderByPrefix new.
	stack:= OOStack new.
	collection:= OrderedCollection new.
	stack push: 'notSomething'.
	stack push: 'something'.
	collection  add: 'something'.
	
	self assert: (finders findInStack: stack thePrefix: 'something') = collection .! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'lk 4/27/2022 20:16:43'!
test06shouldReturnCollectionWhenFoundMoreThanOnePrefix

	|stack finders collection|
	finders:= SentenceFinderByPrefix new.
	stack:= OOStack new.
	collection:= OrderedCollection new.
	stack push: 'somethingElse'.
	stack push: 'notsomething'.
	stack push: 'something'.
	collection  add: 'something'.
	collection  add: 'somethingElse'.
	
	self assert: (finders findInStack: stack thePrefix: 'something') = collection .! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'lk 4/27/2022 20:02:47'!
test07shouldReturnEmptyCollectionOnCaseSensitiveDifference

	|stack finders|
	finders:= SentenceFinderByPrefix new.
	stack:= OOStack new.
	stack push: 'Something'.
	stack push: 'someThing'.
	
	self assert: ((finders findInStack: stack thePrefix: 'something' )= OrderedCollection new).
	 ! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'lk 4/27/2022 20:04:09'!
test08shouldReturnEmptyCollectionOnSpaceDifference

	|stack finders|
	finders:= SentenceFinderByPrefix new.
	stack:= OOStack new.
	stack push: 'some thing'.
	
	self assert: ((finders findInStack: stack thePrefix: 'something' )= OrderedCollection new).
	 ! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'lk 4/27/2022 20:12:15'!
test09shouldReturnEmptyCollectionOnEmptyPrefix

	|stack finders|
	finders:= SentenceFinderByPrefix new.
	stack:= OOStack new.
	stack push: 'some thing'.
	
	self assert: ((finders findInStack: stack thePrefix: '' )= OrderedCollection new).
	 ! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'stackState size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'operations' stamp: 'lk 4/26/2022 20:13:05'!
initialize

	stackState:= OOStackStateEmpty new.
	size:=0! !

!OOStack methodsFor: 'operations' stamp: 'lk 4/26/2022 20:13:01'!
isEmpty

	^ stackState isEmpty.! !

!OOStack methodsFor: 'operations' stamp: 'lk 4/26/2022 20:12:57'!
modifyStackState: newStackState

	stackState:= newStackState
	! !

!OOStack methodsFor: 'operations' stamp: 'lk 4/26/2022 19:59:07'!
pop
	
	|value|
	value := self top.
	stackState := stackState returnPrevious.
	size:= size -1.
	^value! !

!OOStack methodsFor: 'operations' stamp: 'lk 4/26/2022 20:12:11'!
push: aValue
	
	stackState := stackState push: aValue.
	size:= size +1.! !

!OOStack methodsFor: 'operations' stamp: 'lk 4/26/2022 20:12:19'!
size 
	^ size! !

!OOStack methodsFor: 'operations' stamp: 'lk 4/27/2022 16:31:42'!
stackState
	^ stackState ! !

!OOStack methodsFor: 'operations' stamp: 'lk 4/26/2022 19:56:46'!
top
	^ stackState value.! !

!OOStack methodsFor: 'operations' stamp: 'lk 4/27/2022 18:03:03'!
unstackToCollection
	| aCollection |
	aCollection := OrderedCollection new.
	stackState addAllValuesTo: aCollection.
	^ aCollection.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackState category: 'Stack-Exercise'!
Object subclass: #OOStackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackState methodsFor: 'functions' stamp: 'lk 4/27/2022 17:40:30'!
addAllValuesTo: aCollection
	self subclassResponsibility.! !

!OOStackState methodsFor: 'functions' stamp: 'lk 4/26/2022 19:33:26'!
isEmpty

	self subclassResponsibility.! !

!OOStackState methodsFor: 'functions' stamp: 'lk 4/26/2022 19:32:08'!
push: aValue
	^ OOStackStateNotEmpty withAValue: aValue andPreviousState: self.! !

!OOStackState methodsFor: 'functions' stamp: 'lk 4/26/2022 19:49:43'!
removeTop

	self subclassResponsibility.! !

!OOStackState methodsFor: 'functions' stamp: 'lk 4/26/2022 19:51:10'!
returnPrevious

	self subclassResponsibility.! !


!classDefinition: #OOStackStateEmpty category: 'Stack-Exercise'!
OOStackState subclass: #OOStackStateEmpty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackStateEmpty methodsFor: 'as yet unclassified' stamp: 'lk 4/27/2022 20:09:22'!
addAllValuesTo: aCollection
	! !

!OOStackStateEmpty methodsFor: 'as yet unclassified' stamp: 'lk 4/26/2022 18:43:27'!
isEmpty

	^ true! !

!OOStackStateEmpty methodsFor: 'as yet unclassified' stamp: 'lk 4/26/2022 20:13:38'!
returnPrevious

	^ self! !

!OOStackStateEmpty methodsFor: 'as yet unclassified' stamp: 'lk 4/26/2022 20:10:08'!
value

	self error: OOStack stackEmptyErrorDescription! !


!classDefinition: #OOStackStateNotEmpty category: 'Stack-Exercise'!
OOStackState subclass: #OOStackStateNotEmpty
	instanceVariableNames: 'value previousState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackStateNotEmpty methodsFor: 'as yet unclassified' stamp: 'lk 4/27/2022 18:05:24'!
addAllValuesTo: aCollection
	aCollection add: value.
	previousState addAllValuesTo: aCollection.
! !

!OOStackStateNotEmpty methodsFor: 'as yet unclassified' stamp: 'lk 4/26/2022 19:39:29'!
initalizeWithAValue: aValue andPreviousState: aState

	value := aValue.
	previousState := aState.
! !

!OOStackStateNotEmpty methodsFor: 'as yet unclassified' stamp: 'lk 4/26/2022 18:43:55'!
isEmpty

	^ false! !

!OOStackStateNotEmpty methodsFor: 'as yet unclassified' stamp: 'lk 4/26/2022 19:51:29'!
returnPrevious

	^ previousState ! !

!OOStackStateNotEmpty methodsFor: 'as yet unclassified' stamp: 'lk 4/26/2022 20:14:06'!
value

	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackStateNotEmpty class' category: 'Stack-Exercise'!
OOStackStateNotEmpty class
	instanceVariableNames: ''!

!OOStackStateNotEmpty class methodsFor: 'as yet unclassified' stamp: 'lk 4/26/2022 19:18:49'!
withAValue: aValue andPreviousState: aState 
	
	^self new initalizeWithAValue: aValue andPreviousState: aState.! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'functions' stamp: 'lk 4/27/2022 20:11:21'!
findInStack: anStack thePrefix: aPrefix

	| collection aPrefixSize|
	collection:= anStack unstackToCollection.
	aPrefixSize := aPrefix size.
	collection := collection select: [:sentence | aPrefix size > 0  and:  aPrefixSize <= sentence size].
	collection := collection select: [:sentence | self thePrefix: aPrefix isIn: sentence].
	^collection.
	
	
	! !

!SentenceFinderByPrefix methodsFor: 'functions' stamp: 'lk 4/27/2022 19:17:41'!
thePrefix: aPrefix isIn: sentence
	
	|sentenceBefore|
	"valueBefore  := value."
	sentenceBefore := sentence copyFrom: 1 to: aPrefix size.
	^ sentenceBefore = aPrefix.! !

!SentenceFinderByPrefix methodsFor: 'functions' stamp: 'lk 4/27/2022 18:31:06'!
theString: anString hasThePrefix: aPrefix
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'lk 4/27/2022 20:05:35'!
emptyPrefixErrorDescription
	
	^ 'prefix is empty!!!!!!'! !
