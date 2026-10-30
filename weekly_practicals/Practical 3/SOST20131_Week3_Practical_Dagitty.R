# SOST20131 / SOST30031
# WEEK 3 PRACTICAL: CAUSAL DAGs WITH DAGITTY
#
# The focus is causal reasoning: confounders, mediators, colliders,
# backdoor paths, and adjustment sets.


# ============================================================
# SESSION AIMS
# ============================================================
# By the end of this practical, you should be able to:
#
# 1. Represent causal assumptions using a directed acyclic graph (DAG).
# 2. Distinguish confounders, mediators, and colliders.
# 3. Identify backdoor paths between an exposure and an outcome.
# 4. Use Dagitty to identify sufficient adjustment sets.
# 5. Explain why adjusting for every available variable can be a mistake.


# ============================================================
# 0. SET-UP
# ============================================================
# We will use the R package "dagitty".
#
# Install this package ONLY if you do not already have it:

# install.packages("dagitty")
library(dagitty)


# You can also explore the same DAGs visually using the Dagitty web interface:
# https://dagitty.net/dags.html


# ============================================================
# RESEARCH QUESTION
# ============================================================
# We will use one substantive question throughout:
#
#   What is the TOTAL causal effect of education on earnings?
#
# Exposure: Education
# Outcome: Earnings
#
# IMPORTANT:
# A DAG does not prove that the arrows are correct.
# It represents the causal assumptions we are making.


# ============================================================
# 1. A SIMPLE DAG: CONFOUNDING
# ============================================================
# Suppose parental socioeconomic position (Parental_SES) affects both:
#   - a person's education
#   - their later earnings
#
# Complete the DAG below by adding the missing arrows.
#
# Expected causal assumptions:
#   Parental_SES -> Education
#   Parental_SES -> Earnings
#   Education -> Earnings

dag1 <- dagitty('dag {
  Education [exposure]
  Earnings [outcome]
  Parental_SES -> Education;
  Parental_SES -> Earnings;
  Education -> Earnings


}')

plot(dag1)


# QUESTIONS
#
# Q1. What is the causal path from Education to Earnings?
# This is Education -> Earnings
#
# Q2. Is there a backdoor path between Education and Earnings?
#     Yes, this is Education <- Parental_SES -> Earnings
#     This is a backdoor path as it enters education
#
# Q3. Which variable is the confounder? Parental_SES is a confounder
# as it is a common cause of education and earnings (points into both)
#
# Q4. Before asking Dagitty, which variable do you think we should adjust for?
#   Adjust for Parental_SES as this is a confounder and provides backdoor path
# Now ask Dagitty:
adjustmentSets(dag1)
#
# Q5. Does Dagitty agree with your answer? Yes, it identifies PArental_SES as a
# sufficient adjustment set
#
# Optional: list the paths between Education and Earnings.
paths(dag1, from = "Education", to = "Earnings")


# ============================================================
# 2. ADDING A MEDIATOR
# ============================================================
# Now suppose education affects occupation, which then affects earnings.
#
# Add Occupation as a mediator:
#
#   Education -> Occupation -> Earnings
#
# Keep the relationships from DAG 1.
dag2 <- dagitty('dag {
    Education [exposure]
    Earnings [outcome]
                
    Parental_SES -> Education;
    Parental_SES -> Earnings;
    Education -> Earnings;
    Education -> Occupation;
    Occupation -> Earnings
                
                
}')



plot(dag2)


# QUESTIONS
#
# Q6. What role does Occupation play in this DAG? Occupation is a mediator
# between the exposure-Education and the outcome earnings as it is affected by
# education but affects earnings
#
# Q7. We want the TOTAL effect of Education on Earnings.
#     Should we adjust for Occupation? Why or why not?

#      Not if we want to know the total causal effect of education on earnings
#      this is because adjusting for occupation would block 1 of the causal paths
#      between the exposure and the outcome

# Q8. Ask Dagitty for a sufficient adjustment set.
adjustmentSets(dag2)
#
# Q9. Is Occupation included in the adjustment set? No it is not as we are 
# looking for the total effect.
#
# Q10. What part of the causal effect would we remove if we controlled
#      for Occupation?
#         We would remove the partial causal effect represented by 
#         Education -> Occupation -> Earnings, thus the remaining effect will no
#         longer include total effect of education on earnings


# ============================================================
# 3. ADDING A COLLIDER
# ============================================================
# Now consider employment status.
#
# Suppose:
#   Education -> Employment
#   Health -> Employment
#   Health -> Earnings
#
# Employment is therefore a common effect of Education and Health.
#
# Complete the DAG.

dag3 <- dagitty('dag {
  Education [exposure]
  Earnings [outcome]

  Parental_SES -> Education
  Parental_SES -> Earnings

  Education -> Earnings
  Education -> Occupation
  Occupation -> Earnings

  
  Education -> Employment
  Health -> Employment
  Health -> Earnings

}')

plot(dag3)


# QUESTIONS
#
# Q11. What role does Employment play on the path:
#
#      Education -> Employment <- Health -> Earnings
#      Employment acts as a collider as it is pointed into by Health and Educ
#
# Q12. Is this path open or closed if we do NOT condition on Employment? 

#       if we do not control for Employment then we will have a closed path-
#       colliders close paths by default.

#
# Q13. What can happen if we control for Employment?
#       If we control for employment i.e., a collider, we will open a path
#       education -> employment <- health -> earnings, which can induce an 
#       association between educ and health and create a collider bias

# Q14. Imagine that our dataset contains earnings only for people who are
#      currently employed. Why could this create a problem?
#       By only including employed people we are conditioning on employment,
#       thus creating an open non causal path between educ and earnings (collider bias)
# 
# Now ask Dagitty for an adjustment set for the TOTAL effect:
adjustmentSets(dag3)
#
# Q15. Does Dagitty tell us to adjust for: 
#      (a) Parental_SES?
#      (b) Occupation?
#      (c) Employment?
#
# Explain each answer using the terms confounder, mediator, and collider.

# a) it tells us to adjust for Parental_SES. This is a confounder,& by adjusting
#   for it we are blocking Education <- Parental_SES -> Earnings
# 
# b) No, as occupation is a mediator and since we are looking for the total effect
#     we should include it as it lies on a causal pathway
# 
# c) No, as this is a collider, and if controlled for it will lead to the inclusion of
#     a non causal pathway between education and earnings in the total effect, thus#
#     introducing collider bias. -COLLIDER ON AN OTHERWISE BLOCKED PATH
# ============================================================
# 4. EXTENSION: MODIFY THE DAG
# ============================================================
# Choose ONE of the following:
#
# A. Add Age as a common cause of Education and Earnings.
# B. Add Ability as a common cause of Education and Earnings

#A.
dag4 <- dagitty('dag {
                 Education [exposure]
                 Earnings [outcome]
                 
                 Education -> Earnings
                 Education -> Occupation
                 Education -> Employment
                 
                 Age -> Education
                 Age -> Earnings
                 
                 Parental_SES -> Education
                 Parental_SES -> Earnings
                 
                 Health -> Employment
                 Health -> Earnings
                 
                 Occupation -> Earnings
}')

plot(dag4)
adjustmentSets(dag4)
#B. 
dag5 <- dagitty('dag {
        Education [exposure]
        Earnings [outcome]
        
        Education -> Earnings
        Education -> Occupation
        Education -> Employment
        
        Parental_SES -> Earnings
        Parental_SES -> Education
        
        Health -> Earnings
        Health -> Employment
        
        Occupation -> Earnings
        
        Ability -> Education
        Ability -> Earnings
                
}')

plot(dag5)
adjustmentSets(dag5)

# in both these cases, ability and age are both confounders of educ and earnings
# and therefore must be controlled for when assessing the total effect between
# exposure and outcome this would include a non causal pathway between them.
# Both would be controlled for alongside Parental_SES.