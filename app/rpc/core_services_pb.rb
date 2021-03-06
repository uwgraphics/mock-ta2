# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: core.proto for package ''

require 'grpc'
require 'core_pb'

module Core
  # See each message's comments for information about each particular call.
  class Service

    include GRPC::GenericService

    self.marshal_class_method = :encode
    self.unmarshal_class_method = :decode
    self.service_name = 'Core'

    rpc :SearchSolutions, SearchSolutionsRequest, SearchSolutionsResponse
    rpc :GetSearchSolutionsResults, GetSearchSolutionsResultsRequest, stream(GetSearchSolutionsResultsResponse)
    rpc :EndSearchSolutions, EndSearchSolutionsRequest, EndSearchSolutionsResponse
    rpc :StopSearchSolutions, StopSearchSolutionsRequest, StopSearchSolutionsResponse
    rpc :DescribeSolution, DescribeSolutionRequest, DescribeSolutionResponse
    rpc :ScoreSolution, ScoreSolutionRequest, ScoreSolutionResponse
    rpc :GetScoreSolutionResults, GetScoreSolutionResultsRequest, stream(GetScoreSolutionResultsResponse)
    rpc :FitSolution, FitSolutionRequest, FitSolutionResponse
    rpc :GetFitSolutionResults, GetFitSolutionResultsRequest, stream(GetFitSolutionResultsResponse)
    rpc :ProduceSolution, ProduceSolutionRequest, ProduceSolutionResponse
    rpc :GetProduceSolutionResults, GetProduceSolutionResultsRequest, stream(GetProduceSolutionResultsResponse)
    rpc :SolutionExport, SolutionExportRequest, SolutionExportResponse
    rpc :UpdateProblem, UpdateProblemRequest, UpdateProblemResponse
    rpc :ListPrimitives, ListPrimitivesRequest, ListPrimitivesResponse
    rpc :Hello, HelloRequest, HelloResponse
  end

  Stub = Service.rpc_stub_class
end
