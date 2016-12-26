%%%-------------------------------------------------------------------
%%% @author oscarvalente
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 22. Dec 2016 15:44
%%%-------------------------------------------------------------------
-module(training_set).
-author("oscarbritovalente").

-import(blas, [count_matrix_columns/1]).

%% ====================================================================
%% API functions
%% ====================================================================
-export([
  count_input_variables/1,
  count_output_variables/1
]).

count_input_variables(TrainingSetInputs) -> count_matrix_columns(TrainingSetInputs).

count_output_variables(TrainingSetOutputs) -> length(TrainingSetOutputs).

%% ====================================================================
%% Internal functions
%% ====================================================================
