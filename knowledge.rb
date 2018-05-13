class Module
  def attribute(arg, &block)
    arg, val = arg.first if arg.is_a?(Hash)

    define_method "#{arg}" do
      unless instance_variable_defined?(:"@#{arg}")
        instance_variable_set(:"@#{arg}", block_given? ? instance_eval(&block) : val)
        # instance_variable_set(:"@#{arg}", val) if val
        # instance_variable_set(:"@#{arg}", instance_eval(&block)) if block_given?
      end
      instance_variable_get(:"@#{arg}")
    end

    define_method "#{arg}=" do |val|
      instance_variable_set(:"@#{arg}", val)
    end

    define_method "#{arg}?" do
      true if instance_variable_get(:"@#{arg}")
    end
  end
end
