require 'rubygems'
require 'bundler/setup'
require 'mini_racer'

snapshot = MiniRacer::Snapshot.new([
  'var global = global || {};',
  'global.console = console || { log: () => {} };',
  File.read('./xstate.js'),
].join("\n"))
context = MiniRacer::Context.new(snapshot: snapshot)
config = File.read('./bid.js')

context.attach("console.log", proc{|*args| puts args })

def send_event(context, config, event)
  context.eval """
    const machine = XState.createMachine(#{config});
    const service = XState.interpret(machine).start();
    service.send('#{event}');
  """
end

puts send_event(context, config, 'DECLINE')
