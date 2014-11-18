module RubyExtensions
  # Helper methods to include globally
  module RailsEnvironmentExtensions
    # Enviroment helpers
    def in_environment(env, &block)
      env = /#{Regexp.quote(env)}/ if env.is_a?(String)

      if Rails.env =~ env
        block ? block.call : true
      else
        block ? nil : false
      end
    end

    def in_development(&block)
      in_environment('development', &block)
    end

    def in_production(&block)
      in_environment('production', &block)
    end

    def in_staging(&block)
      in_environment('staging', &block)
    end

    def in_test(&block)
      in_environment('test', &block)
    end

    def in_testing(&block)
      in_environment('test', &block)
    end

    def in_cloud(&block)
      in_environment(/staging|production/, &block)
    end

    def in_local(&block)
      in_environment(/test|development/, &block)
    end
  end
end
