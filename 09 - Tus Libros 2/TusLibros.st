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


!CartTest methodsFor: 'initializations' stamp: 'lk 6/6/2022 19:46:46'!
bookPrice

	^ 10! !

!CartTest methodsFor: 'initializations' stamp: 'scb 6/7/2022 18:49:06'!
initializeCartWithCollectionOfBooks

	^ Cart checkout: self initializeCatalogOfBooks! !

!CartTest methodsFor: 'initializations' stamp: 'lk 6/6/2022 19:52:50'!
initializeCartWithCollectionOfBooksAndBookIncluded

	| aCart |
	
	aCart := self initializeCartWithCollectionOfBooks.
	^aCart add: 2 of: self book.! !

!CartTest methodsFor: 'initializations' stamp: 'scb 6/7/2022 18:49:06'!
initializeCatalogOfBooks

	^ Dictionary checkout: self book -> self bookPrice! !


!CartTest methodsFor: 'test' stamp: 'scb 6/5/2022 16:38:29'!
test01NewCartIsEmpty

	self assert: Cart new isEmpty.! !

!CartTest methodsFor: 'test' stamp: 'lk 6/6/2022 19:01:36'!
test02CartCantAddBookOutsideOfCollection

	| aCart |
	
	aCart := Cart new.
	
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

!CartTest methodsFor: 'test' stamp: 'lk 6/6/2022 18:59:55'!
test04_5CartCantAddNonIntegerAmountOfBooks

	| aCart |
	
	aCart := self initializeCartWithCollectionOfBooks.
	
	self with: aCart should: [ aCart add: 1.5 of: self book ] riseErrorWithMessage: aCart invalidAmountErrorMessage! !

!CartTest methodsFor: 'test' stamp: 'lk 6/6/2022 19:50:51'!
test05CartCantAddMultipleCopiesOfBookOutsideOfCollection

	| aCart |
	
	aCart := Cart new.
	
	self with: aCart should: [ aCart add: 2 of: self book ] riseErrorWithMessage: aCart invalidBookErrorMessage! !

!CartTest methodsFor: 'test' stamp: 'scb 6/5/2022 18:44:08'!
test06CartDoesntKnowNotAddedBooks

	
	self deny: (Cart new includes: self book)
	
	! !

!CartTest methodsFor: 'test' stamp: 'lk 6/6/2022 19:06:11'!
test07CartKnowsAddedBooks

	| aCart |
	
	aCart := self initializeCartWithCollectionOfBooksAndBookIncluded.
	
	self assert: aCart includes: self book
	
	! !

!CartTest methodsFor: 'test' stamp: 'lk 6/6/2022 19:52:38'!
test08CartKnowsOccurrancesOfBooks

	| aCart |
	
	aCart := self initializeCartWithCollectionOfBooksAndBookIncluded.
	
	self assert: 2 equals: (aCart occurrencesOf: self book)
	
	! !


!CartTest methodsFor: 'test - error' stamp: 'lk 6/6/2022 19:02:52'!
with: aCart should: aClosureToFail riseErrorWithMessage: errorMessage

	self should: aClosureToFail
	raise: Error
	withMessageText: errorMessage.
	
	self assertIsEmpty: aCart
	! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'aCredit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'as yet unclassified' stamp: 'scb 6/7/2022 18:49:06'!
test01CantCheckoutEmptyCart

	self should: [Cashier checkout: Cart new]
	raise: Error
	withMessageText: Cashier emptyCartErrorMessage. ! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'scb 6/7/2022 20:49:54'!
test02CashierCanCalculateCheckoutPriceOfCartWithOneBook
	
	| aCart aCashier aCreditCard aLedger|
	
	aCart := Cart checkout: (Dictionary with: 'book' -> 10).
	aCart add: 1 of: 'book'.
	aCreditCard := CreditCard withExpirationDate: (Month month: Date today monthIndex year: Date today yearNumber + 1).
	aLedger := OrderedCollection new.
	aCashier := Cashier checkout: aCart with: aCreditCard on: (Month month: Date today monthIndex year: Date today yearNumber) registerOn: aLedger.
	
	self assert: 10 equals: aCashier checkout.
! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'scb 6/7/2022 20:49:07'!
test03CashierCanCalculateCheckoutPriceOfCartWithMultipleBooks
	
	| aCart aCashier aCreditCard aLedger|
	
	aCart := Cart checkout: (Dictionary with: 'book' -> 10).
	aCart add: 5 of: 'book'.
	aCreditCard := CreditCard withExpirationDate: (Month month: Date today monthIndex year: Date today yearNumber + 1).
	aLedger := OrderedCollection new.
	aCashier := Cashier checkout: aCart with: aCreditCard on: (Month month: Date today monthIndex year: Date today yearNumber) registerOn: aLedger.
	
	self assert: 50 equals: aCashier checkout.
! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'scb 6/7/2022 20:51:53'!
test04CantCheckoutWithExpiredCard
	
	| aCart aCreditCard aLedger |
	
	aCart := Cart checkout: (Dictionary with: 'book' -> 10).
	aCart add: 1 of: 'book'.
	aCreditCard := CreditCard withExpirationDate: (Month month: Date today monthIndex year: Date today yearNumber - 1).
	aLedger := OrderedCollection new.
	
	self should: [Cashier checkout: aCart with: aCreditCard on: (Month month: Date today monthIndex year: Date today yearNumber) registerOn: aLedger.]
	raise: Error
	withMessageText: Cashier expiredCreditCardErrorMessage.
	self assert: aLedger isEmpty
	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'scb 6/7/2022 20:52:03'!
test05CashierCheckoutsCart
	
	| aCart aCashier aCreditCard aPrice aLedger|
	
	aCart := Cart checkout: (Dictionary with: 'book' -> 10).
	aCart add: 1 of: 'book'.
	aCreditCard := CreditCard withExpirationDate: (Month month: Date today monthIndex year: Date today yearNumber + 1).
	aLedger := OrderedCollection new.
	aCashier := Cashier checkout: aCart with: aCreditCard on: (Month month: Date today monthIndex year: Date today yearNumber) registerOn: aLedger.
	
	aPrice := aCashier checkout.
	
	self assert: 1 equals: aLedger size.
	self assert: aPrice equals: aLedger first.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'accessing' stamp: 'lk 6/6/2022 19:54:29'!
catalog
	
	^ catalog! !

!Cart methodsFor: 'accessing' stamp: 'lk 6/6/2022 19:51:42'!
occurrencesOf: aBook

	^ contents occurrencesOf: aBook! !


!Cart methodsFor: 'adding' stamp: 'scb 6/5/2022 18:21:37'!
add: aBook
	
	self add: 1 of: aBook
	! !

!Cart methodsFor: 'adding' stamp: 'lk 6/6/2022 19:39:16'!
add: anAmount of: aBook
	
	self assertStrictlyPositiveAmount: anAmount.
	self assertValidBook: aBook.
	
	anAmount timesRepeat: [contents add: aBook.]
	! !


!Cart methodsFor: 'asserting' stamp: 'lk 6/6/2022 19:00:45'!
assertIsStrictlyPositiveInteger: anAmount

	^ anAmount strictlyPositive and: anAmount isInteger! !

!Cart methodsFor: 'asserting' stamp: 'lk 6/6/2022 19:00:45'!
assertStrictlyPositiveAmount: anAmount
	
	^ ( self assertIsStrictlyPositiveInteger: anAmount) ifFalse: [ self riseInvalidAmountError ]
	! !

!Cart methodsFor: 'asserting' stamp: 'lk 6/6/2022 19:47:58'!
assertValidBook: aBook
	
	^ ( catalog keys includes: aBook ) ifFalse: [ self riseInvalidBookError ]
	! !


!Cart methodsFor: 'configuration' stamp: 'scb 6/7/2022 18:49:06'!
checkout: aCollection

	catalog := aCollection! !


!Cart methodsFor: 'error messages' stamp: 'scb 6/5/2022 18:05:49'!
invalidAmountErrorMessage

	^ 'Amount is invalid'! !

!Cart methodsFor: 'error messages' stamp: 'scb 6/5/2022 17:30:56'!
invalidBookErrorMessage

	^ 'Book is invalid.'! !


!Cart methodsFor: 'initialization' stamp: 'lk 6/6/2022 19:50:35'!
initialize

	catalog := Dictionary new.
	contents := OrderedCollection new.! !


!Cart methodsFor: 'testing' stamp: 'lk 6/6/2022 19:39:08'!
includes: aBook

	^ contents includes: aBook! !

!Cart methodsFor: 'testing' stamp: 'scb 6/5/2022 17:51:13'!
isEmpty
	
	^ contents isEmpty! !


!Cart methodsFor: 'rise error' stamp: 'scb 6/5/2022 19:00:43'!
riseInvalidAmountError

	^ self error: self invalidAmountErrorMessage! !

!Cart methodsFor: 'rise error' stamp: 'scb 6/5/2022 19:01:19'!
riseInvalidBookError

	^ self error: self invalidBookErrorMessage! !


!Cart methodsFor: 'enumerating' stamp: 'lk 6/6/2022 20:00:21'!
do: aClosure

	contents do: aClosure! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'scb 6/7/2022 18:49:06'!
checkout: aCollection 

	^ self new checkout: aCollection.
	! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart creditCard ledger'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'scb 6/7/2022 20:47:35'!
checkout
	
	| catalog price |
	
	catalog := cart catalog.
	price := 0.
	
	cart do: [ :product | price := price + catalog at: product ].
	
	ledger add: price.
	
	^ price.! !


!Cashier methodsFor: 'initialization' stamp: 'scb 6/7/2022 18:55:27'!
initializeCheckoutOf: aCart 

	cart := aCart.! !

!Cashier methodsFor: 'initialization' stamp: 'scb 6/7/2022 20:34:48'!
initializeCheckoutOf: aCart with: aCreditCard registerOn: aLedger.
	
	cart := aCart.
	creditCard := aCreditCard.
	ledger := aLedger.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'scb 6/7/2022 18:55:27'!
checkout: aCart

	(aCart isEmpty) ifTrue: [self error: self emptyCartErrorMessage ].
	^ self new initializeCheckoutOf: aCart.! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'scb 6/7/2022 20:31:23'!
checkout: aCart with: aCreditCard on: aDate registerOn: aLedger 
	
	(aCart isEmpty) ifTrue: [self error: self emptyCartErrorMessage ].
	(aCreditCard isExpiredOn: aDate) ifTrue: [self error: self expiredCreditCardErrorMessage ].
	
	^ self new initializeCheckoutOf: aCart with: aCreditCard registerOn: aLedger.! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'lk 6/6/2022 19:29:32'!
emptyCartErrorMessage
	
	^ 'cart is empty'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'scb 6/7/2022 18:54:06'!
expiredCreditCardErrorMessage
	
	^ 'credit card is expired'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'scb 6/7/2022 19:28:04'!
initializeWithExpirationDate: aDate

	expirationDate := aDate! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'scb 6/7/2022 19:59:46'!
isExpiredOn: aDate

	^ expirationDate yearNumber < aDate yearNumber or: ( expirationDate yearNumber = aDate yearNumber and: expirationDate monthIndex < aDate monthIndex )! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'scb 6/7/2022 19:53:30'!
withExpirationDate: aDate

	^self new initializeWithExpirationDate: aDate! !
