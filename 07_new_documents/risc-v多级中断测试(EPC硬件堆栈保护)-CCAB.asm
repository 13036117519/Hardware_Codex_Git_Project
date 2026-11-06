.text
addi sp, zero, 2000       #内存堆栈初始化

#############################################################
#走马灯测?,测试addi,andi,slli,srli,srai,or,ori,nor,ecall  LED按走马灯方式来回显示数据
#############################################################
.text
START:

addi s0,zero,1 
slli s3, s0, 31      # s3=0x80000000
srai s3, s3, 31      # s3=0xFFFFFFFF   
add s0,zero,zero   # s0=0         
addi s2,zero,12 

addi s6,zero,8  #走马灯计数
zmd_loop:

addi s0, s0, 1    #计算下一个走马灯的数
andi s0, s0, 15  

#######################################
addi t0,zero,8    
addi t1,zero,1
left:

slli s3, s3, 4          #走马灯左移
or s3, s3, s0

add    a0,zero,s3       # display s3
addi   a7,zero,34       # system call for LED display 
ecall                   # display 

sub t0,t0,t1
bne t0,zero,left
#######################################

addi s0, s0, 1   #计算下一个走马灯的数
addi t6,zero,15
and s0, s0, t6
slli s0, s0, 28     

addi t0,zero,8
addi t1,zero,1

zmd_right:

srli s3, s3, 4  #走马灯右移
or s3, s3, s0

add    a0,zero,s3       # display s3
addi   a7,zero,34       # system call for LED display 
ecall                   # display 

sub t0,t0,t1
bne t0,zero,zmd_right
srli s0, s0, 28  
#######################################

sub s6,s6,t1
beq s6,zero, exit
j zmd_loop

exit:

add t0,zero,zero
xori t0,t0,-1      #test nor  ori
slli t0,t0,16
ori t0,t0,-1

add   a0,zero,t0       # display t0
addi   a7,zero,34      # system call for LED display 
ecall                   # display 

j START   # loop forever





 
InteruptProgram1:
#############################################################################################
#  exceptoin 1
#  使用?s6? s5?s4?s3?s0?a0?a7
#############################################################################################

################# 保护现场
sw a7, 0(sp)
addi sp, sp, 4
sw a0, 0(sp)
addi sp, sp, 4
sw s0, 0(sp)
addi sp, sp, 4
sw s3, 0(sp)
addi sp, sp, 4
sw s4, 0(sp)
addi sp, sp, 4
sw s5, 0(sp)
addi sp, sp, 4
sw s6, 0(sp)
addi sp, sp, 4


################# 开中断

csrrsi zero,0x4,1   #ustatus.MIE=1

################  中断服务

addi s6,zero,1       #中断?1,2,3   不同中断号显示值不一样
addi s4,zero,3       #循环次数初始值   
addi s5,zero,1       #计数器累加值

IntLoop1:
add s0,zero,s6   

IntLeftShift1:       


slli s0, s0, 4  
or s3,s0,s4
add    a0,zero,s3       #display s0
addi   a7,zero,34         # display hex
ecall                

bne s0, zero, IntLeftShift1
sub s4,s4,s5     #循环次数递减
bne s4, zero, IntLoop1

################  关中断

j CCAB_SLL  # 测试第 1 条 CCAB 指令，返回后关闭中断

CCAB_Return1:
################  恢复现场

addi sp, sp, -4
lw s6, 0(sp)
addi sp, sp, -4
lw s5, 0(sp)
addi sp, sp, -4
lw s4, 0(sp)
addi sp, sp, -4
lw s3, 0(sp)
addi sp, sp, -4
lw s0, 0(sp)
addi sp, sp, -4
lw a0, 0(sp)
addi sp, sp, -4
lw a7, 0(sp)
################  中断返回

uret              #同步开中断，uepc-->pc


InteruptProgram2:
#############################################################################################
#  exceptoin 2
#  使用?s6? s5?s4?s3?s0?a0?a7
#############################################################################################

################# 保护现场
sw a7, 0(sp)
addi sp, sp, 4
sw a0, 0(sp)
addi sp, sp, 4
sw s0, 0(sp)
addi sp, sp, 4
sw s3, 0(sp)
addi sp, sp, 4
sw s4, 0(sp)
addi sp, sp, 4
sw s5, 0(sp)
addi sp, sp, 4
sw s6, 0(sp)
addi sp, sp, 4

################# 开中断

csrrsi zero,0x4,1     #ustatus.MIE=1

################  中断服务


addi s6,zero,2       #中断?1,2,3   不同中断号显示值不一样
addi s4,zero,3       #循环次数初始值   
addi s5,zero,1       #计数器累加值

IntLoop2:
add s0,zero,s6   

IntLeftShift2:       


slli s0, s0, 4  
or s3,s0,s4
add    a0,zero,s3       #display s0
addi   a7,zero,34         # display hex
ecall                 # we are out of here.   

bne s0, zero, IntLeftShift2
sub s4,s4,s5      #循环次数递减
bne s4, zero, IntLoop2

################  关中断

j CCAB_SLTIU  # 测试第 2 条 CCAB 指令，返回后关闭中断

CCAB_Return2:
################  恢复现场
addi sp, sp, -4
lw s6, 0(sp)
addi sp, sp, -4
lw s5, 0(sp)
addi sp, sp, -4
lw s4, 0(sp)
addi sp, sp, -4
lw s3, 0(sp)
addi sp, sp, -4
lw s0, 0(sp)
addi sp, sp, -4
lw a0, 0(sp)
addi sp, sp, -4
lw a7, 0(sp)

################  中断返回

uret              #同步开中断，uepc-->pc

InteruptProgram3:
#############################################################################################
#  exceptoin 3
#  使用?s6? s5?s4?s3?s0?a0?a7
#############################################################################################

################# 保护现场
sw a7, 0(sp)
addi sp, sp, 4
sw a0, 0(sp)
addi sp, sp, 4
sw s0, 0(sp)
addi sp, sp, 4
sw s3, 0(sp)
addi sp, sp, 4
sw s4, 0(sp)
addi sp, sp, 4
sw s5, 0(sp)
addi sp, sp, 4
sw s6, 0(sp)
addi sp, sp, 4

################# 开中断

csrrsi zero,0x4,1   #ustatus.MIE=1

################  中断服务

addi s6,zero,3       #中断?1,2,3   不同中断号显示值不一样
addi s4,zero,3       #循环次数初始值   
addi s5,zero,1       #计数器累加值

IntLoop:
add s0,zero,s6   

IntLeftShift:       

slli s0, s0, 4  
or s3,s0,s4
add    a0,zero,s3       #display s0
addi   a7,zero,34         # display hex
ecall                 # we are out of here.   

bne s0, zero, IntLeftShift
sub s4,s4,s5    #循环次数递减
bne s4, zero, IntLoop

################  关中断

j CCAB_SB  # 测试第 3 条 CCAB 指令，返回后关闭中断

CCAB_Return3:
################  恢复现场

addi sp, sp, -4
lw s6, 0(sp)
addi sp, sp, -4
lw s5, 0(sp)
addi sp, sp, -4
lw s4, 0(sp)
addi sp, sp, -4
lw s3, 0(sp)
addi sp, sp, -4
lw s0, 0(sp)
addi sp, sp, -4
lw a0, 0(sp)
addi sp, sp, -4
lw a7, 0(sp)

################  中断返回

uret              #同步开中断，uepc-->pc

#############################################################
# CCAB 专项测试：各 ISR 显示循环结束后进入对应测试，完成后恢复现场并 uret。
# 以下例程放在三个 ISR 后面，保持 InteruptProgram1/2/3 入口地址不变。
# 测试仅复用 ISR 入口已经压栈的通用寄存器；不改变原 ISR 栈布局。
#############################################################

CCAB_SLL:
# SLL.asm：先输出 0x876，随后每次左移 4 位，共输出 9 个值。
addi s5, zero, 1
addi s6, zero, 3
addi s0, zero, 0x8
slli s0, s0, 8
addi s0, s0, 0x76
add a0, zero, s0
addi a7, zero, 34
ecall
addi s4, zero, 8
CCAB_SLL_Loop:
sll s0, s0, s5
sll s0, s0, s6
add a0, zero, s0
addi a7, zero, 34
ecall
addi s4, s4, -1
bne s4, zero, CCAB_SLL_Loop

csrrci zero, 0x4, 1  # 恢复现场前关中断
j CCAB_Return1

CCAB_SLTIU:
# SLTIU.asm：从 0x1997 到 0x1949；以无符号比较判断结束。
addi s5, zero, -1
addi s6, zero, 0
addi s0, zero, 0x19
slli s0, s0, 8
addi s4, zero, 0x97
CCAB_SLTIU_Loop:
add a0, s0, s4
addi a7, zero, 34
ecall
add s4, s4, s5
sltiu s6, s4, 0x49
beq s6, zero, CCAB_SLTIU_Loop

csrrci zero, 0x4, 1  # 恢复现场前关中断
j CCAB_Return2

CCAB_SB:
# SB.asm：在数据内存 0..31 逐字节写入并显示，再读回 8 个字。
# ISR 栈从 2000 起，此处的测试数据不会覆盖栈。
addi s0, zero, 0
addi s4, zero, 32
addi s5, zero, 0
addi s6, zero, 1
CCAB_SB_Store:
sb s5, 0(s0)
add a0, zero, s5
addi a7, zero, 34
ecall
add s5, s5, s6
addi s0, s0, 1
addi s4, s4, -1
bne s4, zero, CCAB_SB_Store
addi s4, zero, 8
addi s0, zero, 0
CCAB_SB_Read:
lw s5, 0(s0)
add a0, zero, s5
addi a7, zero, 34
ecall
addi s0, s0, 4
addi s4, s4, -1
bne s4, zero, CCAB_SB_Read

csrrci zero, 0x4, 1  # 恢复现场前关中断
j CCAB_Return3
