require 'rubygems'
require 'bundler/setup'
require 'mini_racer'

snapshot = MiniRacer::Snapshot.new([
  'var global = global || {};',
  'global.console = console || { log: () => {} };',
  File.read('./xstate.js'),
].join("\n"))
context = MiniRacer::Context.new(snapshot: snapshot)

context.attach("console.log", proc{|*args| puts args })

context.eval File.read('./example.js')
