!classDefinition: #I category: 'Numeros-Naturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Numeros-Naturales'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'next' stamp: 'ARM 3/31/2022 21:18:47'!
next

	^II! !


!I class methodsFor: 'operations' stamp: 'lk 4/4/2022 17:19:30'!
* aNatural

	^aNatural ! !

!I class methodsFor: 'operations' stamp: 'ARM 3/31/2022 21:19:14'!
+ aNatural

	^aNatural next! !

!I class methodsFor: 'operations' stamp: 'lk 4/4/2022 17:20:33'!
/ aNatural

	^I ! !

!I class methodsFor: 'operations' stamp: 'lk 4/4/2022 20:30:39'!
sustraeteDe: minuendo
^minuendo previous! !


!I class methodsFor: 'error' stamp: 'lk 4/10/2022 20:52:00'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor.'! !

!I class methodsFor: 'error' stamp: 'lk 4/10/2022 20:52:20'!
descripcionDeErrorDeNumerosNegativosNoSoportados 
	^'Numeros negativos no soportados.'! !


!classDefinition: #II category: 'Numeros-Naturales'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Numeros-Naturales'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'operaciones' stamp: 'lk 4/10/2022 20:49:19'!
* unNatural
	^unNatural + (self previous * unNatural).! !

!II class methodsFor: 'operaciones' stamp: 'lk 4/10/2022 20:49:15'!
+ unNatural
	^previous + unNatural next! !

!II class methodsFor: 'operaciones' stamp: 'lk 4/4/2022 20:28:16'!
- sustraendo
	^sustraendo sustraeteDe: self! !

!II class methodsFor: 'operaciones' stamp: 'lk 4/4/2022 20:48:57'!
/ unNatural
	
	self = unNatural ifTrue:[^I].
	unNatural = I ifTrue:[^self].
	^I + ((self - unNatural)/unNatural)! !

!II class methodsFor: 'operaciones' stamp: 'lk 4/4/2022 20:29:41'!
sustraeteDe: minuendo
	^minuendo previous - self previous! !


!II class methodsFor: 'error' stamp: 'lk 4/10/2022 20:44:13'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor.'! !

!II class methodsFor: 'error' stamp: 'lk 4/10/2022 20:43:45'!
descripcionDeErrorDeNumerosNegativosNoSoportados 
	^'Numeros negativos no soportados.'! !


!II class methodsFor: 'next & previous' stamp: 'lk 4/10/2022 20:47:57'!
nameOfNext
	(self name endsWith:'CMXCIX') ifTrue:[^(self name withoutSuffix:'CMXCIX'),'M'].
	(self name endsWith:'DCCCXCIX') ifTrue:[^(self name withoutSuffix:'DCCCXCIX'),'CM'].
	(self name endsWith:'CDXCIX') ifTrue:[^(self name withoutSuffix:'CDXCIX'),'D'].
	(self name endsWith:'CCCXCIX') ifTrue:[^(self name withoutSuffix:'CCCXCIX'),'CD'].
	(self name endsWith:'XCIX') ifTrue:[^(self name withoutSuffix:'XCIX'),'C'].
	(self name endsWith:'LXXXIX') ifTrue:[^(self name withoutSuffix:'LXXXIX'),'XC'].
	(self name endsWith:'XLIX') ifTrue:[^(self name withoutSuffix:'XLIX'),'L'].
	(self name endsWith:'XXXIX') ifTrue:[^(self name withoutSuffix:'XXXIX'),'XL'].
	(self name endsWith:'IX') ifTrue:[^(self name withoutSuffix:'IX'),'X'].
	(self name endsWith:'VIII') ifTrue:[^(self name withoutSuffix:'VIII'),'IX'].
	(self name endsWith:'IV') ifTrue:[^(self name withoutSuffix:'IV'),'V'].
	(self name endsWith:'III') ifTrue:[^(self name withoutSuffix:'III'),'IV'].
	^ self name , 'I'! !

!II class methodsFor: 'next & previous' stamp: 'lk 4/4/2022 20:53:21'!
next
	next ifNotNil:[^next].
	next _ II createChildNamed: self nameOfNext.
	next previous: self.
	^next! !

!II class methodsFor: 'next & previous' stamp: 'ARM 3/31/2022 21:26:45'!
previous

	^previous! !

!II class methodsFor: 'next & previous' stamp: 'ARM 3/31/2022 21:20:55'!
previous: unNatural 
	
	previous _ unNatural! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'lk 4/10/2022 20:54:31'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'Numeros-Naturales'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Numeros-Naturales'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'lk 4/10/2022 20:54:31'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IV.
	previous := II.! !


!classDefinition: #IV category: 'Numeros-Naturales'!
II subclass: #IV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IV class' category: 'Numeros-Naturales'!
IV class
	instanceVariableNames: ''!

!IV class methodsFor: '--** private fileout/in **--' stamp: 'lk 4/10/2022 20:54:31'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IV initializeAfterFileIn!