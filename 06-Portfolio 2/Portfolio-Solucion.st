!classDefinition: #Test category: 'Portfolio-Solucion'!
TestCase subclass: #Test
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!


!classDefinition: #AccountSummaryTest category: 'Portfolio-Solucion'!
Test subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryTest methodsFor: 'assertions' stamp: 'scb 5/30/2022 00:00:52'!
assert: anAccountSummaryRows at: anIndex isBalanceEqualTo: aValue

	^self assert: anAccountSummaryRows at: anIndex isEqualTo: ('Balance = ', aValue asString,'.')! !

!AccountSummaryTest methodsFor: 'assertions' stamp: 'scb 5/29/2022 23:59:58'!
assert: anAccountSummaryRows at: anIndex isEqualTo: aString

	^ (anAccountSummaryRows at: anIndex) = aString! !

!AccountSummaryTest methodsFor: 'assertions' stamp: 'scb 5/29/2022 23:41:43'!
assertBalanceEqualTo25In: anAccountSummaryRows at: anIndex

	^ self assert: anAccountSummaryRows at: anIndex isBalanceEqualTo: 25! !

!AccountSummaryTest methodsFor: 'assertions' stamp: 'scb 5/30/2022 00:04:52'!
assertFirstThreeRowsFrom: anAccountSummaryRows

	^(self assert: anAccountSummaryRows at: 1 isEqualTo: self depositoPor100) and: 
	(self assert: anAccountSummaryRows at: 2 isEqualTo: self extraccionPor50) and: 
	(self assert: anAccountSummaryRows at: 3 isEqualTo: self salidaPorTransferenciaDe25)! !

!AccountSummaryTest methodsFor: 'assertions' stamp: 'scb 5/29/2022 23:58:04'!
assertRowTransferDepositFrom: anAccountSummaryRows at: anIndex

	^((anAccountSummaryRows at: anIndex) = self entradaPorTransferenciaDe25 )! !


!AccountSummaryTest methodsFor: 'constant strings' stamp: 'scb 5/29/2022 23:56:28'!
depositoPor100
	
	^ 'Deposito por 100.'! !

!AccountSummaryTest methodsFor: 'constant strings' stamp: 'scb 5/29/2022 23:57:39'!
entradaPorTransferenciaDe25
	
	^ 'Entrada por transferencia de 25.'! !

!AccountSummaryTest methodsFor: 'constant strings' stamp: 'scb 5/29/2022 23:58:26'!
extraccionPor50

	^ 'Extraccion por 50.'! !

!AccountSummaryTest methodsFor: 'constant strings' stamp: 'scb 5/29/2022 23:58:50'!
salidaPorTransferenciaDe25

	^ 'Salida por transferencia de 25.'! !


!AccountSummaryTest methodsFor: 'test' stamp: 'scb 5/30/2022 00:07:26'!
test01AccountSummaryPrintsAccountTransactionsProperly

	| anAccount anotherAccount anAccountSummaryRows anotherAccountSummaryRows |
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	self depositWithdrawAndTransferFrom: anAccount to: anotherAccount.
	anAccountSummaryRows := (AccountSummary for: anAccount) rows.
	anotherAccountSummaryRows := (AccountSummary for: anotherAccount) rows.
	
	self assert: ((anAccountSummaryRows size = 4) and: 
			(self assertFirstThreeRowsFrom: anAccountSummaryRows) and: 
			(self assertBalanceEqualTo25In: anAccountSummaryRows at: 4)).
			
	self assert: ((anotherAccountSummaryRows size = 2) and: 
			(self assertRowTransferDepositFrom: anotherAccountSummaryRows at: 1) and: 
			(self assertBalanceEqualTo25In: anotherAccountSummaryRows at: 2)).! !

!AccountSummaryTest methodsFor: 'test' stamp: 'scb 5/30/2022 00:04:25'!
test02AccountSummaryPrintsPortfolioTransactionsProperly

	| anAccount anotherAccount aPortfolio anotherPortfolio anAccountSummaryRows |
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	aPortfolio := Portfolio with: anAccount.
	anotherPortfolio := Portfolio with: aPortfolio with: anotherAccount.
	self depositWithdrawAndTransferFrom: anAccount to: anotherAccount.
	anAccountSummaryRows := (AccountSummary for: anotherPortfolio) rows.
	
	self assert: ((anAccountSummaryRows size = 5) and: 
			((self assertFirstThreeRowsFrom: anAccountSummaryRows)) and:
			(self assertRowTransferDepositFrom: anAccountSummaryRows at: 4) and: 
			(self assert: anAccountSummaryRows at: 5 isBalanceEqualTo: 50)).! !


!AccountSummaryTest methodsFor: 'transactions' stamp: 'scb 5/29/2022 23:17:02'!
depositWithdrawAndTransferFrom: anAccount to: anotherAccount

	Deposit register: 100 on: anAccount.
	Withdraw register: 50 on: anAccount.
	Transfer from: anAccount to: anotherAccount anAmmountOf: 25! !


!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
Test subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
Test subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #TransferNetTest category: 'Portfolio-Solucion'!
Test subclass: #TransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetTest methodsFor: 'test' stamp: 'scb 5/29/2022 23:53:26'!
assertTransferNetValueOf: anAccount equals: aValue

	^ (TransferNet for: anAccount) value = aValue! !

!TransferNetTest methodsFor: 'test' stamp: 'scb 5/29/2022 23:53:53'!
assertZeroEqualsTransferNetValueOf: aPortfolio

	^ self assertTransferNetValueOf: aPortfolio equals: 0! !

!TransferNetTest methodsFor: 'test' stamp: 'scb 5/29/2022 23:53:18'!
test01TransferNetIsUnaffectedByDepositsAndWithdraws

	| anAccount |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	Withdraw register: 50 on: anAccount.
	
	self assertZeroEqualsTransferNetValueOf: anAccount! !

!TransferNetTest methodsFor: 'test' stamp: 'scb 5/29/2022 23:54:37'!
test02TransferNetIsAffectedByTransfers

	| anAccount anotherAccount aPortfolio |
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	aPortfolio := Portfolio with: anAccount with: anotherAccount.
	Transfer from: anAccount to: anotherAccount anAmmountOf: 100.
	
	self assert: ((self assertTransferNetValueOf: anAccount equals: -100) and: 
			(self assertTransferNetValueOf: anotherAccount equals: 100) and: 
			((self assertZeroEqualsTransferNetValueOf: aPortfolio)))! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
Test subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'test' stamp: 'scb 5/27/2022 18:42:21'!
test01TransferWithdrawsFromSenderAndDepositToRecipient

	| aSender aReceiver |
	
	aSender := ReceptiveAccount new.
	aReceiver := ReceptiveAccount new.
	Transfer from: aSender to: aReceiver anAmmountOf: 100.
	
	self assert: ( (aSender balance = -100) and: aReceiver balance = 100 )! !

!TransferTest methodsFor: 'test' stamp: 'scb 5/27/2022 19:05:52'!
test02TransferIsRegisteredInSenderAndReceiver

	| aSender aReceiver aTransfer |
	
	aSender := ReceptiveAccount new.
	aReceiver := ReceptiveAccount new.
	aTransfer := Transfer from: aSender to: aReceiver anAmmountOf: 100.
	
	self assert: (( aSender hasRegistered: aTransfer withdraw ) and: ( aReceiver hasRegistered: aTransfer deposit ))! !

!TransferTest methodsFor: 'test' stamp: 'scb 5/27/2022 19:39:19'!
test03TransferKnowsItsValue

	| aSender aReceiver aTransfer |
	
	aSender := ReceptiveAccount new.
	aReceiver := ReceptiveAccount new.
	aTransfer := Transfer from: aSender to: aReceiver anAmmountOf: 100.
	
	self assert: ( aTransfer value = 100 )! !

!TransferTest methodsFor: 'test' stamp: 'scb 5/29/2022 18:17:06'!
test04TransferLegsKnowTransfer

	| aSender aReceiver aTransfer |
	
	aSender := ReceptiveAccount new.
	aReceiver := ReceptiveAccount new.
	aTransfer := Transfer from: aSender to: aReceiver anAmmountOf: 100.
	
	self assert: ((aTransfer withdraw transfer = aTransfer) and: (aTransfer deposit transfer = aTransfer))! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'recording' stamp: 'scb 5/29/2022 20:10:27'!
recordTransactionsWith: anAccountSummary

	accounts do: [ :transaction | transaction recordTransactionsWith: anAccountSummary ].! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'recording' stamp: 'scb 5/29/2022 19:13:27'!
recordTransactionsWith: anAccountSummary

	transactions do: [ :transaction | transaction recordOn: anAccountSummary ].! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'accessing' stamp: 'scb 5/29/2022 23:09:29'!
value

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'accessing' stamp: 'scb 5/29/2022 23:13:16'!
valueAsString

	^ self value asString! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'initialization' stamp: 'scb 5/29/2022 23:10:02'!
initializeFor: aValue

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'recording' stamp: 'scb 5/29/2022 22:58:26'!
recordOn: anAccountSummary

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #IndependentTransaction category: 'Portfolio-Solucion'!
AccountTransaction subclass: #IndependentTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!IndependentTransaction methodsFor: 'accessing' stamp: 'scb 5/29/2022 22:51:55'!
value

	^ value! !


!IndependentTransaction methodsFor: 'balance' stamp: 'scb 5/29/2022 23:08:17'!
affectBalance: aBalance

	self subclassResponsibility ! !


!IndependentTransaction methodsFor: 'initialization' stamp: 'scb 5/29/2022 22:52:12'!
initializeFor: aValue

	value := aValue ! !


!IndependentTransaction methodsFor: 'recording' stamp: 'scb 5/29/2022 22:58:22'!
recordOn: anAccountSummary

	self subclassResponsibility ! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
IndependentTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'balance' stamp: 'scb 5/27/2022 20:01:25'!
affectBalance: aBalance

	^aBalance + value! !


!Deposit methodsFor: 'recording' stamp: 'scb 5/29/2022 22:55:02'!
recordOn: anAccountSummary

	anAccountSummary recordDeposit: self ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
IndependentTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'balance' stamp: 'scb 5/27/2022 20:01:30'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'recording' stamp: 'scb 5/29/2022 22:55:16'!
recordOn: anAccountSummary

	anAccountSummary recordWithdraw: self ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferTransaction category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferTransaction
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTransaction methodsFor: 'accessing' stamp: 'scb 5/29/2022 22:47:03'!
transfer
	
	^transfer! !

!TransferTransaction methodsFor: 'accessing' stamp: 'scb 5/29/2022 22:46:34'!
value
	
	^transfer value! !


!TransferTransaction methodsFor: 'balance' stamp: 'scb 5/29/2022 23:07:24'!
affectBalance: aBalance

	self subclassResponsibility ! !


!TransferTransaction methodsFor: 'initialization' stamp: 'scb 5/29/2022 22:47:57'!
initializeFor: aTransfer

	transfer := aTransfer! !


!TransferTransaction methodsFor: 'recording' stamp: 'scb 5/29/2022 22:58:22'!
recordOn: anAccountSummary

	self subclassResponsibility ! !


!classDefinition: #TransferDeposit category: 'Portfolio-Solucion'!
TransferTransaction subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferDeposit methodsFor: 'balance' stamp: 'scb 5/29/2022 23:07:11'!
affectBalance: aBalance

	^aBalance + transfer value! !


!TransferDeposit methodsFor: 'recording' stamp: 'scb 5/29/2022 22:54:50'!
recordOn: anAccountSummary

	anAccountSummary recordTransferDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: 'Portfolio-Solucion'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'instance creation' stamp: 'scb 5/29/2022 18:07:05'!
for: transfer

	^ self new initializeFor: transfer! !

!TransferDeposit class methodsFor: 'instance creation' stamp: 'scb 5/29/2022 18:06:36'!
on: transfer! !


!classDefinition: #TransferWithdraw category: 'Portfolio-Solucion'!
TransferTransaction subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferWithdraw methodsFor: 'balance' stamp: 'scb 5/29/2022 18:13:27'!
affectBalance: aBalance

	^aBalance - transfer value! !


!TransferWithdraw methodsFor: 'recording' stamp: 'scb 5/29/2022 22:54:32'!
recordOn: anAccountSummary

	anAccountSummary recordTransferWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: 'Portfolio-Solucion'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'instance creator' stamp: 'scb 5/29/2022 18:07:14'!
for: transfer

	^ self new initializeFor: transfer! !


!classDefinition: #Report category: 'Portfolio-Solucion'!
Object subclass: #Report
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Report methodsFor: 'recording' stamp: 'scb 5/29/2022 23:50:06'!
recordDeposit: aDeposit

	self subclassResponsibility ! !

!Report methodsFor: 'recording' stamp: 'scb 5/29/2022 23:50:01'!
recordTransferDeposit: aTransferDeposit

	self subclassResponsibility ! !

!Report methodsFor: 'recording' stamp: 'scb 5/29/2022 23:49:50'!
recordTransferWithdraw: aTransferWithdraw

	self subclassResponsibility ! !

!Report methodsFor: 'recording' stamp: 'scb 5/29/2022 23:49:37'!
recordWithdraw: aWithdraw

	self subclassResponsibility ! !


!Report methodsFor: 'initialization' stamp: 'scb 5/29/2022 23:47:48'!
initializeFor: anAccount

	account := anAccount! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
Report subclass: #AccountSummary
	instanceVariableNames: 'rows'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'recording' stamp: 'scb 5/29/2022 23:13:33'!
recordDeposit: aDeposit
	
	rows add: ('Deposito por ', aDeposit valueAsString, '.')! !

!AccountSummary methodsFor: 'recording' stamp: 'scb 5/29/2022 23:13:38'!
recordTransferDeposit: aTransferDeposit
	
	rows add: ('Entrada por transferencia de ', aTransferDeposit valueAsString, '.')! !

!AccountSummary methodsFor: 'recording' stamp: 'scb 5/29/2022 23:13:48'!
recordTransferWithdraw: aTransferWithdraw
	
	rows add: ('Salida por transferencia de ', aTransferWithdraw valueAsString, '.')! !

!AccountSummary methodsFor: 'recording' stamp: 'scb 5/29/2022 23:13:54'!
recordWithdraw: aWithdraw
	
	rows add: ('Extraccion por ', aWithdraw valueAsString, '.')! !


!AccountSummary methodsFor: 'rows' stamp: 'scb 5/29/2022 19:35:42'!
rows

	rows := OrderedCollection new.
	account recordTransactionsWith: self.
	rows add: ('Balance = ', account balance asString, '.').
	^ rows! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'Portfolio-Solucion'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'scb 5/29/2022 19:07:06'!
for: anAccount

	^self new initializeFor: anAccount! !


!classDefinition: #TransferNet category: 'Portfolio-Solucion'!
Report subclass: #TransferNet
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'recording' stamp: 'scb 5/29/2022 20:31:11'!
recordDeposit: aDeposit! !

!TransferNet methodsFor: 'recording' stamp: 'scb 5/29/2022 20:32:49'!
recordTransferDeposit: aTransactionDeposit
	
	value := value + aTransactionDeposit value! !

!TransferNet methodsFor: 'recording' stamp: 'scb 5/29/2022 20:32:59'!
recordTransferWithdraw: aTransactionWithdraw
	
	value := value - aTransactionWithdraw value! !

!TransferNet methodsFor: 'recording' stamp: 'scb 5/29/2022 20:31:18'!
recordWithdraw: aDeposit! !


!TransferNet methodsFor: 'value' stamp: 'scb 5/29/2022 20:29:18'!
value
	
	value := 0.
	account recordTransactionsWith: self.
	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: 'Portfolio-Solucion'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'instance creation' stamp: 'scb 5/29/2022 20:16:55'!
for: anAccount

	^ self new initializeFor: anAccount! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdraw deposit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'accessing' stamp: 'scb 5/27/2022 19:06:28'!
deposit
	
	^deposit! !

!Transfer methodsFor: 'accessing' stamp: 'scb 5/27/2022 19:40:46'!
value
	
	^value! !

!Transfer methodsFor: 'accessing' stamp: 'scb 5/27/2022 19:06:11'!
withdraw
	
	^withdraw! !


!Transfer methodsFor: 'initialization' stamp: 'scb 5/29/2022 18:07:34'!
initializeWith: aValue
 
	value := aValue.
	withdraw := TransferWithdraw for: self.
	deposit := TransferDeposit for: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'scb 5/29/2022 18:14:01'!
from: sender to: receiver anAmmountOf: value

	| transfer |
	
	transfer := self new initializeWith: value.
	sender register: transfer withdraw.
	receiver register: transfer deposit.
	^ transfer.! !
