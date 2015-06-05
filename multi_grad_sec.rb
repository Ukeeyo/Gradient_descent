def compute_cost(features, results, thetas)
  m = results.length.to_f
  n = features.length.to_f
  sum = 0.0
  h = Array.new(m, 0)
  for i in 0...m do
    for vector in 0...n do
      h[i]+=(thetas[vector] * features[vector][i])
    end
  end
  h.each_with_index {|hyp, i|
    sum += ((hyp-results[i])**2)
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
      vector[i] = ((vector[i] - mean)/sigma)
      vector[i] = vector [i]
    end
  end
  return features
end

def calc_h(thetas, features, m, n)
  h = Array.new(m, 0.0)
  for i in 0..m-1 do
    for vector in 0..n-1 do
      h[i]+=(thetas[vector] * features[vector][i])
      h[i] = h[i]
    end
  end
  return h
end

def calc_sum(results, features, h, n)
  sum = {}
  for i in 0...n do
    sum['theta'+i.to_s] = 0.0
  end
  for i in 0...h.length do
    for vector in 0...n do
      sum['theta'+vector.to_s] += ((h[i]-results[i])*features[vector][i])
    end
  end
  return sum
end

def gradient_descent(features, results, alpha, iterations)
  # features = feature_norm(features)
  m = results.length.to_f
  features.unshift(Array.new(m, 1))
  n = features.length.to_f
  thetas = Array.new(n, 0.0)

  iterations.times do
    h = calc_h(thetas, features, m, n)
    sum = calc_sum(results, features, h, n)

    for i in 0..thetas.length-1 do
      thetas[i] = (thetas[i] - alpha * (1.0/m) * sum['theta'+i.to_s])
    end
  end
  p thetas
end

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
iterations = 1500
alpha = 0.01


gradient_descent([x], y, alpha, iterations)


