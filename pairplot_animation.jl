#import Pkg; Pkg.add("StatsPlots")
#import Pkg; Pkg.add("KernelDensity")
#import Pkg; Pkg.add("DataFrames")
using Random

function generate_random_norm(n::Int, mean::Real, std::Real)
    random_numbers = randn(n) .* std .+ mean    
    return random_numbers
end

n = 5
mean_value = 0.0
std_dev = 1.0

random_1 = generate_random_norm(n, mean_value, std_dev)
random_2 = generate_random_norm(n, mean_value, std_dev)

println("Random 1: ", random_1)
println("Random 2: ", random_2)


using Plots
using StatsPlots, KernelDensity

function generate_data(num_points)
    x1 = generate_random_norm(num_points, 1, 1) 
    x2 = generate_random_norm(num_points, 2, 0.5) 
    x3 = generate_random_norm(num_points, 3, 2) 
    x4 = generate_random_norm(num_points, -1, 1) 
    x5 = generate_random_norm(num_points, -2, 0.5) 
    x6 = generate_random_norm(num_points, -3, 2) 
    return x1, x2, x3, x4, x5, x6
end

num_datapoints = 100
x1, x2, x3, x4, x5, x6 = generate_data(num_datapoints)  
println(x1)
println(x2)

# plot()
# dens = kde((x1,x2))
# plot(dens)

# animation = @animate for i in 1:num_datapoints    
#     scatter!([x1[i]], [x2[i]],  color=:blue, markersize=5, legend = false)
# #     plot!(
# #         x[1:i],
# #         y[1:i],
# #         markershape=:circle,
# # #        label="Point $(i)",
# #         seriestype=:scatter,
# #         legend = false, 
# #         xlim=(-3, 3), ylim=(-3, 3)
#  #   )
# end
# gif(animation, "pairplot_animation.gif", fps = 2)



using DataFrames
using Statistics
using Plots.PlotMeasures

data = DataFrame(
    x1 = x1,
    x2 = x2,
    x3 = x3,
    x4 = x4,
    x5 = x5,
    x6 = x6
)

println(names(data))
none = Int[]
function pair_plot(df::DataFrame)
    nvars = ncol(df)

    p = plot(layout=(nvars, nvars), legend=false, size=(1200, 1200), framestyle=:box, left_margin=5mm)

    for j in 1:nvars     
        for i in 1:nvars    
            if i == j
                histogram!(p[i, i], df[!, i], bins=20, alpha=0.7) 
            else
                if i < j
                    dens = kde((df[!, j], df[!, i]))      
                    plot!(p[j, i],dens)             
                else
                    xticks!(p[j,i], none)  
                    yticks!(p[j,i], none)
                    xaxis!(p[j,i],bordercolor="white")
                    yaxis!(p[j,i],bordercolor="white")
                end
            end

            if j == nvars                    
                xlabel!(p[j, i], names(df)[i])        
            else
                xticks!(p[j, i], none)
            end

            if i == 1                              
                ylabel!(p[j, i], names(df)[j])     
            else
                yticks!(p[j,i], none)
            end
        end
    end
    animation = @animate for k in 1:num_datapoints    
        for j in 1:nvars
            for i in 1:j
                if i != j
                    scatter!(p[j, i],  [df[k, j]], [df[k, i]],  color=:green, markersize=2, legend = false)
                end
            end
        end
    end
    return animation
end


animation = pair_plot(data)
gif(animation, "pairplot_animation.gif", fps = 5)

