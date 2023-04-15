import random
import matplotlib.pyplot as plt

n = 20
p = 0.5

integers = list(range(1, n+1))
if n % 2 == 1:
    integers.append(0)
data = [integers.copy()]

for t in range(1, n):
    if t % 2 == 0:    # even time step
        for i in range(1, n-1, 2):   # even integer
            if i % 2 == 1:
                if random.random() < p:
                    integers[i], integers[i+1] = integers[i+1], integers[i]
    else:           # odd time step
        for i in range(0, n-1, 2):  # odd integer
            if i % 2 == 0:
                if random.random() < p:
                    integers[i], integers[i+1] = integers[i+1], integers[i]

    data.append(integers.copy())

# Plot the positions of the integers over time
for i in range(n+1):
    positions = [step[i] for step in data]
    plt.plot(range(n), positions, label=f"Integer {i+1}")

plt.xlabel("Time Step")
plt.ylabel("Position")
plt.title("Positions of Integers over Time")
plt.legend()
plt.show()
