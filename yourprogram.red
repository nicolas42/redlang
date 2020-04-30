Red [needs: view]

comment {
	; compile
	red -c yourprogram.red 

	Best Documentation
	http://helpin.red/Homepage.html

	Official Docs (pretty dry)
	https://doc.red-lang.org/en/

	GUI Examples
	http://www.mycode4fun.co.uk/About-Red-Programming
}



calc: func [
	{Takes a string like "4*3+8" and returns the answer}
	str
	/local digit non-digit out mark p1 p2 it
][
	digit:   charset "0123456789."
	non-digit: complement digit
	out: copy []
	parse str [any [to {^^} mark: {^^} (change/part mark "**" 1) ] ]
	parse str [
		some [
			copy it some digit (append out it) 
			opt ["." copy it some digit (append last out "." append last out it)]	
			opt [p1: "E" opt ["+" | "-"] some digit p2: (append last out copy/part p1 p2)]
			| copy it some non-digit (append out it)
		]
	]
	forall out [change out load first out]
	forall out [if number? first out [change out to-float first out]]
	do head out
]

factorial: func [f /local a ] [
	a: 1 ;accumulator
	repeat i f [ a: a * i ]
	a
]

total: sum: func [b] [t: 0 foreach i b [t: t + i]]
average: avg: func [b] [divide sum b length? b]





f1: context [
	font-size: 20
	text: {The quick brown fox jumped over the 
	lazy dog.  This is the type of thing
	which is quite good isn't it.  Yes definitely.  I like these kinds of things now 
	these are the kinds of things that we all like to hear and see.

	What are the kinds of things that we all like to do now.

	}
]

win: layout compose/deep [ 
    area font [ size: (f1/font-size) ] (f1/text)
	button "push me" [ quit ] 
]

f: win/pane
f/1/offset: 0x0

insert-event-func func [face [object!] event [event!]] [ 
	if event/type = 'resize [ 
		win/pane/1/size: win/size
		print "resize"
	 ]
	; probe event/type 
	event 
]

view/flags win [ resize ] 
