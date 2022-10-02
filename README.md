CALCULATOR-USING-ASSEMBLY-LANG

We aim to make a calculator by using 8086 microprocessor in which we will use different functions, commands or subroutines. It will help us to solve our problems.
It will help us to solve problems with large input values, it reduces our time by helping us add, subtract, multiply and divide large values. and get their solutions
in no time.

MECHANISM:

We have designed a calculator which consists of Lower halves of the 32-bit registers as four 16-bit data registers: AX, BX, CX and DX and higher halves of the above-mentioned four 16-bit registers as eight 8-bit data registers: AH, AL,. It can take up to 4-digits as input and we have used cmp and je (compare and jump instruction) to see if the value is equal or not and we have used different procedures for input that will initialize bx and dx and then it will take input from the user and will compare it with 0dh and if its equal then it will jump to formno for the formation of the number and  then view, to view the number that was formed and viewno to display the value on screen. Our calculator performs the following operations:

•	Addition (+): first we will display menu which consist of mathematical operations and then we will take input from the user in which he will on of those mathematical operations from the menu and then we will compare the input value by using cmp with 31h,32h ...etc, and then will jump to the required operation. It takes two numbers as input, and will store them in register and it will perform addition on them.

•	Subtraction (-): By choosing the required operation, it will jump to subtraction and then it will takes two numbers as input, performs subtraction.

•	Multiplication (*): By choosing the required operation, it will jump to multiplication  and then it will takes two numbers as input, performs multiplication.

•	Division (/): By choosing the required operation, it will jump to division and then it will takes two numbers as input, performs division.

→ if we press 1 then, addition on the input values will be performed.

 
![image](https://user-images.githubusercontent.com/92535518/193444162-87f0f2ef-4802-447e-9975-01ef96dc0ada.png)


→ if we press 2 then, subtraction on the input values will be performed.

![image](https://user-images.githubusercontent.com/92535518/193444180-4edf5c09-37d4-49d9-83dc-ec19f28a1d5e.png)

→ if we press 3 then, multiplication on the input values will be performed.

![image](https://user-images.githubusercontent.com/92535518/193444202-e58548ad-6921-49fd-a591-55f2c31da6b7.png)

→ if we press 4 then, division on the input values will be performed.

![image](https://user-images.githubusercontent.com/92535518/193444229-8b60260b-cde1-4793-8303-2078dff9341f.png)


→ if we press any other key then, it will generate a message which will display “wrong choice”.

![image](https://user-images.githubusercontent.com/92535518/193444243-36cf4ae6-f206-4973-88b3-75c94078c51b.png)

CODE FILE:

[CALC CODE.txt](https://github.com/zahrahamdani/CALCULATOR-USING-ASSEMBLY-LANG/files/9692037/CALC.CODE.txt)


