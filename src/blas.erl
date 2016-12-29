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
-export([
 count_matrix_columns/1,
 transpose_matrix/1
]).

count_matrix_columns(Matrix) -> length(lists:nth(1, Matrix)).

transpose_matrix(Matrix) ->
	attach_row(Matrix, []).
  
attach_row([], Result) ->
  reverse_rows(Result, []);

attach_row(RowList, Result) ->
  [FirstRow | OtherRows] = RowList,
  NewResult = make_column(FirstRow, Result, []),
  attach_row(OtherRows, NewResult).
                                         
make_column([], _, New) -> lists:reverse(New);
  
make_column(Row, [], Accumulator) ->
  [RowHead | RowTail] = Row,
  make_column(RowTail, [], [[RowHead] | Accumulator]);
  
make_column(Row, Result, Accumulator) ->
  [RowHead | RowTail] = Row,
  [ResultHead | ResultTail] = Result,
  make_column(RowTail, ResultTail, [[RowHead | ResultHead] | Accumulator]).

reverse_rows([], Result) -> lists:reverse(Result);

reverse_rows(Rows, Result) ->
  [First | Others] = Rows,
  reverse_rows(Others, [lists:reverse(First) | Result]).