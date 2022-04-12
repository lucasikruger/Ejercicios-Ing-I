!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'llk 4/12/2022 20:11:59'!
addAndSuspendPaulMcCartneyTo: customerBook
|paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'llk 4/12/2022 19:01:45'!
closure: closureToValue shouldNotTakeMoreThan: timeLimitInMilliseconds

|millisecondsBeforeRunning millisecondsAfterRunning|
millisecondsBeforeRunning := Time millisecondClockValue * millisecond.

closureToValue value.

millisecondsAfterRunning := Time millisecondClockValue * millisecond.

self assert: (millisecondsAfterRunning - millisecondsBeforeRunning) > ( timeLimitInMilliseconds* millisecond).
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'llk 4/12/2022 19:51:40'!
johnLennonEsElUnicoEn: customerBook 
	 [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: 'John Lennon') ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'llk 4/12/2022 20:11:37'!
noActiveAnd: numberOfTotalAndSuspendedCustomers totalAndSuspendedCustomersIn: customerBook
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: numberOfTotalAndSuspendedCustomers equals: customerBook numberOfSuspendedCustomers.
	self assert: numberOfTotalAndSuspendedCustomers equals: customerBook numberOfCustomers.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'llk 4/12/2022 19:02:25'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	|customerBook|.
	customerBook:= CustomerBook new.
	self closure: [customerBook addCustomerNamed: 'Jonh Lennon'] shouldNotTakeMoreThan: 50.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'llk 4/12/2022 19:02:33'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	|customerBook|.
	customerBook:= CustomerBook new.
	self closure: [customerBook removeCustomerNamed: 'Paul McCartney'.] shouldNotTakeMoreThan: 100.
	

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'llk 4/12/2022 19:34:59'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	[ customerBook addCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'llk 4/12/2022 19:52:45'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook|
			
	customerBook := CustomerBook new.
	
	[ customerBook removeCustomerNamed: 'Paul McCartney'.
	self fail ]
		on: NotFound 
		do: [self johnLennonEsElUnicoEn: customerBook]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'llk 4/12/2022 20:15:53'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook|
	
	customerBook := CustomerBook new.
	
	self addAndSuspendPaulMcCartneyTo: customerBook.
	
	
	
	self noActiveAnd: 1 totalAndSuspendedCustomersIn: customerBook.
	self assert: (customerBook includesCustomerNamed: 'Paul McCartney').
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'llk 4/12/2022 20:16:46'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook|
	
	customerBook := CustomerBook new.
	
	self addAndSuspendPaulMcCartneyTo: customerBook.
	
	customerBook removeCustomerNamed: 'Paul McCartney'.
	
	self noActiveAnd: 0 totalAndSuspendedCustomersIn: customerBook.
	self deny: (customerBook includesCustomerNamed: 'Paul McCartney').
	

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'llk 4/12/2022 19:55:42'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	[ customerBook suspendCustomerNamed: 'George Harrison'.
	self fail ]
		on: CantSuspend 
		do: [self johnLennonEsElUnicoEn: customerBook]



! !

!CustomerBookTest methodsFor: 'testing' stamp: 'llk 4/12/2022 19:55:05'!
test08CanNotSuspendAnAlreadySuspendedCustomer
| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	[ customerBook suspendCustomerNamed: johnLennon.
	self fail ]
		on: CantSuspend 
		do: [self johnLennonEsElUnicoEn: customerBook]
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
removeCustomerNamed: aName 
 
	1 to: active size do: 
	[ :index |
		aName = (active at: index)
			ifTrue: [
				active removeAt: index.
				^ aName 
			] 
	].

	1 to: suspended size do: 	
	[ :index |
		aName = (suspended at: index)
			ifTrue: [
				suspended removeAt: index.
				^ aName 
			] 
	].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/11/2022 07:18:12'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/11/2022 07:18:16'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
