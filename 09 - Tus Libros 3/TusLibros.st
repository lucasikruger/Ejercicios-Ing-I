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

!CartTest methodsFor: 'initializations' stamp: 'scb 6/12/2022 19:43:44'!
initializeCartWithCollectionOfBooks

	^ Cart with: self initializeCatalogOfBooks! !

!CartTest methodsFor: 'initializations' stamp: 'lk 6/6/2022 19:52:50'!
initializeCartWithCollectionOfBooksAndBookIncluded

	| aCart |
	
	aCart := self initializeCartWithCollectionOfBooks.
	^aCart add: 2 of: self book.! !

!CartTest methodsFor: 'initializations' stamp: 'scb 6/8/2022 22:43:13'!
initializeCatalogOfBooks

	^ Dictionary with: self book -> self bookPrice! !


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

!CartTest methodsFor: 'test' stamp: 'scb 6/12/2022 20:10:57'!
test09CartKnowsContents

	| aCart |
	
	aCart := self initializeCartWithCollectionOfBooksAndBookIncluded.
	
	self assert: (OrderedCollection with: 'book' with: 'book') equals: aCart contents
	
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
	instanceVariableNames: 'debitedAmount debitedCreditCard error factory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'assertions' stamp: 'scb 6/12/2022 23:13:13'!
assert: aLedger includesOneItemOfPrice: aPrice

	self assert: 1 equals: aLedger size.
	self assert: aPrice equals: aLedger first total! !

!CashierTest methodsFor: 'assertions' stamp: 'scb 6/8/2022 23:38:48'!
assert: aClosure raiseErrorWithMessageText: anErrorMessage

	self should: aClosure
	raise: Error
	withMessageText: anErrorMessage! !

!CashierTest methodsFor: 'assertions' stamp: 'scb 6/9/2022 00:07:48'!
assertCheckoutOf: aCart on: aCreditCard registerOn: aLedger raisesErrorWithMessageText: anErrorMessage

	self assert: [self initializeCashierCheckout: aCart on: aCreditCard registerOn: aLedger]
	raiseErrorWithMessageText: anErrorMessage! !

!CashierTest methodsFor: 'assertions' stamp: 'scb 6/9/2022 00:23:21'!
assertCheckoutPriceEqualsBooksValueAfterPurchasing: anAmount
	
	| aCart aCashier aCreditCard aLedger |
	
	aCart := self initializeCartWithCatalogAndAnAmountOfBooks: anAmount.
	aCreditCard := self initializeNotExpiredCreditCard.
	aLedger := self initializeEmptyOrderedCollection.
	aCashier := self initializeCashierCheckout: aCart on: aCreditCard registerOn: aLedger.
	
	self assert: self bookValue * anAmount equals: aCashier checkout.
! !

!CashierTest methodsFor: 'assertions' stamp: 'scb 6/8/2022 23:22:27'!
assertIsEmpty: anOrderedCollection

	^ self assert: anOrderedCollection isEmpty! !


!CashierTest methodsFor: 'chrono' stamp: 'scb 6/8/2022 23:16:39'!
thisMonth

	^ self today monthIndex! !

!CashierTest methodsFor: 'chrono' stamp: 'scb 6/8/2022 23:16:58'!
thisYear

	^ self today yearNumber! !

!CashierTest methodsFor: 'chrono' stamp: 'scb 6/8/2022 23:16:23'!
today

	^ Date today! !


!CashierTest methodsFor: 'closures' stamp: 'scb 6/8/2022 23:21:24'!
riseNotEnoughCreditErrorClosure

	^ [self error: Cashier notEnoughCreditOnCreditCardErrorMessage]! !


!CashierTest methodsFor: 'constants' stamp: 'scb 6/8/2022 23:10:13'!
book

	^ 'book'! !

!CashierTest methodsFor: 'constants' stamp: 'scb 6/8/2022 23:39:32'!
bookValue

	^ 10! !


!CashierTest methodsFor: 'initialization' stamp: 'scb 6/12/2022 19:43:44'!
initializeCartWithCatalogAndAnAmountOfBooks: anAmount

	| aCart |
	
	aCart := Cart with: self initializeCatalog.
	anAmount timesRepeat: [aCart add: 1 of: self book].
	^aCart! !

!CashierTest methodsFor: 'initialization' stamp: 'scb 6/12/2022 23:26:30'!
initializeCashierCheckout: aCart on: aCreditCard registerOn: aLedger 

	^ Cashier checkout: aCart ownedBy: factory validUser with: aCreditCard on: (self initializeMonthYearNow) using: self registerOn: aLedger! !

!CashierTest methodsFor: 'initialization' stamp: 'scb 6/8/2022 23:11:21'!
initializeCatalog

	^ Dictionary with: self bookValueRelation! !

!CashierTest methodsFor: 'initialization' stamp: 'scb 6/8/2022 23:27:06'!
initializeEmptyCart

	^ Cart new! !

!CashierTest methodsFor: 'initialization' stamp: 'scb 6/8/2022 23:40:34'!
initializeEmptyOrderedCollection

	^ OrderedCollection new! !

!CashierTest methodsFor: 'initialization' stamp: 'scb 6/12/2022 22:25:01'!
initializeExpiredCreditCard

	^ CreditCard withExpirationDate: (self initializeMonthYearLastYear)! !

!CashierTest methodsFor: 'initialization' stamp: 'scb 6/8/2022 23:32:23'!
initializeMonthYearLastYear

	^ Month month: self thisMonth year: self thisYear - 1! !

!CashierTest methodsFor: 'initialization' stamp: 'scb 6/8/2022 23:33:11'!
initializeMonthYearNextYear

	^ Month month: self thisMonth year: self thisYear + 1! !

!CashierTest methodsFor: 'initialization' stamp: 'scb 6/8/2022 23:16:58'!
initializeMonthYearNow

	^ Month month: self thisMonth year: self thisYear! !

!CashierTest methodsFor: 'initialization' stamp: 'scb 6/12/2022 22:25:01'!
initializeNotExpiredCreditCard

	^ CreditCard withExpirationDate: (self initializeMonthYearNextYear)! !

!CashierTest methodsFor: 'initialization' stamp: 'scb 6/12/2022 20:51:25'!
setUp

	factory := ObjectFactory new.! !


!CashierTest methodsFor: 'merchant processor simulator' stamp: 'scb 6/8/2022 23:09:37'!
debit: anAmount from: aCreditCard 
	
	error value.
	debitedAmount := anAmount.
	debitedCreditCard := aCreditCard.! !


!CashierTest methodsFor: 'relating' stamp: 'scb 6/8/2022 23:39:42'!
bookValueRelation

	^ self book -> self bookValue! !


!CashierTest methodsFor: 'test' stamp: 'scb 6/9/2022 00:20:05'!
test01CantCheckoutEmptyCart

	| aCart aCreditCard aLedger|
	
	aCart := self initializeCartWithCatalogAndAnAmountOfBooks: 0.
	aCreditCard := self initializeNotExpiredCreditCard.
	aLedger := self initializeEmptyOrderedCollection.
	
	self assertCheckoutOf: aCart on: aCreditCard registerOn: aLedger raisesErrorWithMessageText: Cashier emptyCartErrorMessage.! !

!CashierTest methodsFor: 'test' stamp: 'scb 6/9/2022 00:22:50'!
test02CashierCanCalculateCheckoutPriceOfCartWithOneBook
	
	self assertCheckoutPriceEqualsBooksValueAfterPurchasing: 1
! !

!CashierTest methodsFor: 'test' stamp: 'scb 6/9/2022 00:23:02'!
test03CashierCanCalculateCheckoutPriceOfCartWithMultipleBooks
	
	self assertCheckoutPriceEqualsBooksValueAfterPurchasing: 5
! !

!CashierTest methodsFor: 'test' stamp: 'scb 6/9/2022 00:18:06'!
test04CantCheckoutWithExpiredCard
	
	| aCart aCreditCard aLedger |
	
	aCart := self initializeCartWithCatalogAndAnAmountOfBooks: 1.
	aCreditCard := self initializeExpiredCreditCard.
	aLedger := self initializeEmptyOrderedCollection.
	
	self assertCheckoutOf: aCart on: aCreditCard registerOn: 0 raisesErrorWithMessageText: Cashier expiredCreditCardErrorMessage.
	self assertIsEmpty: aLedger
	! !

!CashierTest methodsFor: 'test' stamp: 'scb 6/9/2022 00:39:50'!
test05CashierCheckoutsCart
	
	| aCart aCashier aCreditCard aPrice aLedger|
	
	aCart := self initializeCartWithCatalogAndAnAmountOfBooks: 1.
	aCreditCard := self initializeNotExpiredCreditCard.
	aLedger := self initializeEmptyOrderedCollection.
	aCashier := self initializeCashierCheckout: aCart on: aCreditCard registerOn: aLedger.
	
	aPrice := aCashier checkout.
	
	self assert: aLedger includesOneItemOfPrice: aPrice.! !

!CashierTest methodsFor: 'test' stamp: 'scb 6/9/2022 00:16:30'!
test06CashierCheckoutsCartUsingMerchantProcessor
	
	| aCart aCashier aCreditCard aLedger |
	
	aCart := self initializeCartWithCatalogAndAnAmountOfBooks: 1.
	aCreditCard := self initializeNotExpiredCreditCard.
	aLedger := self initializeEmptyOrderedCollection.
	aCashier := self initializeCashierCheckout: aCart on: aCreditCard registerOn: aLedger.
	error := self initializeEmptyOrderedCollection.
	
	aCashier checkout.
	
	self assert: self bookValue equals: debitedAmount.
	self assert: aCreditCard equals: debitedCreditCard.! !

!CashierTest methodsFor: 'test' stamp: 'scb 6/9/2022 00:16:43'!
test07CashierCantCheckoutWhenCreditCardDoesNotHaveEnoughCredit
	
	| aCart aCashier aCreditCard aLedger |
	
	aCart := self initializeCartWithCatalogAndAnAmountOfBooks: 1.
	aCreditCard := self initializeNotExpiredCreditCard.
	aLedger := self initializeEmptyOrderedCollection.
	aCashier := self initializeCashierCheckout: aCart on: aCreditCard registerOn: aLedger.
	
	error := self riseNotEnoughCreditErrorClosure.
	
	self assert: [aCashier checkout] raiseErrorWithMessageText: Cashier notEnoughCreditOnCreditCardErrorMessage.
	self assertIsEmpty: aLedger.! !


!classDefinition: #TusLibrosInterfaceTest category: 'TusLibros'!
TestCase subclass: #TusLibrosInterfaceTest
	instanceVariableNames: 'factory clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'scb 6/13/2022 00:32:21'!
setUp

	factory := ObjectFactory new.
	clock := factory createClock.! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'scb 6/13/2022 00:18:23'!
test01CantCreateCartForInvalidUsername

	| interface |
	
	interface := factory createInterfaceWith: clock.
	
	self should: [ interface createCartForUsername: factory invalidUser withPassword: factory validPassword ]
	raise: Error - MessageNotUnderstood 
	withMessageText: interface invalidCredentialsErrorMessage! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'scb 6/13/2022 00:18:23'!
test02CantCreateCartWithInvalidPassword

	| interface |
	
	interface := factory createInterfaceWith: clock.
	
	self should: [ interface createCartForUsername: factory validUser withPassword: factory invalidPassword ]
	raise: Error - MessageNotUnderstood 
	withMessageText: interface invalidCredentialsErrorMessage! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'scb 6/13/2022 00:18:23'!
test03CanCreateCartValidCredentials

	| interface |
	
	interface := factory createInterfaceWith: clock.
	
	self shouldnt: [ interface createCartForUsername: factory validUser withPassword: factory validPassword ]
	raise: Error - MessageNotUnderstood! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'scb 6/13/2022 00:18:23'!
test04CantAddItemToInvalidCartID

	| interface |
	
	interface := factory createInterfaceWith: clock.
	
	self should: [ interface add: 1 of: factory validBook to: factory invalidCartID ]
	raise: Error - MessageNotUnderstood
	withMessageText: interface invalidCartErrorMessage! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'scb 6/13/2022 00:18:23'!
test05CanAddItemToValidCart

	| interface aCartID |
	
	interface := factory createInterfaceWith: clock.
	aCartID := interface createCartForUsername: factory validUser withPassword: factory validPassword.
	
	self shouldnt: [interface add: 1 of: factory validBook to: aCartID]
	raise: Error - MessageNotUnderstood 
	! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'scb 6/13/2022 00:18:23'!
test06CantAddInvalidItemToCart

	| interface aCartID |
	
	interface := factory createInterfaceWith: clock.
	aCartID := interface createCartForUsername: factory validUser withPassword: factory validPassword.
	
	self should: [interface add: 1 of: factory invalidBook to: aCartID]
	raise: Error - MessageNotUnderstood 
	withMessageText: interface invalidBookErrorMessage.
	! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'scb 6/13/2022 00:18:23'!
test07CantListContentsOfInvalidCartID

	| interface |
	
	interface := factory createInterfaceWith: clock.
	
	self should: [interface showContentsOf: factory invalidCartID]
	raise: Error - MessageNotUnderstood 
	withMessageText: interface invalidCartErrorMessage.
	! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'scb 6/13/2022 00:18:23'!
test08CanListEmptyContentsOfValidCartID

	| interface aCartID |
	
	interface := factory createInterfaceWith: clock.
	aCartID := interface createCartForUsername: factory validUser withPassword: factory validPassword.
	
	self assert: (interface showContentsOf: aCartID) isEmpty 
	! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'scb 6/13/2022 00:18:23'!
test09CanListContentsOfValidCartID

	| interface aCartID |
	
	interface := factory createInterfaceWith: clock.
	aCartID := interface createCartForUsername: factory validUser withPassword: factory validPassword.
	interface add: 1 of: factory validBook to: aCartID.
	
	self assert: 1 equals: ((interface showContentsOf: aCartID) occurrencesOf: factory validBook)
	! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'scb 6/13/2022 00:18:23'!
test10CantCheckoutInvalidCartID

	| interface |
	
	interface := factory createInterfaceWith: clock.
	
	self should: [ interface
		checkout: factory invalidCartID 
		withCreditCardNumber: factory validCardNumber 
		ownedBy: factory validCardOwner 
		expiringOn: factory nextYear ]
	raise: Error - MessageNotUnderstood 
	withMessageText: interface invalidCartErrorMessage
	! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'scb 6/13/2022 00:18:23'!
test11CanCheckoutValidCartID

	| interface aCartID |
	
	interface := factory createInterfaceWith: clock.
	aCartID := interface createCartForUsername: factory validUser withPassword: factory validPassword.
	interface add: 1 of: factory validBook to: aCartID.
	
	self shouldnt: [ interface
		checkout: aCartID
		withCreditCardNumber: factory validCardNumber 
		ownedBy: factory validCardOwner 
		expiringOn: factory nextYear ]
	raise: Error - MessageNotUnderstood
	! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'scb 6/13/2022 00:18:23'!
test12CantCheckoutEmptyCart

	| interface aCartID |
	
	interface := factory createInterfaceWith: clock.
	aCartID := interface createCartForUsername: factory validUser withPassword: factory validPassword.
	
	self should: [ interface
		checkout: aCartID
		withCreditCardNumber: factory validCardNumber 
		ownedBy: factory validCardOwner 
		expiringOn: factory nextYear ]
	raise: Error - MessageNotUnderstood
	withMessageText: interface emptyCartErrorMessage
	! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'scb 6/13/2022 00:18:23'!
test13CantCheckoutWithExpiredCreditCard

	| interface aCartID |
	
	interface := factory createInterfaceWith: clock.
	aCartID := interface createCartForUsername: factory validUser withPassword: factory validPassword.
	interface add: 1 of: factory validBook to: aCartID.
	
	self should: [ interface
		checkout: aCartID
		withCreditCardNumber: factory validCardNumber 
		ownedBy: factory validCardOwner 
		expiringOn: factory lastYear ]
	raise: Error - MessageNotUnderstood
	withMessageText: interface expiredCreditCardErrorMessage
	! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'scb 6/13/2022 00:18:23'!
test14CantListPurchasesOfInvalidUsername

	| interface |
	
	interface := factory createInterfaceWith: clock.
		
	self should: [interface
		listPurchasesOfUsername: factory invalidUser
		withPassword: factory validPassword]
	raise: Error - MessageNotUnderstood
	withMessageText: interface invalidCredentialsErrorMessage 
	! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'scb 6/13/2022 00:18:23'!
test15CantListPurchasesWithInvalidPassword

	| interface |
	
	interface := factory createInterfaceWith: clock.
		
	self should: [interface
		listPurchasesOfUsername: factory validUser
		withPassword: factory invalidPassword]
	raise: Error - MessageNotUnderstood
	withMessageText: interface invalidCredentialsErrorMessage 
	! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'scb 6/13/2022 00:18:23'!
test16CanListPurchasesOfUserWithoutPurchases

	| interface aCartID aPurchaseList|
	
	interface := factory createInterfaceWith: clock.
	aCartID := interface createCartForUsername: factory validUser withPassword: factory validPassword.
	interface add: 1 of: factory validBook to: aCartID.
	
	interface
		checkout: aCartID
		withCreditCardNumber: factory validCardNumber 
		ownedBy: factory validCardOwner 
		expiringOn: factory nextYear.
		
	aPurchaseList := interface listPurchasesOfUsername: factory validUser withPassword: factory validPassword.
	
	self assert: factory validBookPrice equals: (aPurchaseList at: 1) total
	! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'scb 6/13/2022 00:56:29'!
test17CantAddToExpiredCart

	| interface aCartID |
	interface := factory createInterfaceWith: clock.
	aCartID := interface createCartForUsername: factory validUser withPassword: factory validPassword.
	clock advance: 31 minutes.
	
	self should: [interface add: 1 of: factory validBook to: aCartID]
	raise: Error - MessageNotUnderstood 
	withMessageText: interface expiredCartErrorMessage.
	! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'scb 6/13/2022 01:10:12'!
test17CantListExpiredCart

	| interface aCartID |
	interface := factory createInterfaceWith: clock.
	aCartID := interface createCartForUsername: factory validUser withPassword: factory validPassword.
	clock advance: interface gracePeriod + 1 minutes.
	
	self should: [interface add: 1 of: factory validBook to: aCartID]
	raise: Error - MessageNotUnderstood 
	withMessageText: interface expiredCartErrorMessage.
	! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'scb 6/13/2022 01:10:28'!
test18CantListContentsOfExpiredCart

	| interface aCartID |
	interface := factory createInterfaceWith: clock.
	aCartID := interface createCartForUsername: factory validUser withPassword: factory validPassword.
	clock advance: interface gracePeriod + 1 minutes.
	
	self should: [interface showContentsOf: aCartID]
	raise: Error - MessageNotUnderstood 
	withMessageText: interface expiredCartErrorMessage.
	! !


!classDefinition: #ActiveCart category: 'TusLibros'!
Object subclass: #ActiveCart
	instanceVariableNames: 'user cart timeOfActivation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ActiveCart methodsFor: 'as yet unclassified' stamp: 'scb 6/12/2022 23:29:21'!
cart

	^cart! !

!ActiveCart methodsFor: 'as yet unclassified' stamp: 'scb 6/13/2022 00:36:37'!
creationTime

	^timeOfActivation! !

!ActiveCart methodsFor: 'as yet unclassified' stamp: 'scb 6/13/2022 00:25:24'!
initializeWith: aCart for: aUser at: aDateAndTime 

	cart := aCart.
	user := aUser.
	timeOfActivation := aDateAndTime ! !

!ActiveCart methodsFor: 'as yet unclassified' stamp: 'scb 6/12/2022 23:29:27'!
user

	^user! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ActiveCart class' category: 'TusLibros'!
ActiveCart class
	instanceVariableNames: ''!

!ActiveCart class methodsFor: 'as yet unclassified' stamp: 'scb 6/13/2022 00:26:00'!
with: aCart for: aUser at: aDateAndTime 
	
	^ self new initializeWith: aCart for: aUser at: aDateAndTime! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'accessing' stamp: 'lk 6/6/2022 19:54:29'!
catalog
	
	^ catalog! !

!Cart methodsFor: 'accessing' stamp: 'scb 6/12/2022 20:10:40'!
contents
	
	^contents! !

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

!Cart methodsFor: 'adding' stamp: 'scb 6/9/2022 00:34:29'!
addPriceOf: aProduct To: aPrice
	
	^ aPrice + (catalog at: aProduct)
	! !


!Cart methodsFor: 'asserting' stamp: 'lk 6/6/2022 19:00:45'!
assertIsStrictlyPositiveInteger: anAmount

	^ anAmount strictlyPositive and: anAmount isInteger! !

!Cart methodsFor: 'asserting' stamp: 'scb 6/9/2022 00:29:07'!
assertStrictlyPositiveAmount: anAmount
	
	^ ( self assertIsStrictlyPositiveInteger: anAmount ) ifFalse: [ self riseInvalidAmountError ]
	! !

!Cart methodsFor: 'asserting' stamp: 'lk 6/6/2022 19:47:58'!
assertValidBook: aBook
	
	^ ( catalog keys includes: aBook ) ifFalse: [ self riseInvalidBookError ]
	! !


!Cart methodsFor: 'configuration' stamp: 'scb 6/12/2022 19:43:26'!
initiateWith: aCollection

	catalog := aCollection! !


!Cart methodsFor: 'enumerating' stamp: 'lk 6/6/2022 20:00:21'!
do: aClosure

	contents do: aClosure! !


!Cart methodsFor: 'error messages' stamp: 'scb 6/12/2022 19:49:56'!
invalidAmountErrorMessage

	^ self class invalidBookErrorMessage ! !

!Cart methodsFor: 'error messages' stamp: 'scb 6/12/2022 19:51:51'!
invalidBookErrorMessage

	^ self class invalidBookErrorMessage ! !


!Cart methodsFor: 'initialization' stamp: 'lk 6/6/2022 19:50:35'!
initialize

	catalog := Dictionary new.
	contents := OrderedCollection new.! !


!Cart methodsFor: 'rise error' stamp: 'scb 6/12/2022 19:51:17'!
riseInvalidAmountError

	^ self error: self invalidAmountErrorMessage! !

!Cart methodsFor: 'rise error' stamp: 'scb 6/12/2022 19:51:13'!
riseInvalidBookError

	^ self error: self invalidBookErrorMessage! !


!Cart methodsFor: 'testing' stamp: 'lk 6/6/2022 19:39:08'!
includes: aBook

	^ contents includes: aBook! !

!Cart methodsFor: 'testing' stamp: 'scb 6/5/2022 17:51:13'!
isEmpty
	
	^ contents isEmpty! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'scb 6/12/2022 19:52:13'!
invalidAmountErrorMessage

	^ 'invalid amount'! !

!Cart class methodsFor: 'instance creation' stamp: 'scb 6/12/2022 19:51:24'!
invalidBookErrorMessage

	^ 'Book is invalid.'! !

!Cart class methodsFor: 'instance creation' stamp: 'scb 6/12/2022 19:43:44'!
with: aCollection 

	^ self new initiateWith: aCollection.
	! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart creditCard ledger merchantProcessor owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'adding' stamp: 'scb 6/9/2022 00:34:16'!
calculatePrice
	
	| price |
	
	price := 0.
	cart do: [ :aProduct | price := cart addPriceOf: aProduct To: price].
	^ price.! !


!Cashier methodsFor: 'checkout' stamp: 'scb 6/9/2022 00:35:17'!
checkout
	
	| price |
	
	price := self calculatePrice.
	self merchantProcessorProcess: price.
	self updateLedgerWith: price.
	^ price.! !

!Cashier methodsFor: 'checkout' stamp: 'scb 6/9/2022 00:27:58'!
merchantProcessorProcess: price

	^ merchantProcessor debit: price from: creditCard! !

!Cashier methodsFor: 'checkout' stamp: 'scb 6/12/2022 23:37:10'!
updateLedgerWith: price

	ledger add: (Sale for: price madeBy: owner)! !


!Cashier methodsFor: 'initialization' stamp: 'scb 6/12/2022 23:24:01'!
initializeCheckoutOf: aCart ownedBy: anOwner with: aCreditCard using: aMerchantProcessor registerOn: aLedger.
	
	merchantProcessor := aMerchantProcessor.
	owner := anOwner.
	cart := aCart.
	creditCard := aCreditCard.
	ledger := aLedger.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error messages' stamp: 'lk 6/6/2022 19:29:32'!
emptyCartErrorMessage
	
	^ 'cart is empty'! !

!Cashier class methodsFor: 'error messages' stamp: 'scb 6/7/2022 18:54:06'!
expiredCreditCardErrorMessage
	
	^ 'credit card is expired'! !

!Cashier class methodsFor: 'error messages' stamp: 'scb 6/8/2022 23:02:02'!
notEnoughCreditOnCreditCardErrorMessage
	
	^ 'not enough credit on credit card'! !


!Cashier class methodsFor: 'instance creation' stamp: 'scb 6/12/2022 23:26:36'!
checkout: aCart ownedBy: anOwner with: aCreditCard on: aDate using: aMerchantProcessor registerOn: aLedger 
	
	(aCart isEmpty) ifTrue: [self error: self emptyCartErrorMessage ].
	(aCreditCard isExpiredOn: aDate) ifTrue: [self error: self expiredCreditCardErrorMessage ].
	
	^ self new initializeCheckoutOf: aCart ownedBy: anOwner with: aCreditCard using: aMerchantProcessor registerOn: aLedger.! !


!classDefinition: #Clock category: 'TusLibros'!
Object subclass: #Clock
	instanceVariableNames: 'time'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clock methodsFor: 'as yet unclassified' stamp: 'scb 6/13/2022 00:38:16'!
advance: anAmountOfTime

	time := time + anAmountOfTime! !

!Clock methodsFor: 'as yet unclassified' stamp: 'scb 6/13/2022 00:50:26'!
hasPassed: aGracePeriod since: aDateAndTime 

	^ time > (aDateAndTime + aGracePeriod)! !

!Clock methodsFor: 'as yet unclassified' stamp: 'scb 6/13/2022 00:31:15'!
initializeAt: aDateAndTime

	time := aDateAndTime! !

!Clock methodsFor: 'as yet unclassified' stamp: 'scb 6/13/2022 00:51:44'!
time

	^time! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Clock class' category: 'TusLibros'!
Clock class
	instanceVariableNames: ''!

!Clock class methodsFor: 'as yet unclassified' stamp: 'scb 6/13/2022 00:37:22'!
at: aDateAndTime

	^ self new initializeAt: aDateAndTime.! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'scb 6/7/2022 19:28:04'!
initializeWithExpirationDate: aDate

	expirationDate := aDate! !


!CreditCard methodsFor: 'testing' stamp: 'scb 6/7/2022 19:59:46'!
isExpiredOn: aDate

	^ expirationDate yearNumber < aDate yearNumber or: ( expirationDate yearNumber = aDate yearNumber and: expirationDate monthIndex < aDate monthIndex )! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'scb 6/12/2022 22:25:01'!
withExpirationDate: aDate

	^self new initializeWithExpirationDate: aDate! !


!classDefinition: #MerchantProcessor category: 'TusLibros'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'as yet unclassified' stamp: 'scb 6/12/2022 23:20:16'!
debit: anAmount from: aCreditCard! !


!classDefinition: #ObjectFactory category: 'TusLibros'!
Object subclass: #ObjectFactory
	instanceVariableNames: 'now'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ObjectFactory methodsFor: 'as yet unclassified' stamp: 'scb 6/12/2022 20:02:11'!
catalog

	^ Dictionary with: self validBook -> self validBookPrice! !

!ObjectFactory methodsFor: 'as yet unclassified' stamp: 'scb 6/13/2022 00:48:50'!
createClock

	^ Clock at: now! !

!ObjectFactory methodsFor: 'as yet unclassified' stamp: 'scb 6/13/2022 00:18:53'!
createInterfaceWith: clock

	^ TusLibrosInterface withCredentials: self credentials withCatalog: self catalog withClock: clock! !

!ObjectFactory methodsFor: 'as yet unclassified' stamp: 'scb 6/12/2022 20:00:35'!
credentials

	^ Dictionary with: self validUser -> self validPassword! !

!ObjectFactory methodsFor: 'as yet unclassified' stamp: 'scb 6/13/2022 00:33:12'!
initialize

	now := DateAndTime now! !

!ObjectFactory methodsFor: 'as yet unclassified' stamp: 'scb 6/12/2022 19:48:08'!
invalidBook

	^ 'invalid book'! !

!ObjectFactory methodsFor: 'as yet unclassified' stamp: 'scb 6/12/2022 20:26:44'!
invalidCartID

	^ 'invalid cart id'! !

!ObjectFactory methodsFor: 'as yet unclassified' stamp: 'scb 6/12/2022 20:04:08'!
invalidPassword

	^ 'invalid password'! !

!ObjectFactory methodsFor: 'as yet unclassified' stamp: 'scb 6/12/2022 20:04:01'!
invalidUser

	^ 'invalid user'! !

!ObjectFactory methodsFor: 'as yet unclassified' stamp: 'scb 6/13/2022 00:33:12'!
lastYear

	^ Month month: now monthIndex year: now yearNumber - 1

	! !

!ObjectFactory methodsFor: 'as yet unclassified' stamp: 'scb 6/13/2022 00:33:12'!
nextYear

	^ Month month: now monthIndex year: now yearNumber + 1

	! !

!ObjectFactory methodsFor: 'as yet unclassified' stamp: 'scb 6/13/2022 00:33:12'!
now
	^ now! !

!ObjectFactory methodsFor: 'as yet unclassified' stamp: 'scb 6/12/2022 19:24:05'!
validBook

	^ 'valid book'! !

!ObjectFactory methodsFor: 'as yet unclassified' stamp: 'scb 6/12/2022 20:02:21'!
validBookPrice

	^ 10! !

!ObjectFactory methodsFor: 'as yet unclassified' stamp: 'scb 6/12/2022 20:33:29'!
validCardNumber

	^ 'valid cardnumber'! !

!ObjectFactory methodsFor: 'as yet unclassified' stamp: 'scb 6/12/2022 20:33:42'!
validCardOwner

	^ 'Batman'! !

!ObjectFactory methodsFor: 'as yet unclassified' stamp: 'scb 6/12/2022 20:03:09'!
validPassword

	^ 'valid password'! !

!ObjectFactory methodsFor: 'as yet unclassified' stamp: 'scb 6/12/2022 20:00:46'!
validUser

	^ 'valid user'! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total customer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'as yet unclassified' stamp: 'scb 6/12/2022 23:22:55'!
customer

	^ customer! !

!Sale methodsFor: 'as yet unclassified' stamp: 'scb 6/12/2022 23:38:53'!
initializeFor: aPrice madeBy: aCustomer

	total := aPrice.
	customer := aCustomer.! !

!Sale methodsFor: 'as yet unclassified' stamp: 'scb 6/12/2022 23:13:35'!
total

	^ total! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'as yet unclassified' stamp: 'scb 6/12/2022 23:40:10'!
for: aPrice madeBy: aCustomer
	
	^ self new initializeFor: aPrice madeBy: aCustomer.! !


!classDefinition: #TusLibrosInterface category: 'TusLibros'!
Object subclass: #TusLibrosInterface
	instanceVariableNames: 'credentials carts factory currentID catalog ledger merchantProcessor purchases clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosInterface methodsFor: 'accessing' stamp: 'scb 6/13/2022 01:08:07'!
assertExistanceOfUser: aUsername andPassword: aPassword

	(credentials keys includes: aUsername) ifFalse: [ self error: self invalidCredentialsErrorMessage ].
	((credentials at: aUsername) isEqualTo: aPassword ) ifFalse: [ self error: self invalidCredentialsErrorMessage ]! !

!TusLibrosInterface methodsFor: 'accessing' stamp: 'scb 6/13/2022 01:08:07'!
listPurchasesOfUsername: aUsername withPassword: aPassword 
	
	self assertExistanceOfUser: aUsername andPassword: aPassword.
	^ ledger select: [ :sale | sale customer = aUsername].! !


!TusLibrosInterface methodsFor: 'cart' stamp: 'scb 6/13/2022 01:02:12'!
add: anAmount of: aProduct to: aCartID
	
	self validateCart: aCartID.
	(carts at: aCartID) cart add: anAmount of: aProduct! !

!TusLibrosInterface methodsFor: 'cart' stamp: 'scb 6/13/2022 01:08:52'!
createCartForUsername: aUser withPassword: aPassword
	
	self assertExistanceOfUser: aUser andPassword: aPassword.
	carts at: self nextCartID put: (ActiveCart with: (Cart with: catalog) for: aUser at: clock time ).
	^currentID 
	
	! !

!TusLibrosInterface methodsFor: 'cart' stamp: 'scb 6/13/2022 01:04:03'!
creationTimeOf: aCartID

	^ (carts at: aCartID) creationTime! !

!TusLibrosInterface methodsFor: 'cart' stamp: 'scb 6/12/2022 19:34:47'!
nextCartID
	
	currentID := currentID + 1.
	^currentID! !

!TusLibrosInterface methodsFor: 'cart' stamp: 'scb 6/13/2022 01:02:12'!
showContentsOf: aCartID

	self validateCart: aCartID.
	^ (carts at: aCartID) cart contents
	
	! !

!TusLibrosInterface methodsFor: 'cart' stamp: 'scb 6/13/2022 01:09:44'!
validateCart: aCartID

	(carts keys includes: aCartID) ifFalse: [ self error: self invalidCartErrorMessage ].
	(clock hasPassed: self gracePeriod since: (self creationTimeOf: aCartID)) ifTrue: [self error: self expiredCartErrorMessage].! !


!TusLibrosInterface methodsFor: 'cashier' stamp: 'scb 6/13/2022 01:02:12'!
checkout: aCartID withCreditCardNumber: aCreditCardNumber ownedBy: anOwner expiringOn: anExpirationDate

	self validateCart: aCartID.
	(Cashier checkout: (carts at: aCartID) cart
	ownedBy: (carts at: aCartID) user
	with: (CreditCard withExpirationDate: anExpirationDate)
	on: Date today
	using: merchantProcessor
	registerOn: ledger) checkout.
	
	! !


!TusLibrosInterface methodsFor: 'chrono' stamp: 'scb 6/13/2022 01:09:10'!
gracePeriod

	^ 30 minutes! !


!TusLibrosInterface methodsFor: 'error messages' stamp: 'scb 6/12/2022 20:41:48'!
emptyCartErrorMessage
	
	^ Cashier emptyCartErrorMessage! !

!TusLibrosInterface methodsFor: 'error messages' stamp: 'scb 6/13/2022 00:23:29'!
expiredCartErrorMessage
	
	^ 'this cart is expired'! !

!TusLibrosInterface methodsFor: 'error messages' stamp: 'scb 6/12/2022 22:31:38'!
expiredCreditCardErrorMessage
	
	^Cashier expiredCreditCardErrorMessage! !

!TusLibrosInterface methodsFor: 'error messages' stamp: 'scb 6/12/2022 19:56:32'!
invalidBookErrorMessage
	
	^ Cart invalidBookErrorMessage ! !

!TusLibrosInterface methodsFor: 'error messages' stamp: 'scb 6/12/2022 19:23:04'!
invalidCartErrorMessage
	
	^ 'invalid cart'! !

!TusLibrosInterface methodsFor: 'error messages' stamp: 'scb 6/12/2022 19:12:13'!
invalidCredentialsErrorMessage
	
	^ 'invalid username or password'! !


!TusLibrosInterface methodsFor: 'initialize' stamp: 'scb 6/13/2022 00:19:40'!
initializeWithCredentials: aCredentials withCatalog: aCatalog withClock: aClock  

	credentials := aCredentials.
	carts := Dictionary new.
	currentID := 0.
	catalog := aCatalog.
	merchantProcessor := MerchantProcessor new.
	ledger := OrderedCollection new.
	clock := aClock! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosInterface class' category: 'TusLibros'!
TusLibrosInterface class
	instanceVariableNames: ''!

!TusLibrosInterface class methodsFor: 'intance creation' stamp: 'scb 6/13/2022 00:19:18'!
withCredentials: aCredentials withCatalog: aCatalog withClock: clock  
	
	^ self new initializeWithCredentials: aCredentials withCatalog: aCatalog withClock: clock  ! !
