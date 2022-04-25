!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'aux' stamp: 'lk 4/24/2022 18:39:12'!
ifAnErrorRisesIn: block assertErrorTo: errorToCompare 

	self 
		should: block
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: errorToCompare ]
	! !


!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'lk 4/24/2022 18:26:02'!
test08FraccionAddsWithFraccionCorrectly

	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'lk 4/24/2022 18:26:09'!
test09FraccionMultipliesWithFraccionCorrectly

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'lk 4/24/2022 18:26:15'!
test10FraccionDividesFraccionCorrectly

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'lk 4/24/2022 18:26:21'!
test11EnteroAddsFraccionCorrectly

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'lk 4/24/2022 18:41:39'!
test23CanNotDivideEnteroByZero

	self ifAnErrorRisesIn:  [ one / zero ] assertErrorTo: (Numero canNotDivideByZeroErrorDescription).
	! !

!NumeroTest methodsFor: 'tests' stamp: 'lk 4/24/2022 18:41:07'!
test24CanNotDivideFraccionByZero

	self ifAnErrorRisesIn:  [ oneHalf / zero ] assertErrorTo: (Numero canNotDivideByZeroErrorDescription)
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 4/15/2021 16:45:35'!
test27EnteroSubstractsEnteroCorrectly

	self assert: four - one equals: three! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'lk 4/24/2022 18:41:48'!
test38FibonacciNotDefinedForNegativeNumbers
	
	self ifAnErrorRisesIn: [negativeOne fibonacci] assertErrorTo: (Entero negativeFibonacciErrorDescription).! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'lk 4/24/2022 20:03:13'!
= anObject

	^self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'lk 4/24/2022 20:02:26'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:02'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:09'!
invalidNumberTypeErrorDescription
	
	^ 'Tipo de número inválido!!!!!!'! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic auxiliary operations' stamp: 'lk 4/24/2022 18:58:08'!
addFraction: aFraction

	^ (aFraction numerator + (aFraction denominator * self)) / aFraction denominator.
	
	! !

!Entero methodsFor: 'arithmetic auxiliary operations' stamp: 'lk 4/24/2022 19:11:12'!
addInteger: anInteger

	^ Entero with: (value + (anInteger integerValue))! !

!Entero methodsFor: 'arithmetic auxiliary operations' stamp: 'lk 4/24/2022 18:57:51'!
divideAFraction: aFraction

	^ (aFraction numerator ) / (aFraction denominator  * self) ! !

!Entero methodsFor: 'arithmetic auxiliary operations' stamp: 'lk 4/24/2022 19:12:24'!
divideAnInteger: anInteger
	
	^ Fraccion with: anInteger over: self.
	! !

!Entero methodsFor: 'arithmetic auxiliary operations' stamp: 'lk 4/24/2022 18:57:40'!
multiplyByFraction: aFraction

	^ aFraction numerator * self / aFraction denominator.
	
	! !

!Entero methodsFor: 'arithmetic auxiliary operations' stamp: 'lk 4/24/2022 19:10:50'!
multiplyByInteger: anInteger
	
	^ Entero with: value * anInteger integerValue
	! !

!Entero methodsFor: 'arithmetic auxiliary operations' stamp: 'lk 4/24/2022 19:11:49'!
substractFromFraction: aFraction

	^ (aFraction numerator - (self * aFraction denominator)) / aFraction denominator.
! !

!Entero methodsFor: 'arithmetic auxiliary operations' stamp: 'lk 4/24/2022 18:18:37'!
substractFromInteger: anInteger 
	
	^ Entero with: (anInteger integerValue - value).! !


!Entero methodsFor: 'arithmetic operations' stamp: 'lk 4/24/2022 19:14:34'!
* aMultiplier 
	
	^ aMultiplier multiplyByInteger: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'lk 4/24/2022 19:13:11'!
+ anAdder 

	^ anAdder addInteger: self
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'lk 4/24/2022 18:07:37'!
- aSubtrahend 
	
	^ aSubtrahend substractFromInteger: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'lk 4/24/2022 19:13:22'!
/ aDivisor 
	
	^ aDivisor divideAnInteger: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'lk 4/24/2022 19:14:41'!
// aDivisor 
	
	^ Entero with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'lk 4/24/2022 20:29:03'!
fibonacci

	self subClassResponsability.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'lk 4/24/2022 19:14:47'!
greatestCommonDivisorWith: anEntero 
	
	^ self class with: (value gcd: anEntero integerValue)! !


!Entero methodsFor: 'comparing' stamp: 'lk 4/24/2022 19:31:21'!
= anObject

	^ (anObject isKindOf: Entero) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'lk 4/24/2022 19:31:15'!
hash

	^ value hash! !


!Entero methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 20:09'!
initalizeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'value' stamp: 'lk 4/24/2022 19:31:34'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^ value! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'lk 4/24/2022 20:57:43'!
isAValidNumerator
	self subClassResponsability.! !

!Entero methodsFor: 'testing' stamp: 'lk 4/24/2022 19:14:19'!
isNegative
	
	^ value < 0! !

!Entero methodsFor: 'testing' stamp: 'lk 4/24/2022 19:14:23'!
isOne
	
	^ value = 1! !

!Entero methodsFor: 'testing' stamp: 'lk 4/24/2022 19:14:26'!
isZero
	
	^ value = 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/15/2021 16:42:24'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos!!!!!!'! !

!Entero class methodsFor: 'instance creation' stamp: 'lk 4/24/2022 20:40:53'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	(aValue < 0) ifTrue: 	[^ EnteroNegativo with: aValue].
	(aValue = 0)  ifTrue: 	[^ EnteroCero with: aValue].
	(aValue = 1) ifTrue: [^ EnteroUno with: aValue].
	
	^ EnteroPositivoSinUno with: aValue! !


!classDefinition: #EnteroCero category: 'Numero-Exercise'!
Entero subclass: #EnteroCero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroCero methodsFor: 'testing' stamp: 'lk 4/24/2022 21:02:37'!
isAValidDenominator
		! !

!EnteroCero methodsFor: 'testing' stamp: 'lk 4/24/2022 21:01:25'!
isAValidNumerator
	 self error: 'una fraccion no puede ser cero' ! !


!EnteroCero methodsFor: 'arithmetic operations' stamp: 'lk 4/24/2022 20:41:53'!
fibonacci

	^ Entero with: 1.
	
		! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroCero class' category: 'Numero-Exercise'!
EnteroCero class
	instanceVariableNames: ''!

!EnteroCero class methodsFor: 'as yet unclassified' stamp: 'lk 4/24/2022 20:45:22'!
with: anUselessNumber
	
	^self new initalizeWith: 0! !


!classDefinition: #EnteroNegativo category: 'Numero-Exercise'!
Entero subclass: #EnteroNegativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroNegativo methodsFor: 'arithmetic operations' stamp: 'lk 4/24/2022 20:10:19'!
fibonacci

	self error: Entero negativeFibonacciErrorDescription ! !


!EnteroNegativo methodsFor: 'testing' stamp: 'lk 4/24/2022 21:02:31'!
isAValidDenominator! !

!EnteroNegativo methodsFor: 'testing' stamp: 'lk 4/24/2022 21:00:34'!
isAValidNumerator! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroNegativo class' category: 'Numero-Exercise'!
EnteroNegativo class
	instanceVariableNames: ''!

!EnteroNegativo class methodsFor: 'as yet unclassified' stamp: 'lk 4/24/2022 20:19:18'!
with: aValue 
	
	^self new initalizeWith: aValue! !


!classDefinition: #EnteroPositivoSinUno category: 'Numero-Exercise'!
Entero subclass: #EnteroPositivoSinUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroPositivoSinUno methodsFor: 'testing' stamp: 'lk 4/24/2022 21:02:26'!
isAValidDenominator! !

!EnteroPositivoSinUno methodsFor: 'testing' stamp: 'lk 4/24/2022 21:00:46'!
isAValidNumerator
! !


!EnteroPositivoSinUno methodsFor: 'arithmetic operations' stamp: 'lk 4/24/2022 20:11:06'!
fibonacci

	| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
	
	^ (self - one) fibonacci + (self - two) fibonacci
		! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroPositivoSinUno class' category: 'Numero-Exercise'!
EnteroPositivoSinUno class
	instanceVariableNames: ''!

!EnteroPositivoSinUno class methodsFor: 'as yet unclassified' stamp: 'lk 4/24/2022 20:19:36'!
with: aValue 
	
	^self new initalizeWith: aValue! !


!classDefinition: #EnteroUno category: 'Numero-Exercise'!
Entero subclass: #EnteroUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroUno methodsFor: 'testing' stamp: 'lk 4/24/2022 21:04:10'!
isAValidDenominator
	self error: 'una fraccion no puede tener denominador 1 porque sino es un entero'! !

!EnteroUno methodsFor: 'testing' stamp: 'lk 4/24/2022 21:00:54'!
isAValidNumerator! !


!EnteroUno methodsFor: 'arithmetic operations' stamp: 'lk 4/24/2022 20:42:05'!
fibonacci

	^ Entero with: 1.
	
		! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroUno class' category: 'Numero-Exercise'!
EnteroUno class
	instanceVariableNames: ''!

!EnteroUno class methodsFor: 'as yet unclassified' stamp: 'lk 4/24/2022 20:45:11'!
with: anUselessNumber
	
	^self new initalizeWith: 1! !


!classDefinition: #Fraccion category: 'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic auxiliary operations' stamp: 'lk 4/24/2022 19:09:58'!
addFraction: aFraction

	^ ((numerator * aFraction denominator) + (denominator * aFraction numerator)) / (denominator * aFraction denominator).! !

!Fraccion methodsFor: 'arithmetic auxiliary operations' stamp: 'lk 4/24/2022 19:36:12'!
addInteger: anInteger

	^ (numerator + (denominator * anInteger )) / denominator.
	
	! !

!Fraccion methodsFor: 'arithmetic auxiliary operations' stamp: 'lk 4/24/2022 19:04:37'!
divideAFraction: aFraction
	
	^ (denominator *aFraction numerator) / (numerator * aFraction denominator)! !

!Fraccion methodsFor: 'arithmetic auxiliary operations' stamp: 'lk 4/24/2022 19:04:58'!
divideAnInteger: anInteger

	^ (anInteger * denominator) / (numerator)! !

!Fraccion methodsFor: 'arithmetic auxiliary operations' stamp: 'lk 4/24/2022 19:02:13'!
multiplyByFraction: aFraction

	^ (numerator * aFraction numerator) / (denominator * aFraction denominator)
	! !

!Fraccion methodsFor: 'arithmetic auxiliary operations' stamp: 'lk 4/24/2022 19:09:51'!
multiplyByInteger: anInteger

	^ (numerator * anInteger) / denominator.
	
	! !

!Fraccion methodsFor: 'arithmetic auxiliary operations' stamp: 'lk 4/24/2022 19:09:45'!
substractFromFraction: aFraction

	^ ((aFraction numerator * denominator) - (aFraction denominator *  numerator)) / (aFraction denominator *  denominator).
! !

!Fraccion methodsFor: 'arithmetic auxiliary operations' stamp: 'lk 4/24/2022 19:09:34'!
substractFromInteger: anInteger
	
	^ (anInteger * denominator) - (numerator) / denominator.! !


!Fraccion methodsFor: 'arithmetic operations' stamp: 'lk 4/24/2022 16:21:22'!
* aMultiplier 
	
	^aMultiplier multiplyByFraction: self.
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'lk 4/24/2022 16:12:22'!
+ anAdder 
	
	^ anAdder addFraction: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'lk 4/24/2022 18:17:38'!
- aSubtrahend 
	
	^ aSubtrahend substractFromFraction: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'lk 4/24/2022 19:35:49'!
/ aDivisor 
	
	^ aDivisor divideAFraction: self.! !


!Fraccion methodsFor: 'comparing' stamp: 'lk 4/24/2022 19:35:57'!
= anObject

	^ (anObject isKindOf: Fraccion) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'lk 4/24/2022 19:33:29'!
hash

	^ (numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'lk 4/24/2022 21:05:02'!
initializeWith: aNumerator over: aDenominator

	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'NR 9/23/2018 23:45:19'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue:[ ^aDividend negated / aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator
	! !
