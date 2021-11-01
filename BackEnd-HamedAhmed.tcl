set fp [open "input.txt"]

set counter 0


#Global Variables
set IntegerFirstOuccuring 2
set IntegerSummation 0
set StringFirstOuccuring 3
set ConcatenationOfStringLines ""
set StringLineNo 0
set OddLineNo 0
set EvenLineNo 0
set InvalidLineNo 0
set MaximumIntegerValue 0
#set initial value to 80000 character
set MinLenForStringLine  80000
set StringLine ""
#Methods/Procedures

#Check if the Line is Invalid or not
proc LineStartWithStringChar {line} {
 set FirstCharacter  [string range  $line 0 0]   
   #check if the Line start with String Character
    #if it's not digit or speace then it's a String Character
     if {[string is digit $FirstCharacter]} {
        set ::InvalidLineNo [expr {$::InvalidLineNo + 1}]
        return "INVALID LINE"
        } elseif  {[string is space $FirstCharacter]}  {
          set ::InvalidLineNo [expr {$::InvalidLineNo + 1}]
         return "INVALID LINE"
        } else {
          set ::StringLineNo [expr {$::StringLineNo + 1}]
          LineConcate $line
          LineWithMinStringLeng $line
         return $line
        }
}

#check if the Number is Even or not
proc isEven {num} { 
 return [ expr $num % 2 ] 
}


#apply Change on Even and Odd Integers
proc LinePresentOddEven {num} {
 if {1 != [isEven $num]} {
          #if  Even
             set ::EvenLineNo [expr {$::EvenLineNo + 1}]
         return [expr $num * 3.25]
       } else {
         #else odd
            set ::OddLineNo [expr {$::OddLineNo + 1}]
         return [expr $num / 2.0]
     }
}

#Sumation of first Occuring Integers
proc sumOfInteger {num} {
   if { 0 != $::IntegerFirstOuccuring} {
          set ::IntegerSummation [expr {$::IntegerSummation + $num}]
          set ::IntegerFirstOuccuring [expr {$::IntegerFirstOuccuring - 1}]
      }

}

#Concatenation of the Lines 
proc LineConcate {line} {
  if { 0 != $::StringFirstOuccuring} {
          set ::ConcatenationOfStringLines [concat $::ConcatenationOfStringLines$line]
          set ::StringFirstOuccuring [expr {$::StringFirstOuccuring - 1}]
      }
}

#Print All Lines with the Length of each Line
proc PrintAllLineWithLen {} {
  set newFp [open "input.txt"]

  while {-1 != [gets $newFp line]} {

    set LineLength [string length $line]
    puts "The Length is: $LineLength  , the Content of the Line : $line"

 }

 close $newFp
}

#Get the maximum Integer Value Line
proc LineWithMaximumIntegerValue {num} {
  if { $num > $::MaximumIntegerValue } {
      set ::MaximumIntegerValue $num
  } 
}

#Get the String Line with Minimum Length
proc  LineWithMinStringLeng {line} {
  set currentLength [string length $line]
  if { 0 != $currentLength } {
    if { $currentLength < $::MinLenForStringLine } { 
      set ::MinLenForStringLine $currentLength
      set ::StringLine $line
      
    }
  }
}
#reports 
proc Reports {} {

  puts "Numbers of String Lines : $::StringLineNo"
  puts "Numbers of Odd Integers Lines : $::OddLineNo "
  puts "Numbers of Even Itnegers Lines : $::EvenLineNo"
   puts "Numbers of Inalid Lines : $::InvalidLineNo"


}

#Main Code
while {-1 != [gets $fp line]} {
  
   if {[string is integer $line]} {
      #Integer Number
      puts [LinePresentOddEven $line] 

      #summation of the  first 2 integer values occurring in the file
        sumOfInteger $line

      #Call Maximum Integer Value Proc
      LineWithMaximumIntegerValue $line
     
   } elseif  {[string is double $line]}  {
     #Float
         set ::StringLineNo [expr {$::StringLineNo + 1}]
          LineWithMinStringLeng $line
         puts $line
   } else {
       #everything else
     puts [LineStartWithStringChar $line]
   }
    
}

puts "*-----------------------------------------------"
puts "Summation of First 2 integer values occurring in the file : $IntegerSummation"
puts "concatenation of the First 3 lines starting with String Characters : $ConcatenationOfStringLines"

puts "*-----------------------------------------------"
PrintAllLineWithLen
puts "*------------------Maximum Integer Value amd the minimum Length of Non Empty String-----------------------------"

puts "Line with Maximum Integer Value is : $MaximumIntegerValue"

puts "Line with Minimum String Length is : $StringLine"
puts "*------------------Reports-----------------------------"
Reports

close $fp