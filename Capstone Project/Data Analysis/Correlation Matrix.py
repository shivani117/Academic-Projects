#!/usr/bin/env python
# coding: utf-8

# In[4]:


import pandas as pd
data = pd.read_csv(r"D:\Data\Northeastern University\Capstone\Module 8\Group_Data_Version2_csv.csv")


# In[5]:


print(data)


# In[9]:


matrix = data.corr()


# In[15]:


import seaborn as sn
import matplotlib.pyplot as plt
print("Correlation Matrix is : ")
print(matrix)


# In[16]:


sn.heatmap(matrix, annot=True)
plt.show()


# In[41]:


df_small = data.iloc[:,:25]


# In[42]:


import seaborn as sns
correlation_mat = df_small.corr()

sns.heatmap(correlation_mat, annot = True)

plt.show()

