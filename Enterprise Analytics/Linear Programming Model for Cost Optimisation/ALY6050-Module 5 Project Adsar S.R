#Author: Shivani Adsar
#Installing required packages
install.packages("lpSolve")
require("lpSolve")
# Set up problem: maximize
# 114.99x1 + 261.99x2 + 188.99x3 -197.01x4 subject to
# Budget :365x1 + 368x2 + 411x3 + 567x4 <= 175000
# Size :5x1 + 5x2 + 8x3 + 6x4 <= 80*30
#Allocation: x1+x2>=0.33*sum(x1+x2+x3+x4)
#inventory:2x3-X4>=0

#Coefficients of decision variables

f_coeff_decision <- c(114.99,261.99,188.99,-197.01)

#Constraints matrix 

f_constraint_lhs <- matrix (c(365,368,411,567,
                              5,8,5,6,
                              1,1,0,0,
                              0,0,2,-1), nrow=4, byrow=TRUE)

#Direction of Constraints

f_direction <- c("<=", "<=",">=",">=")

#Right Hand side for constraints

a<-maximum_profit_temp$solution
b<-0.33*sum(a)
f_right_hand_side <- c(175000,2400,b,0)
maximum_profit_temp=lp("max",f_coeff_decision,f_constraint_lhs,f_direction,f_right_hand_side)
maximum_profit_temp$solution
Maximum_Profit=lp ("max", f_coeff_decision, f_constraint_lhs, f_direction, f_right_hand_side)
Maximum_Profit$solution
Maximum_Profit$objval
summary(Maximum_Profit)


# Get sensitivities
lp ("max", f_coeff_decision, f_constraint_lhs, f_direction, f_right_hand_side, compute.sens=TRUE)$sens.coef.from
lp ("max", f_coeff_decision, f_constraint_lhs, f_direction, f_right_hand_side, compute.sens=TRUE)$sens.coef.to

#Duals
lp ("max", f_coeff_decision, f_constraint_lhs, f_direction, f_right_hand_side, compute.sens=TRUE)$duals
lp ("max", f_coeff_decision, f_constraint_lhs, f_direction, f_right_hand_side, compute.sens=TRUE)$duals.from
lp ("max", f_coeff_decision, f_constraint_lhs, f_direction, f_right_hand_side, compute.sens=TRUE)$duals.to

# Run again, this time requiring that all three variables be integer

lp ("max", f_coeff_decision, f_constraint_lhs, f_direction, f_right_hand_side, int.vec=1:3)
lp ("max", f_coeff_decision, f_constraint_lhs, f_direction, f_right_hand_side, int.vec=1:3)$solution

# Allocation of additional money
f_direction <- c(">=", "<=",">=",">=")
Maximum_Profit_Additional=lp ("max", f_coeff_decision, f_constraint_lhs, f_direction, f_right_hand_side)
Maximum_Profit_Additional$objval
Maximum_Profit_Additional$solution
#SIZE OF WAREHOUSE#

f_direction <- c("<=", ">=",">=",">=")
Size_Inventory=lp ("max", f_coeff_decision, f_constraint_lhs, f_direction, f_right_hand_side)
Size_Inventory$objval
Size_Inventory$solution

