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
addi x0,x0,0   # 走马灯移到例程中，这里保持 ISR 长度
addi x0,x0,0
addi x0,x0,0
addi x0,x0,0
addi x0,x0,0
addi x0,x0,0
addi x0,x0,0
addi x0,x0,0
addi x0,x0,0
addi x0,x0,0
addi x0,x0,0
addi x0,x0,0
csrrci zero,0x4,1  #ustatus.MIE=0

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

j CCAB_SRA  # ISR 长度保持不变


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
addi x0,x0,0   # 走马灯移到例程中，这里保持 ISR 长度
addi x0,x0,0
addi x0,x0,0
addi x0,x0,0
addi x0,x0,0
addi x0,x0,0
addi x0,x0,0
addi x0,x0,0
addi x0,x0,0
addi x0,x0,0
addi x0,x0,0
addi x0,x0,0
csrrci zero,0x4,1  #ustatus.MIE=0

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

j CCAB_LH  # ISR 长度保持不变

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
addi x0,x0,0   # 走马灯移到例程中，这里保持 ISR 长度
addi x0,x0,0
addi x0,x0,0
addi x0,x0,0
addi x0,x0,0
addi x0,x0,0
addi x0,x0,0
addi x0,x0,0
addi x0,x0,0
addi x0,x0,0
addi x0,x0,0
addi x0,x0,0
csrrci zero,0x4,1  #ustatus.MIE=0

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

j CCAB_BGE  # ISR 长度保持不变
#############################################################
# v4：走马灯移到各测试例程中，保证无论从 ISR 头/尾/0x2B0
# 进入，都先执行 3 轮走马灯，再执行对应差分指令测试。
# ISR 仍各 43 条，入口 0x0AC/0x158/0x204 不变。
#############################################################

CCAB_BGE:
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
csrrsi zero,0x4,1
addi s6,zero,3
addi s4,zero,3
addi s5,zero,1
M3_Loop:
add s0,zero,s6
M3_Shift:
slli s0,s0,4
or s3,s0,s4
add a0,zero,s3
addi a7,zero,34
ecall
bne s0,zero,M3_Shift
sub s4,s4,s5
bne s4,zero,M3_Loop
csrrci zero,0x4,1
# BGE：15 递减到 0，共 16 个值
addi s4, zero, 15
CCAB_BGE_Loop:
add a0, zero, s4
addi a7, zero, 34
ecall
addi s4, s4, -1
bge s4, zero, CCAB_BGE_Loop

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
uret


CCAB_SRA:
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
csrrsi zero,0x4,1
addi s6,zero,1
addi s4,zero,3
addi s5,zero,1
M1_Loop:
add s0,zero,s6
M1_Shift:
slli s0,s0,4
or s3,s0,s4
add a0,zero,s3
addi a7,zero,34
ecall
bne s0,zero,M1_Shift
sub s4,s4,s5
bne s4,zero,M1_Loop
csrrci zero,0x4,1
# SRA：0x87600000，每次右移 1+3=4 位，共 9 个值
addi s5, zero, 1
addi s6, zero, 3
addi s0, zero, 0x8
slli s0, s0, 8
addi s0, s0, 0x76
slli s0, s0, 20
add a0, zero, s0
addi a7, zero, 34
ecall
addi s4, zero, 8
CCAB_SRA_Loop:
sra s0, s0, s5
sra s0, s0, s6
add a0, zero, s0
addi a7, zero, 34
ecall
addi s4, s4, -1
bne s4, zero, CCAB_SRA_Loop

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
uret


CCAB_LH:
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
csrrsi zero,0x4,1
addi s6,zero,2
addi s4,zero,3
addi s5,zero,1
M2_Loop:
add s0,zero,s6
M2_Shift:
slli s0,s0,4
or s3,s0,s4
add a0,zero,s3
addi a7,zero,34
ecall
bne s0,zero,M2_Shift
sub s4,s4,s5
bne s4,zero,M2_Loop
csrrci zero,0x4,1
# LH：写 16 个字，再按半字读回 32 个，符号扩展输出
addi s0, zero, 0
addi s4, zero, 16
addi s5, zero, 0x84
slli s5, s5, 8
addi s5, s5, 0x83
addi s6, zero, 0x04
slli s6, s6, 8
addi s6, s6, 0x04
slli s5, s5, 8
addi s5, s5, 0x82
slli s5, s5, 8
addi s5, s5, 0x81
slli s6, s6, 8
addi s6, s6, 0x04
slli s6, s6, 8
addi s6, s6, 0x04
CCAB_LH_Store:
sw s5, 0(s0)
add s5, s5, s6
addi s0, s0, 4
addi s4, s4, -1
bne s4, zero, CCAB_LH_Store
addi s4, zero, 32
addi s0, zero, 0
CCAB_LH_Read:
lh s5, 0(s0)
add a0, zero, s5
addi a7, zero, 34
ecall
addi s0, s0, 2
addi s4, s4, -1
bne s4, zero, CCAB_LH_Read

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
uret

