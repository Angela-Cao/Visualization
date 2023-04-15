import random
import plotly.graph_objects as go

n = 20  
p = 0.5 
T = 50 # time step

integers = list(range(1, n+1))
if n % 2 == 1:
    integers.append(0)  
data = [integers.copy()]
all_ancestors = [list(range(0,T))]

for t in range(1, T):
    ancestor = list(range(0,n))
    if t % 2 == 0:    # even time step
       for i in range(1, n-1, 2):   # even integer
           if i % 2 == 1: 
                if random.random() < p: 
                    integers[i], integers[i+1] = integers[i+1], integers[i]
                    ancestor[i] = i+1
                    ancestor[i+1] = i
    else:           # odd time step
        for i in range(0, n-1, 2):  # odd integer
            if i % 2 == 0:
                if random.random() < p:
                    integers[i], integers[i+1] = integers[i+1], integers[i]
                    ancestor[i] = i+1
                    ancestor[i+1] = i
    data.append(integers.copy())
    all_ancestors.append(ancestor.copy())

# Create plot
fig = go.Figure()
for i in range(len(data[0])):   
    x = [t for t in range(T)]
    numbers = [data[T-1][i]]
    ancestor_i = i 
    y = [i]
    for t in range(T-1, 0, -1):       
       ancestor_i = all_ancestors[t][ancestor_i] 
       y.append(ancestor_i)
       numbers.append(data[t-1][ancestor_i]) 
    y.reverse()  
    numbers.reverse()
    print(y)
    fig.add_trace(go.Scatter(x=x, y=y, mode='lines+markers', name=f'Element {i+1}'))

fig.update_layout(
    plot_bgcolor='white',
    showlegend=False,
    xaxis=dict(showgrid=True, gridcolor='lightgray', gridwidth=1, showline=True, linewidth=2, linecolor='black'),
    yaxis=dict(showgrid=True, gridcolor='lightgray', gridwidth=1, showline=True, linewidth=2, linecolor='black')
)

fig.show()