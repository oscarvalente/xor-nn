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

-include_lib("core/training_set.hrl").

%% ====================================================================
%% API functions
%% ====================================================================
-export([
  create/2,
  get_inputs/1,
  get_outputs/1,
  count_variables/1
]).

create(InputSet, OutputSet) -> TrainingSet = #training_set{ inputs = InputSet, outputs = OutputSet }.

get_inputs(TrainingSet) -> Inputs = TrainingSet#training_set.inputs.

get_outputs(TrainingSet) -> Outputs = TrainingSet#training_set.outputs.

count_variables(MatrixSet) -> blas:count_matrix_columns(MatrixSet).

%% ====================================================================
%% Internal functions
%% ====================================================================
