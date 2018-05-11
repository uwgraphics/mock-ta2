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

  def traverse(descriptor, depth=0)
    message = descriptor.msgclass.new
    return message if depth > 10 # this stops infinite loops
    oneof = []
    descriptor.each_oneof { |one| oneof << one }
    if oneof.any?
      add_field_to_message(message, descriptor.entries.sample, depth)
    else
      descriptor.each do |field|
        add_field_to_message(message, field, depth)
      end
    end
    message
  end

  def add_field_to_message(message, field, depth)
    begin
      value = find_value(field, depth)
      if value.is_a?(Google::Protobuf::RepeatedField)
        value.each do |val|
          if val.respond_to?(:key)
            message[field.name][val.key] = val.value
          else
            message[field.name].push(val)
          end
        end
      else
        message[field.name] = find_value(field, depth)
      end
    rescue => error
      binding.pry
    end
  end

  def find_value(field, depth)
    case field.label
    when :repeated
      if field.type == :message
        array = Google::Protobuf::RepeatedField.new(field.type, field.subtype.msgclass, [])
      elsif field.type == :enum
        binding.pry
      else
        array = Google::Protobuf::RepeatedField.new(field.type)
      end
      Faker::Number.between(1, 10).times do
        if field.type == :message
          array << traverse(field.subtype, depth+1)
        else
          array << fake_value(field, depth)
        end
      end
      array
    else
      fake_value(field, depth)
    end
  end

  def fake_value(field, depth)
    case field.type
    when :message
      traverse(field.subtype, depth+1)
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
