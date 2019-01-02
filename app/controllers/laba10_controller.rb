require 'json'

class Laba10Controller < ApplicationController
  def input; end

  def allinxml
    code = []
    1.upto(Model.count) { |i| code.push(JSON.parse(Model.find(i)[:result])) }
    render :xml => code
  end

  def output
    @v1 = params[:v1]
    if !(@v1 =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/).nil?
      if Model.find_by(num: @v1).nil?
        @result = root(@v1)
        Model.create(num: @v1, result: @result.map { |x| { elem: x } }.to_json)
      else
        arr = JSON.parse(Model.find_by(num: @v1)[:result])
        @result = arr.flat_map { |x| x.values }
        @mean = @result[@result.size - 1]
      end
    else @result = 'error'
    end
  end

end

def float?(str)
  true if Float(str) rescue false
end

def root(num)
  if float?(num) && num.to_f.positive?
    prev = rand(1..num.to_i).to_f
    curr = (prev + num.to_f / prev) / 2.0
    arr = [].push(curr)
    loop do
      arr.push(curr = (curr + num.to_f / curr) / 2.0)
      break if ((curr**2 - num.to_f) / num.to_f) < 1e-3
    end
  else
    arr = 'error'
  end
  arr = 0 if num == '0'
  arr
end