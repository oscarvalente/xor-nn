-module(xor_nn_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
  io:format("wtfff!"),
  xor_nn_sup:start_link().

stop(_State) ->
  ok.
