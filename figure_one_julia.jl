using Random
using Plots

n = 20
p = 0.5
T = 30 # time step

integers = collect(1:n)

if isodd(n)
      push!(integers, 0)
end

data = [copy(integers)]
all_ancestors = [collect(1:T)] 

for t in 1:T
      ancestor = collect(1:n)
      if isodd(t)     # time point t is an odd number 
            for i in 1:n-1
                  if isodd(i)
                        if rand() < p
                              integers[i], integers[i+1] = integers[i+1], integers[i]
                              ancestor[i] = i+1
                              ancestor[i+1] = i
                        end
                  end
            end
      else          # time point t is an even number 
            for i in 1:n-1
                  if iseven(i)
                        if rand() < p
                              integers[i], integers[i+1] = integers[i+1], integers[i]
                              ancestor[i] = i+1
                              ancestor[i+1] = i
                        end
                  end
            end
      end
      push!(data, copy(integers))
      push!(all_ancestors, copy(ancestor))
end
println(data)
plot()

for i in 1:(length(data[1]))
      x = collect(1:T)
      numbers = [data[T][i]]
      ancestor_i = i

      y = [i]
      for t in T-1:-1:1
            ancestor_i = all_ancestors[t][ancestor_i]
            push!(y, ancestor_i)
            if ancestor_i > length(data[t])
                  push!(numbers, 0)
            else
                  push!(numbers, data[t][ancestor_i])
            end
      end
      reverse!(y)
      reverse!(numbers)
      display(plot!(
            x,
            y,
            markershape=:circle,
            label="Element $(i+1)",
            linewidth=2,
            markersize=2,
            legend = false
      ))
end

display(plot)  