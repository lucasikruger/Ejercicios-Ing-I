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


!CartTest methodsFor: 'test - error' stamp: 'lk 6/6/2022 19:02:52'!
with: aCart should: aClosureToFail riseErrorWithMessage: errorMessage

	self should: aClosureToFail
	raise: Error
	withMessageText: errorMessage.
	
	self assertIsEmpty: aCart
	! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'debitedAmount debitedCreditCard error'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'assertions' stamp: 'scb 6/9/2022 00:41:21'!
assert: aLedger includesOneItemOfPrice: aPrice

	self assert: 1 equals: aLedger size.
	self assert: aPrice equals: aLedger first! !

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


!CashierTest methodsFor: 'initialization' stamp: 'scb 6/9/2022 00:18:59'!
initializeCartWithCatalogAndAnAmountOfBooks: anAmount

	| aCart |
	
	aCart := Cart checkout: self initializeCatalog.
	anAmount timesRepeat: [aCart add: 1 of: self book].
	^aCart! !

!CashierTest methodsFor: 'initialization' stamp: 'scb 6/9/2022 00:07:00'!
initializeCashierCheckout: aCart on: aCreditCard registerOn: aLedger 

	^ Cashier checkout: aCart with: aCreditCard on: (self initializeMonthYearNow) using: self registerOn: aLedger! !

!CashierTest methodsFor: 'initialization' stamp: 'scb 6/8/2022 23:11:21'!
initializeCatalog

	^ Dictionary with: self bookValueRelation! !

!CashierTest methodsFor: 'initialization' stamp: 'scb 6/8/2022 23:27:06'!
initializeEmptyCart

	^ Cart new! !

!CashierTest methodsFor: 'initialization' stamp: 'scb 6/8/2022 23:40:34'!
initializeEmptyOrderedCollection

	^ OrderedCollection new! !

!CashierTest methodsFor: 'initialization' stamp: 'scb 6/8/2022 23:56:49'!
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

!CashierTest methodsFor: 'initialization' stamp: 'scb 6/8/2022 23:19:07'!
initializeNotExpiredCreditCard

	^ CreditCard withExpirationDate: (self initializeMonthYearNextYear)! !


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


!Cart methodsFor: 'configuration' stamp: 'scb 6/7/2022 18:49:06'!
checkout: aCollection

	catalog := aCollection! !


!Cart methodsFor: 'enumerating' stamp: 'lk 6/6/2022 20:00:21'!
do: aClosure

	contents do: aClosure! !


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


!Cart methodsFor: 'rise error' stamp: 'scb 6/5/2022 19:00:43'!
riseInvalidAmountError

	^ self error: self invalidAmountErrorMessage! !

!Cart methodsFor: 'rise error' stamp: 'scb 6/5/2022 19:01:19'!
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

!Cart class methodsFor: 'instance creation' stamp: 'scb 6/7/2022 18:49:06'!
checkout: aCollection 

	^ self new checkout: aCollection.
	! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart creditCard ledger merchantProcessor'
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

!Cashier methodsFor: 'checkout' stamp: 'scb 6/9/2022 00:25:17'!
updateLedgerWith: price

	ledger add: price! !


!Cashier methodsFor: 'initialization' stamp: 'scb 6/8/2022 22:50:23'!
initializeCheckoutOf: aCart with: aCreditCard using: aMerchantProcessor registerOn: aLedger.
	
	merchantProcessor := aMerchantProcessor.
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


!Cashier class methodsFor: 'instance creation' stamp: 'scb 6/8/2022 22:49:22'!
checkout: aCart with: aCreditCard on: aDate using: aMerchantProcessor registerOn: aLedger 
	
	(aCart isEmpty) ifTrue: [self error: self emptyCartErrorMessage ].
	(aCreditCard isExpiredOn: aDate) ifTrue: [self error: self expiredCreditCardErrorMessage ].
	
	^ self new initializeCheckoutOf: aCart with: aCreditCard using: aMerchantProcessor registerOn: aLedger.! !


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

!CreditCard class methodsFor: 'instance creation' stamp: 'scb 6/7/2022 19:53:30'!
withExpirationDate: aDate

	^self new initializeWithExpirationDate: aDate! !
