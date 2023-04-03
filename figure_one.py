import random
import plotly.graph_objects as go

n = 9 
p = 0.5  

integers = list(range(1, n+1))
if n % 2 == 1:
    integers.append(0)  
data = [integers.copy()]


for t in range(0, n):
    if t % 2 == 1:  # odd time step
        for i in range(0, n, 2):
            if random.random() < p:                
                integers[i], integers[i+1] = integers[i+1], integers[i]
    else:  # even time step
        for i in range(0, n, 2):
            if random.random() < p:
                integers[i], integers[i+1] = integers[i+1], integers[i]
    
    data.append(integers.copy())

# Create plot
fig = go.Figure()
for i in range(len(data[0])):
    x = [t for t in range(n)]
    y = [data[t][i] for t in range(n)]
    fig.add_trace(go.Scatter(x=x, y=y, mode='lines+markers', name=f'Element {i+1}'))

fig.show()
