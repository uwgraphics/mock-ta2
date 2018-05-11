class CoreController < ::Gruf::Controllers::Base
  bind ::Core::Service

  ##
  # @return [Demo::GetJobResp] The job response
  #
  def search_solutions
    # thing = SearchSolutionsRequest.find(request.message.id)
    SearchSolutionsResponse.new(search_id: Faker::Crypto.md5)
  rescue
    fail!("Couldn't start search. :(")
  end

  def get_search_solutions_results
    traverse(GetSearchSolutionsResultsResponse.descriptor)
  end

  def end_search_solutions
    traverse(EndSearchSolutionsResponse.descriptor)
  end

  def stop_search_solutions
    traverse(StopSearchSolutionsResponse.descriptor)
  end

  def describe_solution
    traverse(DescribeSolutionResponse.descriptor)
  end

  def score_solution
    traverse(ScoreSolutionResponse.descriptor)
  end

  def get_score_solution_results
    traverse(GetScoreSolutionResultsResponse.descriptor)
  end

  def fit_solution
    traverse(FitSolutionResponse.descriptor)
  end

  def get_fit_solution_results
    traverse(FitSolutionResponse.descriptor)
  end

  def produce_solution
    traverse(ProduceSolutionResponse.descriptor)
  end

  def get_produce_solution_results
    traverse(GetProduceSolutionResultsResponse.descriptor)
  end

  def solution_export
    traverse(SolutionExportResponse.descriptor)
  end

  def update_problem
    traverse(UpdateProblemResponse.descriptor)
  end

  def list_primatives
    traverse(ListPrimitives.descriptor)
  end

  def hello
    traverse(HelloResponse.descriptor)
  end

  private

  def traverse(descriptor)
      message = descriptor.msgclass.new
      descriptor.each do |field|
        begin
        message[field.name] = case field.label
        when :repeated
          (1..Faker::Number.between(1, 10)).map do
            fake_value(field)
          end
        else
          fake_value(field)
        end
        rescue TypeError
        end
      end
      message
  end

  def fake_value(field)
    case field.type
    when :message
      traverse(field.subtype)
    when :enum
      field.subtype.enummodule.constants.sample
    when :string
      Faker::Pokemon.name
    when :int32
      Faker::Number.between(1, 100)
    when :bool
      Faker::Boolean.boolean
    when :double
      Faker::Number.normal(50, 3.5)
    when :int64
      Faker::Number.between(101, 100000)
    when :bytes
      Faker::Code.asin
    else
      nil
    end
  end


end
