
column1=[]
column2=[]
File.open( 'ex1data1.txt' ).each do |line|
  array = line.split(',')
  array[1].gsub!(/\n/, '')

  column1.push(array[0].to_f)
  column2.push(array[1].to_f)
end

x = column1
y = column2
theta = [0,0]

iterations = 1500
alpha = 0.01


def compute_cost(x_col, y_col, theta)
  h_col = Array.new(x_col.length, 0)
  m = x_col.length
  sum = 0

  x_col.each_with_index {|x, i|
    h_col[i] = theta[0] + (theta[1] * x)
  }

  h_col.each_with_index {|h, i|
    sum += ((h-y_col[i])**2)
  }

  j =(1.0/(2.0*m))*sum
end

def feature_norm(features)
  features.each do |vector|
    mean = vector.inject(:+) / vector.length.to_f
    sum = vector.inject(0){|accum, i| accum + (i - mean) ** 2 }
    varience = sum / (vector.length - 1).to_f
    sigma = Math.sqrt(varience)
    for i in 0..vector.length-1 do
      vector[i] = (vector[i] - mean)/sigma
    end
  end
  return features
end

def gradient_descent(x_col, y_col, alpha, theta, iterations)

  h_col = Array.new(x_col.length, 0)
  m = y_col.length.to_f
  count = 0
  iterations.times do
    count +=1
    sum = {theta0: 0.0, theta1: 0.0}

    x_col.each_with_index {|x, i|
      h_col[i] = (theta[0] + (theta[1] * x))
    }



    h_col.each_with_index {|h, i|
      sum[:theta0] += (h-y_col[i])
      sum[:theta1] += ((h-y_col[i])*x_col[i])
    }

    theta0 = theta[0] - alpha * (1.0/m) * sum[:theta0]
    theta1 = theta[1] - alpha * (1.0/m) * sum[:theta1]

    theta[0] = theta0
    theta[1] = theta1

    array = [1]
  end
  p theta
end
gradient_descent(x, y, alpha, theta, iterations)


