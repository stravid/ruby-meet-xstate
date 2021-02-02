require 'rubygems'
require 'bundler/setup'
require 'mini_racer'

snapshot = MiniRacer::Snapshot.new([
  'var global = global || {};',
  'global.console = console || { log: () => {} };',
  File.read('./xstate.js'),
  File.read('./adder.js'),
].join("\n"))
context = MiniRacer::Context.new(snapshot: snapshot)

context.attach("console.log", proc{|*args| puts args })

puts context.eval 'adder(20,22)'
context.eval File.read('./machine.js')
