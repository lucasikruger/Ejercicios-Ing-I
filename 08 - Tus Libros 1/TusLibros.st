!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'assertions' stamp: 'scb 6/5/2022 18:46:25'!
assertIsEmpty: aCart

	^ self assert: aCart isEmpty! !


!CartTest methodsFor: 'constants' stamp: 'scb 6/5/2022 18:44:08'!
book

	^ 'book'! !


!CartTest methodsFor: 'initializations' stamp: 'scb 6/5/2022 18:45:53'!
collectionOfBooks

	^ OrderedCollection with: self book! !

!CartTest methodsFor: 'initializations' stamp: 'scb 6/5/2022 18:57:27'!
initializeCartWithCollectionOfBooks

	^ Cart with: self collectionOfBooks! !

!CartTest methodsFor: 'initializations' stamp: 'scb 6/5/2022 18:57:41'!
initializeCartWithCollectionOfBooksAndBookIncluded

	| aCart |
	
	aCart := self initializeCartWithCollectionOfBooks.
	^aCart add: self book.! !

!CartTest methodsFor: 'initializations' stamp: 'scb 6/5/2022 18:58:03'!
initializeCollectionOfBooks

	^ OrderedCollection with: self book! !


!CartTest methodsFor: 'test' stamp: 'scb 6/5/2022 16:38:29'!
test01NewCartIsEmpty

	self assert: Cart new isEmpty.! !

!CartTest methodsFor: 'test' stamp: 'scb 6/5/2022 18:56:01'!
test02CartCantAddBookOutsideOfCollection

	| aCart |
	
	aCart := Cart with: OrderedCollection new.
	
	self with: aCart should: [ aCart add: self book ] riseErrorWithMessage: aCart invalidBookErrorMessage! !

!CartTest methodsFor: 'test' stamp: 'scb 6/5/2022 18:57:41'!
test03CartWithBookIsNotEmpty

	| aCart |
	
	aCart := self initializeCartWithCollectionOfBooksAndBookIncluded.
	
	self deny: aCart isEmpty! !

!CartTest methodsFor: 'test' stamp: 'scb 6/5/2022 18:57:27'!
test04CartCantAddNonStrictlyPositiveAmountOfBooks

	| aCart |
	
	aCart := self initializeCartWithCollectionOfBooks.
	
	self with: aCart should: [ aCart add: -1 of: self book ] riseErrorWithMessage: aCart invalidAmountErrorMessage! !

!CartTest methodsFor: 'test' stamp: 'scb 6/5/2022 18:56:01'!
test05CartCantAddMultipleCopiesOfBookOutsideOfCollection

	| aCart |
	
	aCart := Cart with: OrderedCollection new.
	
	self with: aCart should: [ aCart add: 2 of: self book ] riseErrorWithMessage: aCart invalidBookErrorMessage! !

!CartTest methodsFor: 'test' stamp: 'scb 6/5/2022 18:44:08'!
test06CartDoesntKnowNotAddedBooks

	
	self deny: (Cart new includes: self book)
	
	! !

!CartTest methodsFor: 'test' stamp: 'scb 6/5/2022 18:57:41'!
test07CartKnowsAddedBooks

	| aCart |
	
	aCart := self initializeCartWithCollectionOfBooksAndBookIncluded.
	
	self assert: (aCart includes: self book)
	
	! !

!CartTest methodsFor: 'test' stamp: 'scb 6/5/2022 18:57:41'!
test08CartKnowsOccurrancesOfBooks

	| aCart |
	
	aCart := self initializeCartWithCollectionOfBooksAndBookIncluded.
	
	self assert: 1 equals: (aCart occurrencesOf: self book)
	
	! !


!CartTest methodsFor: 'test - error' stamp: 'scb 6/5/2022 18:56:01'!
with: aCart should: aClosureToFail riseErrorWithMessage: errorMessage

	self should: aClosureToFail
	raise: Error
       	withExceptionDo: [ :anError |
            self assert: anError messageText = errorMessage.
            self assertIsEmpty: aCart ]! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'collection contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'accessing' stamp: 'scb 6/5/2022 18:30:28'!
includes: aBook

	^ contents includes: aBook! !

!Cart methodsFor: 'accessing' stamp: 'scb 6/5/2022 18:42:32'!
occurrencesOf: aBook

	^contents occurrencesOf: aBook! !


!Cart methodsFor: 'adding' stamp: 'scb 6/5/2022 18:21:37'!
add: aBook
	
	self add: 1 of: aBook
	! !

!Cart methodsFor: 'adding' stamp: 'scb 6/5/2022 19:03:16'!
add: anAmount of: aBook
	
	self assertStrictlyPositiveAmount: anAmount.
	self assertValidBook: aBook.
	
	anAmount timesRepeat: [contents add: aBook.]
	! !


!Cart methodsFor: 'asserting' stamp: 'scb 6/5/2022 19:02:10'!
assertStrictlyPositiveAmount: anAmount
	
	^ ( anAmount strictlyPositive ) ifFalse: [ self riseInvalidAmountError ]
	! !

!Cart methodsFor: 'asserting' stamp: 'scb 6/5/2022 19:02:55'!
assertValidBook: aBook
	
	^ ( collection includes: aBook ) ifFalse: [ self riseInvalidBookError ]
	! !


!Cart methodsFor: 'configuration' stamp: 'scb 6/5/2022 17:49:42'!
with: aCollection

	collection := aCollection! !


!Cart methodsFor: 'error messages' stamp: 'scb 6/5/2022 18:05:49'!
invalidAmountErrorMessage

	^ 'Amount is invalid'! !

!Cart methodsFor: 'error messages' stamp: 'scb 6/5/2022 17:30:56'!
invalidBookErrorMessage

	^ 'Book is invalid.'! !


!Cart methodsFor: 'initialization' stamp: 'scb 6/5/2022 17:50:15'!
initialize

	collection := OrderedCollection new.
	contents := OrderedCollection new.! !


!Cart methodsFor: 'testing' stamp: 'scb 6/5/2022 17:51:13'!
isEmpty
	
	^ contents isEmpty! !


!Cart methodsFor: 'rise error' stamp: 'scb 6/5/2022 19:00:43'!
riseInvalidAmountError

	^ self error: self invalidAmountErrorMessage! !

!Cart methodsFor: 'rise error' stamp: 'scb 6/5/2022 19:01:19'!
riseInvalidBookError

	^ self error: self invalidBookErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'scb 6/5/2022 17:49:53'!
with: aCollection 

	^ self new with: aCollection.
	! !
