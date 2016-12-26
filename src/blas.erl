%%%-------------------------------------------------------------------
%%% @author oscarvalente
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 22. Dec 2016 11:46
%%%-------------------------------------------------------------------
-module(blas).
-author("oscarbritovalente").

%% ====================================================================
%% API functions
%% ====================================================================
-export([count_matrix_columns/1]).

count_matrix_columns(Matrix) -> length(lists:nth(1, Matrix)).
