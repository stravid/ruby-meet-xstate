require 'rubygems'
require 'bundler/setup'
require 'mini_racer'

context = MiniRacer::Context.new
context.eval 'var adder = (a,b)=>a+b;'
puts context.eval 'adder(20,22)'
