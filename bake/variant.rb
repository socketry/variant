
require_relative '../lib/variant'

# Select the production variant.
# @param overrides [Hash] any specific variant overrides.
def production(**overrides)
	Variant.force!(:production, **overrides)
end

# Select the staging variant.
# @param overrides [Hash] any specific variant overrides.
def staging(**overrides)
	Variant.force!(:staging, **overrides)
end

# Select the development variant.
# @param overrides [Hash] any specific variant overrides.
def development(**overrides)
	Variant.force!(:development, **overrides)
end

# Select the testing variant.
# @param overrides [Hash] any specific variant overrides.
def testing(**overrides)
	Variant.force!(:testing, **overrides)
end

# Force a specific variant.
# @param name [Symbol] the default variant.
# @param overrides [Hash] any specific variant overrides.
def force(name, **overrides)
	Variant.force!(name, **overrides)
end

# Show variant-related environment variables.
def show
	require 'console/logger'
	
	environment = ENV.select{|key, _| key.include?(Variant::KEY)}
	
	Console.logger.info("Environment", environment)
end
