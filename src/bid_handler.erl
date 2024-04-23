-module(bid_handler).
-behaviour(cowboy_handler).

-export([init/2]).

init(Req, State) ->
    {Method, Req1} = cowboy_req:method(Req),
    case Method of
        <<"POST">> ->
            {ok, Body, Req2} = cowboy_req:read_body(Req1),
            Bid = process_bid(Body),
            reply(200, #{<<"content-type">> => <<"application/json">>}, Bid, Req2),
            {ok, Req2, State};
        _ ->
            cowboy_req:reply(405, #{<<"allow">> => <<"POST">>}, Req)
    end.

process_bid(Body) ->
    %% Process the bid request here and generate a response
    io:format("Received bid: ~p~n", [Body]),
    #{<<"bid">> => <<"accepted">>}.

reply(Status, Headers, Body, Req) ->
    cowboy_req:reply(Status, Headers, jsx:encode(Body), Req).
