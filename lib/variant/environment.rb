# frozen_string_literal: true

# Copyright, 2016, by Samuel G. D. Williams. <http://www.codeotaku.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require 'thread/local'

module Variant
	DEVELOPMENT = :development
	PRODUCTION = :production
	TESTING = :testing
	STAGING = :staging
	
	class Environment
		extend Thread::Local
		
		# It is not safe to modify ENV.
		def initialize(overrides = {}, default: DEVELOPMENT)
			@overrides = overrides
		end
		
		attr :overrides
		
		def with(overrides)
			old_overrides = @overrides
			@overrides = overrides
			
			yield self
		ensure
			@overrides = old_overrides
		end
		
		def to_hash
			ENV.to_hash.update(@overrides)
		end
		
		def fetch(key, *arguments, &block)
			@overrides.fetch(key) do
				ENV.fetch(key, *arguments, &block)
			end
		end
		
		def default_variant
			self.fetch('VARIANT', DEVELOPMENT).to_sym
		end
		
		def default_variant= name
			@overrides['VARIANT'] = name
		end
		
		def variant_for(name, default = DEVELOPMENT)
			self.fetch(variant_key(name)) do
				self.fetch('VARIANT', default)
			end&.to_sym
		end
		
		def override_variant(name, value)
			@overrides[variant_key(name)] = value
		end
		
		def variant_key(name)
			"#{name.upcase}_VARIANT"
		end
	end
end
