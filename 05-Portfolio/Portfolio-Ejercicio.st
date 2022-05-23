!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'initializations' stamp: 'scb 5/23/2022 02:51:22'!
initiateAPortfolioWithAnAccountWithDeposit: aDeposit

	| aPortfolio anAccount |
	
	aPortfolio := Portfolio new.
	anAccount := self initiateAccountWithDeposit: aDeposit.
	^ aPortfolio register: anAccount.! !

!PortfolioTest methodsFor: 'initializations' stamp: 'scb 5/23/2022 02:39:31'!
initiateAccountWithDeposit: deposit

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: deposit on: account.
	^account! !


!PortfolioTest methodsFor: 'test' stamp: 'scb 5/22/2022 22:50:49'!
test01BalanceOfNewPortfolioIsEqualToZero

	| aPortfolio |
	
	aPortfolio := Portfolio new.
	self assert: aPortfolio balance = 0.! !

!PortfolioTest methodsFor: 'test' stamp: 'scb 5/23/2022 02:51:51'!
test02PorfolioBalanceIncreasesAfterAddingAccount 

	| aPortfolio |
	
	aPortfolio := self initiateAPortfolioWithAnAccountWithDeposit: 100.
	
	self assert: aPortfolio balance = 100.! !

!PortfolioTest methodsFor: 'test' stamp: 'scb 5/23/2022 02:52:44'!
test03PorfolioBalanceIncreasesAfterAddingPortfolio

	| aPortfolio aSecondPortfolio |
	
	aPortfolio := aPortfolio := self initiateAPortfolioWithAnAccountWithDeposit: 100.
	aSecondPortfolio := Portfolio new.
	
	self assert: (aSecondPortfolio register: aPortfolio) balance = 100.! !

!PortfolioTest methodsFor: 'test' stamp: 'scb 5/23/2022 02:37:58'!
test04EmptyPortfolioHasNoRegisteredTransaction

	| aPortfolio aDeposit|
	
	aPortfolio := Portfolio new.
	aDeposit := Deposit new.
	
	self assert: (aPortfolio hasRegistered: aDeposit) = false! !

!PortfolioTest methodsFor: 'test' stamp: 'scb 5/23/2022 02:41:05'!
test05PortfolioKnowsRegisteredTransactionsOnAccounts

	| aPortfolio anAccount aDeposit|
	
	aPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	aDeposit := Deposit register: 100 on: anAccount.
	
	self assert: ((aPortfolio register: anAccount) hasRegistered: aDeposit)! !

!PortfolioTest methodsFor: 'test' stamp: 'scb 5/23/2022 02:41:47'!
test06PortfolioKnowsRegisteredTransactionsOnOtherPortfolios

	| aPortfolio anotherPortfolio anAccount aDiscount |
	
	aPortfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	aDiscount := Deposit register: 100 on: anAccount.
	
	self assert: ((anotherPortfolio register: (aPortfolio register: anAccount)) hasRegistered: aDiscount).! !

!PortfolioTest methodsFor: 'test' stamp: 'scb 5/22/2022 23:12:02'!
test07EmptyPortfolioHasNoTransactions

	| aPortfolio |
	
	aPortfolio := Portfolio new.
	
	self assert: (aPortfolio transactions = OrderedCollection new).! !

!PortfolioTest methodsFor: 'test' stamp: 'scb 5/22/2022 23:17:44'!
test08PortfolioKnowsTransactionsRegisteredOnAccounts

	| aPortfolio anAccount aDeposit transactions |
	
	aPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	aDeposit := Deposit register: 100 on: anAccount.
	transactions := OrderedCollection with: aDeposit.
	
	self assert: (aPortfolio register: anAccount) transactions = transactions.! !

!PortfolioTest methodsFor: 'test' stamp: 'scb 5/23/2022 02:43:11'!
test09PortfolioKnowsTransactionsRegisteredOnPorfolios

	| aPortfolio anotherPortfolio anAccount aDeposit transactions |
	
	aPortfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	aDeposit := Deposit register: 100 on: anAccount.
	transactions := OrderedCollection with: aDeposit.
	
	self assert: (aPortfolio register: (anotherPortfolio register: anAccount)) transactions = transactions.! !

!PortfolioTest methodsFor: 'test' stamp: 'scb 5/23/2022 02:48:42'!
test10PortfolioCantAddSelf

	| aPortfolio |
	
	aPortfolio := Portfolio new.
	
	self compareReapeatedItemErrorWithErrorIn: [ aPortfolio register: aPortfolio ].! !

!PortfolioTest methodsFor: 'test' stamp: 'scb 5/23/2022 02:48:36'!
test11PortfolioCantAddRepeatedAccount

	| aPortfolio anAccount |
	
	aPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	
	self compareReapeatedItemErrorWithErrorIn: [ (aPortfolio register: anAccount) register: anAccount ]! !

!PortfolioTest methodsFor: 'test' stamp: 'scb 5/23/2022 02:48:28'!
test12PortfolioCantAddRepeatedPortfolio

	| aPortfolio anotherPortfolio |
	
	aPortfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	
	self compareReapeatedItemErrorWithErrorIn: [ (aPortfolio register: anotherPortfolio) register: anotherPortfolio ]! !

!PortfolioTest methodsFor: 'test' stamp: 'scb 5/23/2022 02:49:03'!
test13PortfolioCantAddPortfolioWithRepeatedAccounts

	| aPortfolio anotherPortfolio anAccount |
	
	aPortfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	
	self compareReapeatedItemErrorWithErrorIn: [ (aPortfolio register: anAccount) register: (anotherPortfolio register: anAccount) ]! !

!PortfolioTest methodsFor: 'test' stamp: 'scb 5/23/2022 02:49:18'!
test14PortfolioCantAddPortfolioWithRepeatedPortfolios

	| aPortfolio anotherPortfolio evenAnotherPortfolio |
	
	aPortfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	evenAnotherPortfolio := Portfolio new.
	
	self compareReapeatedItemErrorWithErrorIn: [ (aPortfolio register: anotherPortfolio) register: (evenAnotherPortfolio register: anotherPortfolio) ]! !

!PortfolioTest methodsFor: 'test' stamp: 'scb 5/23/2022 02:49:31'!
test15PortfolioCantAddPortfolioWithRepeatedSubPortfolios

	| aPortfolio anotherPortfolio evenAnotherPortfolio anAccount |
	
	aPortfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	evenAnotherPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	
	self compareReapeatedItemErrorWithErrorIn: [ (aPortfolio register: (anotherPortfolio register: anAccount)) register: (evenAnotherPortfolio register: anAccount) ]! !


!PortfolioTest methodsFor: 'test - auxiliary' stamp: 'scb 5/23/2022 02:47:26'!
compareReapeatedItemErrorWithErrorIn: aClosure

	^ self should: aClosure
		raise: Error
		withExceptionDo: [:anError |
			self assert: anError messageText = Portfolio repeatedItemErrorDescription ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'initializations' stamp: 'scb 5/23/2022 02:33:01'!
initiateAccountWithDeposit: deposit

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: deposit on: account.
	^account
! !

!ReceptiveAccountTest methodsFor: 'initializations' stamp: 'scb 5/23/2022 02:34:12'!
initiateAccountWithDeposit: deposit andWithdrawl: withdrawl

	| account |
	
	account := self initiateAccountWithDeposit: deposit.
	Withdraw register: withdrawl on: account.
	^account
! !


!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'scb 5/23/2022 02:34:34'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := self initiateAccountWithDeposit: 100.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'scb 5/23/2022 02:35:08'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := self initiateAccountWithDeposit: 100 andWithdrawl: 50.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'scb 5/23/2022 02:28:50'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/16/2022 16:19:11'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
	
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'scb 5/23/2022 02:29:32'!
test07AccountKnowsItsTransactions 

	| anAccount aDeposit |
	
	anAccount := ReceptiveAccount new.
	
	aDeposit := Deposit register: 50 on: anAccount.
		
	self assert: 1 equals: anAccount transactions size.
	self assert: (anAccount transactions includes: aDeposit).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'initialization' stamp: 'scb 5/23/2022 00:09:37'!
initializeFor: aValue

	value := aValue ! !


!AccountTransaction methodsFor: 'value' stamp: 'scb 5/23/2022 02:24:08'!
balance
	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'scb 5/23/2022 00:09:23'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'value' stamp: 'scb 5/22/2022 22:43:26'!
addBalanceTo: sum 

	^ sum + value. ! !

!Deposit methodsFor: 'value' stamp: 'scb 5/23/2022 02:23:46'!
balance
	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'value' stamp: 'scb 5/23/2022 02:23:11'!
balance

	^ value negated! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Services category: 'Portfolio-Ejercicio'!
Object subclass: #Services
	instanceVariableNames: 'register'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Services methodsFor: 'accessing' stamp: 'scb 5/23/2022 02:13:57'!
asOrderedCollection

	self subclassResponsibility.! !


!Services methodsFor: 'balance' stamp: 'scb 5/23/2022 02:16:40'!
balance

	self subclassResponsibility.! !


!Services methodsFor: 'initialization' stamp: 'scb 5/23/2022 02:17:50'!
initialize

	register := OrderedCollection new.! !


!Services methodsFor: 'testing' stamp: 'scb 5/23/2022 02:17:11'!
hasRegistered: anItem

	self subclassResponsibility.! !


!Services methodsFor: 'transactions' stamp: 'scb 5/23/2022 02:18:57'!
register: aTransaction

	self subclassResponsibility.! !

!Services methodsFor: 'transactions' stamp: 'scb 5/23/2022 02:19:50'!
transactions

	self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Services subclass: #Portfolio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'accessing' stamp: 'scb 5/23/2022 01:57:19'!
asOrderedCollection
	
	| services |
	
	services := OrderedCollection with: self.
	register do: [ :aRegisteredItem | services := services, aRegisteredItem asOrderedCollection].
	^ services.! !


!Portfolio methodsFor: 'balance' stamp: 'scb 5/23/2022 01:58:00'!
balance
	
	^ register sum: [ :aRegisteredItem | aRegisteredItem balance] ifEmpty: [0]! !


!Portfolio methodsFor: 'error handling' stamp: 'scb 5/23/2022 02:05:05'!
repeatedItemError

	^ self error: (Portfolio repeatedItemErrorDescription)! !


!Portfolio methodsFor: 'testing' stamp: 'scb 5/23/2022 02:03:48'!
contains: aRegisteredItem

	^ (self asOrderedCollection) includes: aRegisteredItem! !

!Portfolio methodsFor: 'testing' stamp: 'scb 5/23/2022 02:03:48'!
hasIntersectionWith: anItem
	
	^ (anItem asOrderedCollection) anySatisfy: [ :aRegisteredItem | self contains: aRegisteredItem]! !

!Portfolio methodsFor: 'testing' stamp: 'scb 5/23/2022 01:59:00'!
hasRegistered: aTransaction
	
	^ register anySatisfy: [ :aRegisteredItem | aRegisteredItem hasRegistered: aTransaction]! !


!Portfolio methodsFor: 'transactions' stamp: 'scb 5/23/2022 02:05:05'!
register: anItem
	
	(self hasIntersectionWith: anItem) ifTrue: [ self repeatedItemError ].
	register add: anItem! !

!Portfolio methodsFor: 'transactions' stamp: 'scb 5/23/2022 01:59:56'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	register do: [ :aRegisteredItem | transactions := transactions, aRegisteredItem transactions ].
	^transactions.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error descriptions' stamp: 'scb 5/22/2022 23:23:26'!
repeatedItemErrorDescription

	^ 'An item was already registered in this portfolio'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Services subclass: #ReceptiveAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'accessing' stamp: 'scb 5/23/2022 01:53:17'!
asOrderedCollection
	
	^ OrderedCollection with: self! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'scb 5/23/2022 02:25:51'!
balance

	^register sum: [ :aTransaction | aTransaction balance ] ifEmpty: [ 0 ].! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'scb 5/23/2022 02:08:26'!
hasRegistered: aTransaction

	^ register includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'scb 5/23/2022 02:08:42'!
register: aTransaction

	register add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'scb 5/23/2022 02:08:51'!
transactions 

	^ register copy! !
