%%%-------------------------------------------------------------------
%% @doc high_performing_server public API
%% @end
%%%-------------------------------------------------------------------

-module(high_performing_server_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile([
        {'_', [
            {"/bid", bid_handler, []}
        ]}
    ]),
    {ok, _} = cowboy:start_clear(my_http_listener, [{port, 8080}], #{
        env => #{dispatch => Dispatch}
    }),
    high_performing_server_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
