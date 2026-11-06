.text
addi sp, zero, 2000       #鍐呭瓨鍫嗘爤鍒濆?嬪寲

#############################################################
#璧伴┈鐏?娴??,娴嬭瘯addi,andi,slli,srli,srai,or,ori,nor,ecall  LED鎸夎蛋椹?鐏?鏂瑰紡鏉ュ洖鏄剧ず鏁版嵁
#############################################################
.text
START:

addi s0,zero,1 
slli s3, s0, 31      # s3=0x80000000
srai s3, s3, 31      # s3=0xFFFFFFFF   
add s0,zero,zero   # s0=0         
addi s2,zero,12 

addi s6,zero,8  #璧伴┈鐏?璁℃暟
zmd_loop:

addi s0, s0, 1    #璁＄畻涓嬩竴涓?璧伴┈鐏?鐨勬暟
andi s0, s0, 15  

#######################################
addi t0,zero,8    
addi t1,zero,1
left:

slli s3, s3, 4          #璧伴┈鐏?宸︾Щ
or s3, s3, s0

add    a0,zero,s3       # display s3
addi   a7,zero,34       # system call for LED display 
ecall                   # display 

sub t0,t0,t1
bne t0,zero,left
#######################################

addi s0, s0, 1   #璁＄畻涓嬩竴涓?璧伴┈鐏?鐨勬暟
addi t6,zero,15
and s0, s0, t6
slli s0, s0, 28     

addi t0,zero,8
addi t1,zero,1

zmd_right:

srli s3, s3, 4  #璧伴┈鐏?鍙崇Щ
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
#  浣跨敤?s6? s5?s4?s3?s0?a0?a7
#############################################################################################

################# 淇濇姢鐜板満
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


################# 寮?涓?鏂?

csrrsi zero,0x4,1   #ustatus.MIE=1

################  涓?鏂?鏈嶅姟

addi s6,zero,1       #涓?鏂??1,2,3   涓嶅悓涓?鏂?鍙锋樉绀哄?间笉涓?鏍?
addi s4,zero,3       #寰?鐜?娆℃暟鍒濆?嬪??   
addi s5,zero,1       #璁℃暟鍣ㄧ疮鍔犲??

IntLoop1:
add s0,zero,s6   

IntLeftShift1:       


slli s0, s0, 4  
or s3,s0,s4
add    a0,zero,s3       #display s0
addi   a7,zero,34         # display hex
ecall                

bne s0, zero, IntLeftShift1
sub s4,s4,s5     #寰?鐜?娆℃暟閫掑噺
bne s4, zero, IntLoop1

################  鍏充腑鏂?

csrrci zero,0x4,1  #ustatus.MIE=0

################  鎭㈠?嶇幇鍦?

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
################  涓?鏂?杩斿洖

j CCAB_SRA  # 保持 ISR 仍为 43 条指令


InteruptProgram2:
#############################################################################################
#  exceptoin 2
#  浣跨敤?s6? s5?s4?s3?s0?a0?a7
#############################################################################################

################# 淇濇姢鐜板満
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

################# 寮?涓?鏂?

csrrsi zero,0x4,1     #ustatus.MIE=1

################  涓?鏂?鏈嶅姟


addi s6,zero,2       #涓?鏂??1,2,3   涓嶅悓涓?鏂?鍙锋樉绀哄?间笉涓?鏍?
addi s4,zero,3       #寰?鐜?娆℃暟鍒濆?嬪??   
addi s5,zero,1       #璁℃暟鍣ㄧ疮鍔犲??

IntLoop2:
add s0,zero,s6   

IntLeftShift2:       


slli s0, s0, 4  
or s3,s0,s4
add    a0,zero,s3       #display s0
addi   a7,zero,34         # display hex
ecall                 # we are out of here.   

bne s0, zero, IntLeftShift2
sub s4,s4,s5      #寰?鐜?娆℃暟閫掑噺
bne s4, zero, IntLoop2

################  鍏充腑鏂?

csrrci zero,0x4,1  #ustatus.MIE=0

################  鎭㈠?嶇幇鍦?
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

################  涓?鏂?杩斿洖

j CCAB_LH  # 保持 ISR 仍为 43 条指令

InteruptProgram3:
#############################################################################################
#  exceptoin 3
#  浣跨敤?s6? s5?s4?s3?s0?a0?a7
#############################################################################################

################# 淇濇姢鐜板満
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

################# 寮?涓?鏂?

csrrsi zero,0x4,1   #ustatus.MIE=1

################  涓?鏂?鏈嶅姟

addi s6,zero,3       #涓?鏂??1,2,3   涓嶅悓涓?鏂?鍙锋樉绀哄?间笉涓?鏍?
addi s4,zero,3       #寰?鐜?娆℃暟鍒濆?嬪??   
addi s5,zero,1       #璁℃暟鍣ㄧ疮鍔犲??

IntLoop:
add s0,zero,s6   

IntLeftShift:       

slli s0, s0, 4  
or s3,s0,s4
add    a0,zero,s3       #display s0
addi   a7,zero,34         # display hex
ecall                 # we are out of here.   

bne s0, zero, IntLeftShift
sub s4,s4,s5    #寰?鐜?娆℃暟閫掑噺
bne s4, zero, IntLoop

################  鍏充腑鏂?

csrrci zero,0x4,1  #ustatus.MIE=0

################  鎭㈠?嶇幇鍦?

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

################  涓?鏂?杩斿洖

j CCAB_BGE  # 保持 ISR 仍为 43 条指令
#############################################################
# 本版本保持三个 ISR 各 43 条指令，入口仍为 0x0AC/0x158/0x204。
# ISR 末尾用 j 替换 uret，进入下列例程；例程自己保护/恢复寄存器后 uret。
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

