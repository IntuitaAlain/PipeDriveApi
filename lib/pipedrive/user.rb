module Pipedrive
  class User < Base
    include ::Pipedrive::Operations::Read
    include ::Pipedrive::Utils

    def find_by_name(*args)
      params = args.extract_options!
      params[:term] ||= args[0]
      unless params[:term]
        fail 'term is missing'
      end
      params[:search_by_email] ||= args[1] ? 1 : 0
      unless block_given?
        return to_enum(:find_by_name, params)
      end
      follow_pagination(:make_api_call, [:get, 'find'], params) { |item| yield item }
    end
  end
end
