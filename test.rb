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

def send_event(context, config, state, event)
  if state.nil?
    context.eval """
      var machine = XState.createMachine(#{config});
      var service = XState.interpret(machine).start();
      service.send('#{event}');
    """
  else
    context.eval """
      var machine = XState.createMachine(#{config});
      var state = XState.State.create(JSON.parse('#{state.to_json}'));
      var resolvedState = machine.resolveState(state);
      var service = XState.interpret(machine).start(resolvedState);
      service.send('#{event}');
    """
  end
end

a = send_event(context, config, nil, 'DECLINE')
b = send_event(context, config, a, 'DB_DONE')
c = send_event(context, config, b, 'HTTP_DONE')

puts a
puts b
puts c
