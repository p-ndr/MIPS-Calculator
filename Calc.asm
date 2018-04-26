#MIPS Calculator - Written by Nerwen Anariel - Version 1.0. Copyright Anariel Apps, 2018
.data
	#this data section contains the messages needed to interact with the user.
	message1: .asciiz "Hello! I am Calculator! Welcome!\nWhat would you like me to do for you?\nChoose from the list:)\nPress Enter to see the list."
	message2: .asciiz "1.Addition\n2.Subtraction\n3.Multiplication\n4.Division\n5.Factorial\n6.Power\n7.Exit"
	message3: .asciiz "Choose the number of numbers you want to add:"
	message4: .asciiz "Choose the number of numbers you want to multiplicate:"
	message5: .asciiz "Enter the number you want to have its power:"
	message6: .asciiz "Enter the power:"
	message7: .asciiz "Enter element:"
	message8: .asciiz "Result: "
	message9: .asciiz "Sorry I didn't understand your command. Please try again."
	message10: .asciiz "Alright then! Any other bussiness to do with me?\n1.Yes\n2.No"
	message11: .asciiz "Okay! Goodbye! See you later!"
	message12: .asciiz "Quotient: "
	message13: .asciiz "Remainder: "
.text
	main:
		li $v0, 55 #syscall 55 is the message dialog syscall
		la $a0, message1 #$a0 contains message to the user
		syscall
		j start
		
		exceptionHandler: #handles the invalid commands. For example null commands.
			li $v0, 55
			la $a0, message9
			syscall
			j start
		
		start:
			li $v0, 51 #syscall 55 is the int input dialog syscall
			la $a0, message2 #message to display to the user
			syscall
		
		move $t0, $a0
		
		ble $t0, 0, exceptionHandler
		beq $t0, 1, addition
		beq $t0, 2, subtraction
		beq $t0, 3, multiplication
		beq $t0, 4, division
		beq $t0, 5, factorial
		beq $t0, 6, power
		beq $t0, 7, exit
		bgt $t0, 7, exceptionHandler
		
		addition:
			li $v0, 51
			la $a0, message3
			syscall
			
			move $t0, $a0
			addi $t1, $zero, 0
			addi $s0, $zero, 0
			
			addfunc: #addition function
				bge $t1, $t0, addRes
				li $v0, 51
				la $a0, message7
				syscall
				move $t2, $a0
				add $s0, $s0, $t2
				addi $t1, $t1, 1
				j addfunc
				
			addRes:
				li $v0, 56
				la $a0, message8
				move $a1, $s0
				syscall
				j getOut1
				stuck1: #the program stucks here if the user gives invalid command.
					li $v0, 55
					la $a0, message9
					syscall
					j getOut1
				getOut1: #the getout functions, each with a different number, prepare the app to exit.
					jal setToZero
					li $v0, 51
					la $a0, message10
					syscall
					move $t0, $a0
					ble $t0, 0, stuck1
					beq $t0, 1, start
					beq $t0, 2, exit
					bgt $t0, 2, stuck1
				
		subtraction:
			addi $s0, $zero, 0
			li $v0, 51
			la $a0, message7
			syscall
			move $t0, $a0
			li $v0, 51
			la $a0, message7
			syscall
			move $t1, $a0
			sub $s0, $t0, $t1
			j subRes
			
			subRes:
				li $v0, 56
				la $a0, message8
				move $a1, $s0
				syscall
				j getOut2
				stuck2:
					li $v0, 55
					la $a0, message9
					syscall
					j getOut2
				getOut2:
					jal setToZero
					li $v0, 51
					la $a0, message10
					syscall
					move $t0, $a0
					ble $t0, 0, stuck2
					beq $t0, 1, start
					beq $t0, 2, exit
					bgt $t0, 2, stuck2
					
		multiplication:
			li $v0, 51
			la $a0, message4
			syscall
			
			move $t0, $a0
			addi $t1, $zero, 0
			addi $s0, $zero, 1
			
			multFunc:
				bge $t1, $t0, multRes
				li $v0, 51
				la $a0, message7
				syscall
				move $t2, $a0
				mul $s0, $s0, $t2
				addi $t1, $t1, 1
				j multFunc
				
			multRes:
				li $v0, 56
				la $a0, message8
				move $a1, $s0
				syscall
				j getOut3
				stuck3:
					li $v0, 55
					la $a0, message9
					syscall
					j getOut3
				getOut3:
					jal setToZero
					jal setToZero
					li $v0, 51
					la $a0, message10
					syscall
					move $t0, $a0
					ble $t0, 0, stuck3
					beq $t0, 1, start
					beq $t0, 2, exit
					bgt $t0, 2, stuck3
				
		division:
			addi $s0, $zero, 0
			addi $s0, $zero, 0
			li $v0, 51
			la $a0, message7
			syscall
			move $t0, $a0
			li $v0, 51
			la $a0, message7
			syscall
			move $t1, $a0
			div $t0, $t1
			mflo $s0
			mfhi $s1
			j divRes
			
			divRes:
				li $v0, 56
				la $a0, message12
				move $a1, $s0
				syscall
				la $a0, message13
				move $a1, $s1
				syscall
				j getOut4
				stuck4:
					li $v0, 55
					la $a0, message9
					syscall
					j getOut4
				getOut4:
					jal setToZero
					li $v0, 51
					la $a0, message10
					syscall
					move $t0, $a0
					ble $t0, 0, stuck4
					beq $t0, 1, start
					beq $t0, 2, exit
					bgt $t0, 2, stuck4
	
		factorial:
			li $v0, 51
			la $a0, message7
			syscall
			move $t0, $a0
			addi $t1, $zero, 2
			addi $s0, $zero, 1
			factFunc:
				bgt $t1, $t0, factRes
				mul $s0, $s0, $t1
				addi $t1, $t1, 1
				j factFunc
				
			factRes:
				li $v0, 56
				la $a0, message8
				move $a1, $s0
				syscall
				j getOut5
				stuck5:
					li $v0, 55
					la $a0, message9
					syscall
					j getOut5
				getOut5:
					jal setToZero
					li $v0, 51
					la $a0, message10
					syscall
					move $t0, $a0
					ble $t0, 0, stuck5
					beq $t0, 1, start
					beq $t0, 2, exit
					bgt $t0, 2, stuck5
					
		power:
			li $v0, 51
			la $a0, message5
			syscall
			move $t0, $a0
			li $v0, 51
			la $a0, message6
			syscall
			move $t1, $a0
			beq $t1, 0, powZero
			addi $t2, $zero, 0
			addi $s0, $zero, 1
			j powFunc
			powZero:
				addi $s0, $zero, 1
				li $v0, 56
				la $a0, message8
				move $a1, $s0
				syscall
				j getOut6
				stuck6:
					li $v0, 55
					la $a0, message9
					syscall
					j getOut6
				getOut6:
					jal setToZero
					li $v0, 51
					la $a0, message10
					syscall
					move $t0, $a0
					ble $t0, 0, stuck6
					beq $t0, 1, start
					beq $t0, 2, exit
					bgt $t0, 2, stuck6
			powFunc:
				bge $t2, $t1, powRes
				mul $s0, $s0, $t0
				addi $t2, $t2,1
				j powFunc
				
				powRes:
					li $v0, 56
					la $a0, message8
					move $a1, $s0
					syscall
					j getOut7
					stuck7:
						li $v0, 55
						la $a0, message9
						syscall
						j getOut6
					getOut7:
						jal setToZero
						li $v0, 51
						la $a0, message10
						syscall
						move $t0, $a0
						ble $t0, 0, stuck7
						beq $t0, 1, start
						beq $t0, 2, exit
						bgt $t0, 2, stuck7
			
		#This functions sets all the registers used to zero, in case they are needed again.
		setToZero:
			sub $t0, $t0, $t0
			sub $t1, $t1, $t1
			sub $t2, $t2, $t2
			sub $s0, $s0, $s0
			sub $s1, $s1, $s1
			jr $ra
			
		exit:
			li $v0, 55
			la $a0, message11
			syscall
			li $v0, 10 #exit syscall
			syscall

