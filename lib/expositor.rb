module Expositor
  def method_missing(method_name, *args, &block)
    if expose_all? || valid_method?(method_name)
      new(*args).send(method_name)
    else
      super
    end
  end

  def expose(only: nil, except: nil)
    @only   = only   || []
    @except = except || []
  end

  private

  def valid_method?(method_name)
    if @only.empty?
      !@except.include?(method_name)
    else
      @only.include?(method_name) && !@except.include?(method_name)
    end
  end

  def expose_all?
    @only.nil? && @except.nil?
  end
end
