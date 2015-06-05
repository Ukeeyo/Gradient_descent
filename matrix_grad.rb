require('matrix')



# This version of gradient descent utilizes the Ruby matrix class. It is much slower than looping through arrays that represent vectors




x = Matrix[[2,2,2],[2,2,2]]

column1=[]
column2=[]
File.open( 'ex1data1.txt' ).each do |line|
  array = line.split(',')
  array[1].gsub!(/\n/, '')

  column1.push(array[0].to_f)
  column2.push(array[1].to_f)
end

x = [column1]
y = column2
iterations = 1500
alpha = 0.01



def gd(x, y, alpha, iterations)
  m = y.length
  x.unshift(Array.new(m, 1.0))
  n = x.length
  y = Matrix.columns([y])
  x = Matrix.columns(x)
  thetas = Matrix.columns([Array.new(n,0)])

    # thetas = Matrix.columns([[0.058391,0.045693]])
    1500.times do
      h = []
      for i in 0...m do
        h.push(calc_h(thetas.column(0), x.row(i)))
      end

      h = Matrix.columns([h])
      new_thetas = []
      for i in 0...n do
        new_thetas.push(calc_theta(thetas[i,0], x.column(i), alpha, m, h, y))
      end

      thetas = Matrix.columns([new_thetas])
    end
    p thetas
end


  def calc_h(theta, x)
    theta_m = Matrix.columns([theta.to_a])
    x_m = Matrix.columns([x.to_a])
    (theta_m.transpose*x_m)[0,0]
  end

  def calc_theta(theta, x, alpha, m, h, y)
    sum = 0
    (h-y).row_vectors.each_with_index do |row, i|
      sum += (row[0] * x[i])
    end
    theta - alpha * 1/m * sum
  end

  gd(x, y, alpha, iterations)